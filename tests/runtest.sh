#!/bin/bash

set -x

RUN_START=$(date +%s)
mkdir /tmp/artifacts
TEST_REPORT_FILE="/tmp/artifacts/report_$TEST.html"


# Setup qecore.
if [ ! -e /tmp/automation_setup_done ]; then
  # Specify version, in case of a mistake in the next version, we still need working automation.
  cp behave.ini /home/test/behave.ini
  chown test:test /home/test/behave.ini
  python3 -m pip install dogtail
  python3 -m pip install behave
  python3 -m pip install behave-html-pretty-formatter
  python3 -m pip install qecore

  # Make the setup only once.
  touch /tmp/automation_setup_done
fi

sudo -u test dogtail-run-headless-next "behave -t $1 -k -f html-pretty -o $TEST_REPORT_FILE -f plain"; rc=$?

# Mark result FAIL or PASS depending on the test result.
RESULT="FAIL"
if [ $rc -eq 0 ]; then
  RESULT="PASS"
fi

# Make the actual report.
#rhts-report-result $TEST $RESULT $TEST_REPORT_FILE
exit $rc
