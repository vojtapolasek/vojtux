# Vojtux manual test plan

This file contains test cases which should verify that Vojtux distribution live image is behaving as expected.
Currently, I do not have any automation around it, that's why I am writing here exact steps how to manually test some Vojtux features.

In most cases, there are videos attached which demonstrate how the test result should look like.
Please unmute the sound in the Github video player, it is usually crucial to understand how the test result should look like.

## IMPORTANT: a note about Orca behavior for TC >= 2

Please note that Orca is configured to announce all key presses including CTRL, ALT and SHIFT key by default.
I don't plan to test this behavior because I think most people just turn it off.
However, I don't want to turn it off in Vojtux unless there is a strong demand for this, I prefer to keep upstream configuration where possible.

Please ignore these orca announcements when testing or disable this behavior as follows:

1. Open Orca preferences by pressing Orca+Spacebar (Orca key is by default set to Insert)

2. Switch to the "Echo" tab

3. Disable announcements of keys which annoy you, probably "Modifier keys" and possibly "Action keys"

https://github.com/user-attachments/assets/23325662-249c-48ab-8922-8ec864827ac0


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

### Video

https://github.com/user-attachments/assets/3ec1bc80-361b-4fea-810e-41f154bbf76f

## TC 2

### Description:

Ensure that the desktop can be accessed with a screen reader.

### Setup:

-Boot into desktop environment of the Vojtux live image.

### Steps:

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

### Video

https://github.com/user-attachments/assets/3c388698-c0f5-48b0-a573-2fe389561e8f


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

### Video

https://github.com/user-attachments/assets/a28bb50c-fc15-4344-82ae-395e9fc6c124

## TC 4

### Description:

Ensure that the sound theme is correctly loaded.

### Setup:

- Boot into desktop environment of the Vojtux live image.

### Steps:

- Press ctrl+alt+d or click on the desktop to focus the desktop.

- Press ctrl+alt+right arrow.

### Expected results:

- You should hear swishing sound

- Orca should announce "Workspace 2"

- You should be switched to the second desktop (workspace)

### Video

https://github.com/user-attachments/assets/3d587236-3d75-4b73-a5f4-924e7d1c5274

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

### Steps:

- Press ALT+F1 to open the application menu.

- Launch "Gparted" located in "System tools" folder.

- Use TAB key to move around the interface.

### Expected results:

- Orca should announce "Gparted frame" when the application launches.

- Orca should announce controls (such as "New... button" when using TAB to move around the interface.

### Video

https://github.com/user-attachments/assets/5e1c6e04-d79d-4d73-a064-3a4e452fcd21

## TC 7

### Description:

Ensure that applications utilizing QT toolkit are accessible.

### Setup:

- Boot into desktop environment of the Vojtux live image.

### Steps:

- Press ALT+F1 to open application menu.

- Launch VLC media player which can be found in the "Sound and video" submenu.

- Press TAB after the application launches.

### Expected results:

- The application presents a simple dialog configuring network access policy.

- When the window appears, the title "Privacy and network access policy" is announced by Orca.

- When pressing TAB key, two elements are announced; one checkbox and one button.

### Video

https://github.com/user-attachments/assets/db73bb98-77db-453b-855f-7d1c58b7b096

## TC 8

### Description:

Ensure that Orca screen reader can be restarted with a keyboard shortcut.

### Setup:

- Boot into desktop environment of the Vojtux live image.

### Steps:

- Focus the desktop by pressing CTRL+ALT+D.

- Press ALT+SUPER+O.

### Expected results:

- Orca will announce last focused item, in this case probably "Desktop, computer icon", followed by "Screen reader on".

### Video

https://github.com/user-attachments/assets/4cf19624-09a1-4903-ae67-2881c445e596

## TC 9

### Description:

Ensure that system volume can be changed with an alternative shortcut.

### Setup:

- Boot into desktop environment of the Vojtux live image.

### Steps:

- Focus the desktop by pressing CTRL+ALT+D.

- Press ALT+SUPER+DOWN and after a while press ALT+SUPER+UP.

### Expected results:

- The volume should decrease and increase.

- A sound should play when the volume is changed.

### Video

https://github.com/user-attachments/assets/45afcd6b-1380-4472-828c-6dcd46838284

## TC 10

### Description:

Ensure that system volume can be muted with an alternative shortcut.

### Setup:

- Boot into desktop environment of the Vojtux live image.

### Steps:

- Focus the desktop by pressing CTRL+ALT+D.

- Move through desktop icons with arrows.

- Press ALT+SUPER+LEFT.

- Move through desktop icons with arrows.

- Press ALT+SUPER+LEFT.

### Expected results:

- Speech should be produced before pressing the ALT+SUPER+LEFT combo for the first time.

- After pressing ALT+SUPER+LEFT for the first time, no speech should be produced when focusing icons.

- After pressing ALT+SUPER+LEFT for the second time, a popping sound should be produced.

### Video

https://github.com/user-attachments/assets/b5f5fe23-19cc-4c4e-bfb6-b3ebb92e408b

## TC 11

### Description:

Ensure that Firefox can be launched with a shortcut.

### Setup:

- Boot into desktop environment of the Vojtux live image.

- Focus the desktop.

### Steps:

- Press ALT+SUPER+F.

### Expected results:

- The firefox browser is launched.

### Video

https://github.com/user-attachments/assets/0821d7e9-9cb6-472d-9ed7-dbc36496b9b8

## TC 12

### Description:

Ensure that screen reader can be toggled system vide.

### Setup:

- Boot into desktop environment of the Vojtux live image.

- Focus the desktop.

### Steps:

- Press ALT+SUPER+S.

- Move through icons with arrows.

- Press ALT+SUPER+S again.

### Expected results:

- After pressing ALT+SUPER+S for the first time, Orca should announce "Screenreader off".

- When moving through icons, nothing is announced.

- After pressing ALT+SUPER+S for the second time, Orca should announce "Screen reader on".

### Video

https://github.com/user-attachments/assets/9e4c1da2-d4b4-4b55-a23f-1ea140205b62

## TC 13

### Description:

Ensure that LIOS can be started with a keyboard shortcut.

### Setup:

- Boot into desktop environment of the Vojtux live image.

- Focus the desktop.

### Steps:

- Press ALT+SUPER+L.

### Expected results:

- The Linux Intelligent OCR Software application should launch.

### Video

https://github.com/user-attachments/assets/e7068a96-beee-4122-ad72-5b2ad9d27dbe

## TC 14

### Description:

Ensure that monitor can be toggled with a shortcut.

Note that there is no video because currently there is an issue with this functionality (https://github.com/vojtapolasek/vojtux/issues/81)

### Setup:

- Boot into desktop environment of the Vojtux live image.

- Focus the desktop.

### Steps:

- Press ALT+SUPER+M.

- After a while, press ALT+SUPER+M again.

### Expected results:

- After pressing ALT+SUPER+M for the first time, the monitor is turned off or in case of VM, the message appears that the display output is not active. Also, you should hear "Monitor off".

- After pressing ALT+SUPER+M for the second time, the monitor should turn on again. You should hear "Monitor on".

## TC 15

### Description:

Ensure that all items in the top panel have meaningful accessible descriptions.

Note that there is no video because currently there is an issue with this functionality (https://github.com/vojtapolasek/vojtux/issues/82)

### Setup:

- Boot into desktop environment of the Vojtux live image.

### Steps:

- Focus the top panel by presing CTRL+ALT+TAB until it is focused.

- Use the TAB key to cycle through all items.

- Use the SHIFT+TAB to cycle through all items in reverse order.

### Expected results:

- Each item should be announced by Orca, no matter if moving forward or backward among items.

- Each item should be announced with a meaningful name, i.e. providing information so that the user can deduce its purpose. Bad example is announcing only "menu", "icon".

## TC 16

### Description:

Ensure that information spoken by Orca is correctly presented on braille devices.

### Setup:

- In case you have a physical braille device:

    - Connect a braille display to the VM.

    - Boot into desktop environment of the Vojtux live image.

- In case you don't have physical braille device:

    - Boot into desktop environment of the Vojtux live image.

    - Open a terminal

    - stop the running brltty service by running `systemctl stop brltty.service`

    - Run the command `brltty -b xw -A auth=none -e`; a small window mimicking a braille display should appear.

    - close the terminal window by pressing ALT+F4.

        - Note that this window cannot be reached by pressing common keyboard combo ALT+TAB.
        Therefore, it cannot be read by screen reader users.
        To close it, you have to use the mouse or to kill the appropriate brltty process, it will probably have the highest process ID from all brltty processes running.

### Steps:

- Focus the desktop.

- Keep pressing down arrow while moving over items.

### Expected results:

- After pressing the ctrl+alt+d, the display should show "Icon View Layered Pane".

-After pressing down arrows, the display (virtual or physical) should read the following based on the focused icon:

    - "Computer icon"

    - "Liveuser's icon"

    - "Install to hard Drive desktop entry"

    - "Trash icon"

### Video

https://github.com/user-attachments/assets/fec898d1-215b-46b9-a73d-e165078a3a86

## TC 17

### Description:

Ensure that brltty displays information displayed on text virtual consoles.

Note that there is no video because a physical braile display is needed.

### Setup:

- Connect a braille display to the VM.

- Boot into desktop environment of the Vojtux live image.

### Steps:

- Press CTRL+ALT+F2.

    - Note: Press CTRL+ALT+F1 to return to the graphical console.

### Expected results:

- The braille display should show "liveuser-localhost login:"

## TC 18

### Description:

Ensure that Ocrdesktop software can be launched with a keyboard shortcut.

### Setup:

- Boot into desktop environment of the Vojtux live image and focus the desktop.

### Steps:

- Press CTRL+SUPER+O.

### Expected results:

- There should appear a window with title "Ocrdesktop".

- The window will contain partial representation of the text on the screen in an area with a cursor. Exact contents will vary each time, so check manually that text in the text box more or less exists on the screen.

### Video


https://github.com/user-attachments/assets/cbf33dcc-395f-421c-9763-795febfc5183
