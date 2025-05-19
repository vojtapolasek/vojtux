#!/bin/bash
set -x

RUN_START=$(date +%s)
TEST_REPORT_FILE="/tmp/artifacts/report_$1.html"

echo "RUNTEST executed for test $1"
echo "TIMEMARK: $RUN_START"

# Setup everything just the first time around!
if [ ! -e /tmp/automation_setup_done ]; then
  # the first time LIVE image is loaded it goes in liveuser session
  echo "Stopping any running GUI session"
  systemctl stop lightdm.service
  sleep 5

  echo "Creating a 'test' user"
  useradd test
  # just in case we ever deal with image mode :)
  chown test:test /home/test

  echo "Setting root password to 'redhat'"
  echo "redhat" | passwd root --stdin
  echo "Setting test password to 'redhat'"
  echo "redhat" | passwd test --stdin

  echo 'test ALL=(ALL)   NOPASSWD: ALL' >> /etc/sudoers

  echo "Copy behave.ini to enable pretty-html-formatter"
  cp behave.ini /home/test/behave.ini
  chown test:test /home/test/behave.ini

  echo "Installing pip"
  dnf -y install python3-pip

  echo "Installing dogtail"
  python3 -m pip install dogtail
  echo "Installing behave"
  python3 -m pip install behave
  echo "Installing behave-html-pretty-formatter"
  python3 -m pip install behave-html-pretty-formatter

   echo "Enable a11y in for user test"
  sudo -u test dbus-launch gsettings set org.gnome.desktop.interface toolkit-accessibility true

  # Temporary until light supporting version is released in dogtail! (likely 1.0.6)
  wget https://gitlab.com/dogtail/dogtail/-/raw/headless-lightdm/scripts/dogtail-run-headless-next -O ./dogtail-run-headless-next
  cp -f ./dogtail-run-headless-next /usr/local/bin/dogtail-run-headless-next
  chmod +x /usr/local/bin/dogtail-run-headless-next
  # some grace time 
  sleep 5
  # Make the setup only once.
  touch /tmp/automation_setup_done
fi

# Run the test we are asked to run!
sudo -u test dogtail-run-headless-next --dm lightdm "behave -t $1 -k -f html-pretty -o $TEST_REPORT_FILE -f plain"; rc=$?

# Mark result FAIL or PASS depending on the test result.
RESULT="FAIL"
if [ $rc -eq 0 ]; then
  RESULT="PASS"
fi

# Make the actual report. - beaker stuff but could also be used to submit logs to tmt/Testing Farm when we would
# run this by TMT directly and not in "incepted" VM
#rhts-report-result $TEST $RESULT $TEST_REPORT_FILE
exit $rc
