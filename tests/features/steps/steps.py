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
from qecore.utility import run, Tuple

# Find a better solution how to get the precoded steps here instead of linter disable.
from qecore.common_steps import *  # pylint: disable=unused-wildcard-import,wildcard-import

from qecore.logger import Logging

LOGGING = Logging()


@step('Execute in terminal: "{command}"')
def execute_command(context, command) -> None:  # pylint: disable=unused-argument
    """
    Execute command in terminal.

    :param context: Holds contextual information during the running of tests.
    :type context: <behave.runner.Context>

    :param command: Command to execute.
    :type command: str
    """

    typeText(command)
    pressKey("Enter")


@step("Window is fullscreen")
@step("Window is {negation} fullscreen")
def window_is_fullscreen(context, negation=None) -> None:
    """
    Verify that the terminal window is fullscreen.

    :param context: Holds contextual information during the running of tests.
    :type context: <behave.runner.Context>

    :param negation: Negation of result when comparing, defaults to None.
    :type negation: str, optional.
    """

    sleep(3)
    frame = context.terminal.instance.child(roleName="frame")
    size_x = frame.size[0]
    size_y = frame.size[1]

    screen_size_x = context.sandbox.resolution[0]
    screen_size_y = context.sandbox.resolution[1]

    if negation:
        assert (
            screen_size_x != size_x or screen_size_y != size_y
        ), "Window is still in fullscreen mode."
    else:
        assert screen_size_x == size_x and screen_size_y == size_y, "\n".join(
            (
                "\nWindow is not in fullscreen mode.",
                f"Existing resolution='{context.sandbox.resolution}'",
                f"X: Screen Size='{screen_size_x}' != Terminal Size='{size_x}'.",
                f"Y: Screen Size='{screen_size_y}' != Terminal Size='{size_y}'.",
            )
        )

        assert frame.position[1] == 0, "Fullscreen frame is not top aligned."
