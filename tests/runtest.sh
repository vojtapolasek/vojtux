#!/bin/bash

set -x

RUN_START=$(date +%s)
TEST_REPORT_FILE="/tmp/artifacts/report_$1.html"

# The graphical session the suite drives. The live image logs this user in on
# its own: ks/vojtux_en_ci.ks drops in a lightdm autologin configuration.
SESSION_USER=liveuser
# The process that marks the session as up. Waiting for this exact process,
# and not for a command line that mentions it, is what makes attaching work:
# lightdm starts the session through the wrapper that Fedora configures in
# /usr/share/lightdm/lightdm.conf.d/50-session-wrapper.conf, so for the first
# seconds of a session there are processes whose command line reads
#   /bin/sh /etc/X11/xinit/Xsession mate-session
#   ssh-agent /bin/sh -c exec -l $SHELL -c "mate-session"
# while /usr/bin/mate-session itself has not been exec'd yet. dogtail's own
# wait is a substring match on `ps axw`, so it is satisfied by those wrappers,
# and its next step - scanning /proc for a process whose exe is the session
# binary - then finds nothing and ends with
#   Could not get environment from initial session binary /usr/bin/mate-session
# Hence: --dont-start below, so the runner only binds to a session this script
# has already confirmed to be running.
SESSION_BINARY=/usr/bin/mate-session
SESSION_WAIT_TRIES=${SESSION_WAIT_TRIES:-60}
SESSION_WAIT_DELAY=${SESSION_WAIT_DELAY:-5}

echo "RUNTEST executed for test $1"
echo "TIMEMARK: $RUN_START"

# Written by the test, which runs as $SESSION_USER.
install -d -m 1777 /tmp/artifacts

# Print what the session actually looks like: a CI run is otherwise blind to
# whether the session never started, died, or belongs to somebody else.
dump_session_state() {
  echo "=== session state ==="
  id
  ps -eo pid,ppid,uid,user,stat,etime,args | grep -E "mate-session|mate-wm|Xsession|lightdm|[X]org" | grep -v grep
  loginctl list-sessions || true
  echo "--- lightdm unit ---"
  systemctl status lightdm.service --no-pager -n 0 || true
  journalctl -u lightdm.service -b --no-pager | tail -n 40 || true
  echo "--- autologin configuration ---"
  cat /etc/lightdm/lightdm.conf.d/*.conf 2>/dev/null || true
}

# Setup everything just the first time around!
if [ ! -e /tmp/automation_setup_done ]; then
  # the first time LIVE image is loaded it goes in liveuser session
  echo "Stopping any running GUI session"
  systemctl stop lightdm.service
  sleep 5

  echo "Setting root password to 'redhat'"
  echo "redhat" | passwd root --stdin

  echo "Installing pip"
  dnf -y install python3-pip

  echo "Installing dogtail"
  # Pinned: 2.x dropped the rawinput.registry API used by features/steps and
  # replaced dogtail-run-headless-next with a GNOME-only dogtail-headless.
  # 1.0.8 is the latest 1.x keeping rawinput.registry and a
  # dogtail-run-headless-next that supports --dm lightdm (since 1.0.6).
  python3 -m pip install dogtail==1.0.8
  echo "Installing behave"
  python3 -m pip install behave
  echo "Installing behave-html-pretty-formatter"
  python3 -m pip install behave-html-pretty-formatter

  echo "Enable a11y for user $SESSION_USER"
  # No graphical session here, so dbus-launch gives gsettings a bus of its own;
  # the value lands in the dconf database the session reads when it starts.
  sudo -u "$SESSION_USER" env HOME="/home/$SESSION_USER" \
    dbus-launch gsettings set org.gnome.desktop.interface toolkit-accessibility true
  # some grace time
  sleep 5
  # Make the setup only once.
  touch /tmp/automation_setup_done
fi

echo "Starting the graphical session of $SESSION_USER"
systemctl start lightdm.service

# Wait for the session binary itself (exact name, exact owner): the wrappers of
# the session startup carry its name in their command line, so matching on a
# command line would report the session as up seconds too early.
SESSION_PID=""
for _ in $(seq 1 "$SESSION_WAIT_TRIES"); do
  SESSION_PID=$(pgrep -u "$SESSION_USER" -x "${SESSION_BINARY##*/}" | head -1)
  [ -n "$SESSION_PID" ] && break
  sleep "$SESSION_WAIT_DELAY"
done
if [ -z "$SESSION_PID" ]; then
  echo "no $SESSION_BINARY process owned by $SESSION_USER: lightdm autologin gave no session" >&2
  dump_session_state
  exit 1
fi
echo "Graphical session running as pid $SESSION_PID"
# Give the session a moment to finish starting the at-spi bridge the suite
# talks to before attaching to it.
sleep 10

# Run the test we are asked to run!
# behave.ini of the synced tree is picked up from the working directory, which
# main.fmf sets to this directory before calling this script.
# Bounded: behave hanging on an accessibility bus that never answers would
# otherwise eat the whole 2h duration of main.fmf.
timeout 15m sudo -u "$SESSION_USER" env HOME="/home/$SESSION_USER" USER="$SESSION_USER" \
  dogtail-run-headless-next --dont-start --dont-kill --dm lightdm \
  --session-binary "$SESSION_BINARY" \
  "behave -t $1 -f html-pretty -o $TEST_REPORT_FILE -f plain"; rc=$?

if [ $rc -ne 0 ]; then
  echo "runner failed with $rc" >&2
  dump_session_state
fi

# Mark result FAIL or PASS depending on the test result.
RESULT="FAIL"
if [ $rc -eq 0 ]; then
  RESULT="PASS"
fi

# Make the actual report. - beaker stuff but could also be used to submit logs to tmt/Testing Farm when we would
# run this by TMT directly and not in "incepted" VM
#rhts-report-result $TEST $RESULT $TEST_REPORT_FILE
exit $rc
