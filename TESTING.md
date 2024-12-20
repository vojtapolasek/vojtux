# Vojtux manual test plan

This file contains test cases which should verify that Vojtux distribution live image is behaving as expected.
Currently, I do not have any automation around it, that's why I am writing here exact steps how to manually test some Vojtux features.

## IMPORTANT: a note about Orca behavior for TC >= 2

Please note that Orca is configured to announce all key presses including CTRL, ALT and SHIFT key by default.
I don't plan to test this behavior because I think most people just turn it off.
However, I don't want to turn it off in Vojtux unless there is a strong demand for this, I prefer to keep upstream configuration where possible.

Please ignore these orca announcements when testing or disable this behavior as follows:

1. Open Orca preferences by pressing Orca+Spacebar (Orca key is by default set to Insert)

2. Switch to the "Echo" tab

3. Disable announcements of keys which annoy you, probably "Modifier keys" and possibly "Action keys"

## TC 1

### Description:

The live image has speech working after boot.

### Setup:

- Get the Vojtux live image.

- Prepare a VM or a physical system with sound output enabled.

### Steps:

- Configure the system so that its primary boot device is the one with Vojtux image.

- Power on the system.

- When the boot screen appears, choose "start vojtux xy", where xy is the Vojtux version, or wait until the timeout runs out and the system starts booting.

- Wait until a graphical desktop appears

### Expected results:

- "Screen Reader on" is announced with Espeak voice and it can be heard from speakers

## TC 2

### Description:

Ensure that the desktop can be accessed with a screen reader.

### Setup:

- Get the Vojtux live image.

- Prepare a VM or a physical system with sound output enabled.

### Steps:

- Configure the system so that its primary boot device is the one with Vojtux image.

-When the boot screen appears, choose "start vojtux xy", where xy is the Vojtux version, or wait until the timeout runs out and the system starts booting.

-Wait until you hear "screenreader on".

-Press key combination ctrl+alt+d.

-Keep pressing down arrow while moving over items.

### Expected results:

-After pressing the ctrl+alt+d you should hear "desktop, icon view".

-After each down arrow press, Orca screen reader should read an icon from the desktop. You should hear the following utterances:.

    - Computer icon

    - Live user's home icon

    - Trash icon

    - Install to hard drive desktop entry

## TC 3

### Description:

Ensure that the Orca key is configured correctly

### Setup:

-Boot into desktop environment of the Vojtux live image.

### Steps:

- Press ctrl+alt+d or click on the desktop to focus the desktop.

- Press insert+h.

- Press escape.

### Expected results:

- After pressing insert+h you should hear "screen reader version xyz, entering learn mode", followed by more instructions

    - xyz is Orca version, the exact version is not important for this test case

- After pressing Escape you should hear "exitting learn mode"

## TC 4

### Description:

Ensure that the sound theme is correctly loaded.

### Setup:

- Boot into desktop environment of the Vojtux live image.

- Ensure that the left most virtual desktop is shown.

### Steps:

- Press ctrl+alt+d or click on the desktop to focus the desktop.

- Press ctrl+alt+right arrow.

### Expected results:

- You should hear swishing sound

- Orca should announce "Workspace 2"

- You should be switched to the second desktop (workspace)

## TC 5

### Description:

Ensure that the documentation is present.

### Setup:

- Boot into desktop environment of the Vojtux live image.

- Download this file [https://github.com/vojtapolasek/vojtux/blob/master/docs/en/handout.md](https://github.com/vojtapolasek/vojtux/blob/master/docs/en/handout.md)

- Download this file [https://github.com/vojtapolasek/vojtux/blob/master/docs/en/keyboard_shortcuts.txt](https://github.com/vojtapolasek/vojtux/blob/master/docs/en/keyboard_shortcuts.txt)

- Run `pandoc -s -t html -o handout.html handout.md`

### Steps:

- Open the "live user's home folder".

- Open the "documentation folder".

### Expected results:

There should be the following three documents:

- handout.html identical to the file you produced in the setup phase

- handout.md identical to the file you downloaded in the setup phase

- keyboard_shortcuts.txt identical to the file you downloaded in the setup phase

## TC 6

### Description:

Ensure that graphical applications which are being run under sudo are accessible.

### Setup:

- Boot into desktop environment of the Vojtux live image.

- Press ALT+F1 to open the application menu.

- Launch "Gparted" located in "System tools" folder.

- Use TAB key to move around the interface.

### Expected results:

- Orca should announce "Gparted frame" when the application launches.

- Orca should announce controls (such as "New... button" when using TAB to move around the interface.

## TC 7

### Description:

Ensure that applications utilizing QT toolkit are accessible.

### Setup:

- Boot into desktop environment of the Vojtux live image.

- Press ALT+F1 to open application menu.

- Launch VLC media player which can be found in the "Sound and video" submenu.

- Press TAB after the application launches.

### Expected results:

- The application presents a simple dialog configuring network access policy.

- When the window appears, the title "Privacy and network access policy" is announced by Orca.

- When pressing TAB key, two elements are announced; one checkbox and one button.

## TC 8

### Description:

Ensure that Orca screen reader can be restarted with a keyboard shortcut.

### Setup:

- Boot into desktop environment of the Vojtux live image.

- Focus the desktop by pressing CTRL+ALT+D.

- Press ALT+SUPER+O.

### Expected results:

- Orca will announce last focused item, in this case probably "Desktop, computer icon", followed by "Screen reader on".

## TC 9

### Description:

Ensure that system volume can be changed with an alternative shortcut.

### Setup:

- Boot into desktop environment of the Vojtux live image.

- Focus the desktop by pressing CTRL+ALT+D.

- Press ALT+SUPER+DOWN and after a while press ALT+SUPER+UP.

### Expected results:

- The volume should decrease and increase.

- A sound should play when the volume is changed.

## TC 10

### Description:

Ensure that system volume can be muted with an alternative shortcut.

### Setup:

- Boot into desktop environment of the Vojtux live image.

- Focus the desktop by pressing CTRL+ALT+D.

- Move through desktop icons with arrows.

- Press ALT+SUPER+LEFT.

- Move through desktop icons with arrows.

- Press ALT+SUPER+LEFT.

### Expected results:

- Speech should be produced before pressing the ALT+SUPER+LEFT combo for the first time.

- After pressing ALT+SUPER+LEFT for the first time, no speech should be produced when focusing icons.

- After pressing ALT+SUPER+LEFT for the second time, a popping sound should be produced.

## TC 11

### Description:

Ensure that Firefox can be launched with a shortcut.

### Setup:

- Boot into desktop environment of the Vojtux live image.

- Focus the desktop.

- Press ALT+SUPER+F.

### Expected results:

- The firefox browser is launched.

## TC 12

### Description:

Ensure that screen reader can be toggled system vide.

### Setup:

- Boot into desktop environment of the Vojtux live image.

- Focus the desktop.

- Press ALT+SUPER+S.

- Move through icons with arrows.

- Press ALT+SUPER+S again.

### Expected results:

- After pressing ALT+SUPER+S for the first time, Orca should announce "Screenreader off".

- When moving through icons, nothing is announced.

- After pressing ALT+SUPER+S for the second time, Orca should announce "Screen reader on".

## TC 13

### Description:

Ensure that LIOS can be started with a keyboard shortcut.

### Setup:

- Boot into desktop environment of the Vojtux live image.

- Focus the desktop.

- Press ALT+SUPER+L.

### Expected results:

- Press ALT+SUPER+L.

### Expected results:

- The Linux Intelligent OCR Software application should launch.

## TC 14

### Description:

Ensure that monitor can be toggled with a shortcut.

### Setup:

- Boot into desktop environment of the Vojtux live image.

- Focus the desktop.

- Press ALT+SUPER+M.

- After a while, press ALT+SUPER+M again.

### Expected results:

- After pressing ALT+SUPER+M for the first time, the monitor is turned off or in case of VM, the message appears that the display output is not active. Also, you should hear "Monitor off".

- After pressing ALT+SUPER+M for the second time, the monitor should turn on again. You should hear "Monitor on".


## TC 15

### Description:

Ensure that all items in the top panel have meaningful accessible descriptions.

### Setup:

- Boot into desktop environment of the Vojtux live image.

- Focus the top panel by presing CTRL+ALT+TAB until it is focused.

- Use the TAB key to cycle through all items.

- Use the SHIFT+TAB to cycle through all items in reverse order.

### Expected results:

- Each item should be announced by Orca, no matter if moving forward or backward among items.

- Each item should be announced with a meaningful name, i.e. providing information so that the user can deduce its purpose. Bad example is announcing only "menu", "icon".
