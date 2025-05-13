#!/usr/bin/env python3

"""
This file provides setup for machine environment for our testing pipeline.
"""

import sys
import traceback
from qecore.sandbox import TestSandbox
from qecore.utility import run


def before_all(context) -> None:
    """
    This function will be run once in every 'behave' command called.
    """

    try:
        pass

    except Exception as error:  # pylint: disable=broad-except
        print(f"Environment error: before_all: {error}")
        traceback.print_exc(file=sys.stdout)

        # Save the traceback so that we can use it later when we have html report.
        context.failed_setup = traceback.format_exc()


def before_scenario(context, scenario) -> None:
    """
    This function will be run before every scenario in 'behave' command called.
    """

    try:

        pass

    except Exception as error:  # pylint: disable=broad-except
        print(f"Environment error: before_scenario: {error}")
        traceback.print_exc(file=sys.stdout)

        # Attach failed setup from Before Scenario to our html-pretty report.
        embed_caption = "Failed cleanup in Before Scenario"
        context.embed("text", traceback.format_exc(), embed_caption)

        # Recommended to correctly place the embed to the Before Scenario.
        sys.exit(1)


def after_scenario(context, scenario) -> None:
    """
    This function will be run after every scenario in 'behave' command called.
    """

    try:
        pass
    except Exception as error:  # pylint: disable=broad-except
        print(f"Environment error: after_scenario: {error}")
        traceback.print_exc(file=sys.stdout)

        # Attach failed setup from After Scenario to our html-pretty report.
        embed_caption = "Failed cleanup in After Scenario"
        context.embed("text", traceback.format_exc(), embed_caption)

