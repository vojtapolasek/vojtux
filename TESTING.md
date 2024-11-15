# Vojtux manua test plan

This file contains test cases which should verify that Vojtux distribution live image is behaving as expected.
Currently, I do not have any automation around it, that's why I am writing here exact steps how to manually test some Vojtux features.

## TC 1

### Description:

The live image has speech working after boot.

### Setup:

-   Get the Vojtux live image.

-   Prepare a VM or a physical system with sound output enabled.

### Steps:

-   Configure the system so that its primary boot device is the one with Vojtux image.

-   Power on the system.

-   When the boot screen appears, choose "start vojtux xy", where xy is the Vojtux version, or wait until the timeout runs out and the system starts booting.

-   Wait for cca 1 minute, depending on your hardware.

### Expected results:

-   the graphical desktop appears

-   "Screen Reader on" is announced with Espeak voice and it can be heard from speakers

## TC 2

### Description:

Ensure that the desktop can be accessed with a screen reader.

### Setup:

-   Get the Vojtux live image.

-   Prepare a VM or a physical system with sound output enabled.

### Steps:

-    Configure the system so that its primary boot device is the one with Vojtux image.

-   When the boot screen appears, choose "start vojtux xy", where xy is the Vojtux version, or wait until the timeout runs out and the system starts booting.

-   Wait until you hear "screenreader on".

-   Press key combination ctrl+alt+d.

-   Keep pressing down arrow while moving over items.

### Expected results:

-   after pressing the ctrl+alt+d you should hear "desktop, icon view"

-   after each down arrow press, Orca screen reader should read an icon from the desktop. You should hear the following utterances:

    -   Computer icon

    -   Live user's home icon

    -   Install to hard drive desktop entry

    -   Trash icon

## TC 3

### Description:

Ensure that the Orca key is configured correctly

### Setup:

-   Boot into desktop environment of the Vojtux live image.

### Steps:

-    Press ctrl+alt+d or click on the desktop to focus the desktop.

-   Press insert+h.

-   Press escape.

### Expected results:

-   After pressing insert+h you should hear "screen reader version xyz", where xyz is Orca version, the exact version is not important for this test case

-   After pressing Escape you should hear "escape, exitting learn mode"

## TC 4

### Description:

Ensure that the sound theme is correctly loaded.

### Setup:

-   Boot into desktop environment of the Vojtux live image.

- Ensure that the left most virtual desktop is shown.

### Steps:

-   Press ctrl+alt+d or click on the desktop to focus the desktop.

-   Press ctrl+alt+right arrow.

### Expected results:

-   You should hear swishing sound

-   You should hear "desktop 2"

-   You should be switched to the second desktop (workspace)

## TC 5

### Description:

Ensure that the documentation is present.

### Setup:

-   Boot into desktop environment of the Vojtux live image.

-   Download this file [https://github.com/vojtapolasek/vojtux/blob/master/docs/en/handout.md](https://github.com/vojtapolasek/vojtux/blob/master/docs/en/handout.md)

-   Download this file [https://github.com/vojtapolasek/vojtux/blob/master/docs/en/keyboard_shortcuts.txt](https://github.com/vojtapolasek/vojtux/blob/master/docs/en/keyboard_shortcuts.txt)

-   Run pandoc -s \--self-contained -t html -o handout.html handout.md

### Steps:

-   Open the "live user's home folder".

-   Open the "documentation folder".

### Expected results:

There should be following three documents:

-   Handout.html identical to the file you produced in the setup phase

-   Handout.md identical to the file you downloaded in the setup phase

-   keyboard_shortcuts.txt identical to the file you downloaded in the setup phase

