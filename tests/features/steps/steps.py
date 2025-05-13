#!/usr/bin/env python3
"""
Main file where the python code is located for execution via behave.
"""

from time import sleep
from behave import step  # pylint: disable=no-name-in-module
from dogtail.rawinput import (  # pylint: disable=import-error
    keyCombo,
    typeText,
    click,
    pressKey,
)

LOGGING = Logging()

def hold_key(key_name):
    code = keyNameToKeyCode(key_name)
    registry.generateKeyboardEvent(code, None, KEY_PRESS)
    doDelay(1)

def release_key(key_name):
    code = keyNameToKeyCode(key_name)
    registry.generateKeyboardEvent(code, None, KEY_RELEASE)
    doDelay(1)

def run(context, command, *a, **kw):
    try:
        output = subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT, *a, **kw).decode('utf8')
        returncode = 0
        exception = None
    except subprocess.CalledProcessError as e:
        output = e.output
        returncode = e.returncode
        exception = e
    context.embed('text/plain', '$?=%d' % returncode, caption='%s result' % command)
    context.embed('text/plain', output, caption='%s output' % command)
    print(("%s output: %s" % (command,output)))
    return output, returncode, exception

def command_output(context, command, *a, **kw):
    output, code, e = run(context, command, *a, **kw)
    if code != 0:
        raise e
    return output

def command_code(context, command, *a, **kw):
    _, code, _ = run(context, command, *a, **kw)
    return code

def wait_until_showing(element):
    wait_until(lambda x: x.position[0] > 0, element)
    doDelay(0.25)

def isProcessRunning(process):
    '''Gives true if process can be greped out of full ps dump '''
    s = subprocess.Popen(["ps", "axw"], stdout=subprocess.PIPE)
    for x in s.stdout:
        if re.search(process, x.decode('utf8')):
            return True
    return False

@step(u'Press "{sequence}"')
def press_button_sequence(context, sequence):  # pylint: disable=W0613
    keyCombo(sequence)
    sleep(0.5)


@step('Execute "{command}" command')
def execute_command(context, command):
    os.system(command)


@step('Wait for at least "{secs}" seconds')
def wait_for_secs(context, secs):
    sleep(int(secs))


@step('Execute in terminal: "{command}"')
def exec_in_terminal(context, command) -> None:  # pylint: disable=unused-argument
    typeText(command)
    pressKey("Enter")


