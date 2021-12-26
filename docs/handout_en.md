# Mastering Linux

This document was created as a part of the Podzimní Agora workshop
in 2019. It was updated in October 2021.

Created by Vojtěch Polášek <vojtech.polasek@gmail.com>.

Other contributors to this project include Bohdan Milar <bmilar@redhat.com>, Lukáš
Tyrychtr <ltyrychtr@redhat.com> and Pavel Vlček <pvlcek@redhat.com>.

English translation contributed by [@Darth-Mera](https://github.com/Darth-Mera), [@lruzicka](https://github.com/lruzicka), [@m-czernek](https://github.com/m-czernek).

Flashdisks for participants of the 'Pocket Linux' workshop were provided by  [Red
Hat](https://www.redhat.com/).

## What is Linux?

Linux is a free operating system.
Linux, together with Windows and macOS, is one of the most popular operating systems on desktop
and portable computers.
Linux is also commonly used on servers, smartphones, industrial devices, routers, supercomputers, and other computers.

To make the terminology clear, we use the word _Linux_ to denote the operating system, but also the kernel of the operating system.
When we say we use Linux, such as Fegora, what we mean is that we use a Linux distribution.
A Linux distribution is a combination of a Linux kernel, graphical user interface, and pre-installed applications.
Armed with the knowledge of Linux terminology, let us move on.

## Linux and visually impaired users

This workshop is aimed at beginner users, so I expect most of you will use Linux with the graphical user interface.
However, note that you can fully control Linux by using only a text interface as well.

[Orca](https://help.gnome.org/users/orca/stable/) is the only screen reader that works completely on Linux.
You can use other screen readers on Linux, but only Orca works with the graphical interface.
Other screen readers work only in the command line interface. This is not in scope of this workshop.

The subject of this workshop is Fegora.
The name Fegora is a blend of the words Fedora and Agora.
[Fedora](https://getfedora.org/) is a Linux distribution supported by [Red Hat](https://redhat.com/).
[Agora](https://www3.teiresias.muni.cz/cz/vzdelavani-sport-a-volny-cas/agora) is a Czech series of workshops about information technology aimed at visually impaired users.
We based Fegora on [Fedora Mate Compiz](https://spins.fedoraproject.org/mate-compiz/).
Fedora Mate Compiz provides a good accessibility base for visually impaired users.
However, we have added a number of improvements to ensure better experience.
For example, the screen reader now works in the login screen, and Fegora comes pre-installed with a number of useful programs, such as OCR-based text-recognition software.

## How can I try out Linux?

There exist two options how to try out Linux without being afraid of damaging your existing operating system setup.
Briefly said, you will download a file which contains fully working operating system.
Such a file is called a disk image.
The first option requires you to transfer the image to an USB drive and launch Linux instead of your primary operating system.
The second option requires you to use a virtual computer and run the image within it.
Although it might seem a bit dangerous, you don't need to be afraid.
If you follow the instructions, your data should stay safe.

We can often download Linux distributions as live images. 
That implies that we download the image and we run the fully working system using one of methods outlined above 
We do not install this system anywhere and we can start using it right away.
At the same time, we have to be aware that any changes made in the scope of the operating system (installation of packages, changes in screenreader configuration) will persist only until the system is rebooted or shut down.
Also in this case you can't use the flash drive for anything else, it will contain only the live image of the distribution.
We used this method for example at Agora workshop in Autumn 2018.
Later we started using premade images for USB drives.
After two years of this experiment, we switched back to live images.

### running Linux from the USB drive

Now we are getting to the process of actually launching Linux.
If you are doing it for the first time, it is a good idea to find someone sighted to help you.
It should not take more than few minutes.
Turn off the computer and connect the USB drive which has the live image written.
Turn on the computer and ask the sighted person to watch the screen carefully.

The message similar to "press F12 for boot menu" will appear for a few seconds.
The message can look differently on each computer, therefore I can't unfortunately tell you what to exactly look for.
Remember the key displayed within the message, you will use it each time you will launch Fegora from the USB drive.

If you do not manage to press the designated key, don't worry. Your regular operating system will launch.
Turn off the computer, turn it on again and repeat the process.
Keep pressing the designated key immediatelly upon turning on the computer.
The boot menu will appear.
This menu allows you to choose the device from which the operating system will be loaded.

Again, this menu can look differently on each computer.
Choose "USB" or "USB drive" or something similar using up and down arrows.
It is a good idea to remember how many times you have to press the arrow after the menu appears.
Confirm the selection by pressing **ENTER**.
If Fegora starts booting, various text messages scroll over the screen.
If you remember how to activate the boot menu and which item to choose, you should no longer require help from a sighted person.

It is possible to configure the computer to automatically launch operating system from the USB media if present.
However, description of such a process is out of scope of this text, because it can be different on each computer.
If you want to try it, use your prefered search engine to find instructions for your system and ask a sighted person for help.

When you manage to launch Linux from the USB drive, please be patient, the system is loading.
The load time depends on the speed of your drive.
We recommend to use fast drives with USB 3 interface.
make sure that your speakers are turned on or your headphones are connected.
After several tens of seconds you should hear "Screenreader on".
congratulations! You have just managed to launch the Linux operating system and you can start using it.

### Running Linux in a virtual computer

This method may seem more comfortable, because you can have your primary operating system running while playing with Linux.
Unfortunately I have discovered that accessibility of virtual computer software is not as good as I expected.
I tested such applications on Windows 7 system with NVDA screenreader.
Therefore, I recommend you to use the USB drive method.
If you still wish to use virtual computers, get ready for some accessibility quirks.

First, you need to download a software for managing of virtual computers.
Virtual computers are exactly what you might thing they are.
They allow you to run virtual computer within your physical computer.
And you can have Linux running within this virtual computer without leaving your primary operating system.
I recommend trying {Virtualbox}(https://www.virtualbox.org/wiki/Downloads).
There are similar applications, such as VMWare Workstation or Microsoft Virtual
PC but I have not enough experience with them.

Because I don't know which software you use, I describe only general steps here.
First you have to create a new virtual computer.
During the process you will be probably asked which operating system you are going to run in the new virtual computer.
Choose Linux.
Configure the virtual computer to have at least 4 GiB of RAM memory.
Add a CD drive and configure it to load the Fegora live image which you previously downloaded.
If you only want to try the system, you do not need to assign a virtual hard drive to the computer.
If you want to experiment with installation of the system, add a virtual hard drive; 20 GiB should be enough.
Then it should be enough to turn on the virtual computer and Linux should load automatically.

## I have managed to run Linux. What now?

Congratulations!
You have now overcome the most difficult problem that beginners have with Linux and that may scare them off eventually.
Now, things will go relatively easy.
As mentioned before, after the system has started successfully you will hear the "The screen  reader is switched on." message.

Press the **Ctrl+Alt+D** keyboard shortcut which takes you to the  desktop.
You need to do it after the system starts, otherwise it will  not accept the keyboard shortcuts.
The speech volume might be too loud  for you.
You can change the volume of the system sound using the dedicated  hardware buttons or the **Alt+Win** combination with the **up** and **down**  arrow keys.

Now you are on the desktop.
Using the arrows, you can browse through several  icons.
You can activate the icons with the **Enter** key.
If you activate  the *liveuser's home folder* icon, the file manager opens your home folder.
The system  has already created several folders in this location and will store all your  settings here.

In the home folder, there will be a very interesting file called `keyboard_shortcuts.txt` which contains a list of useful keyboard shortcuts.
Use the arrows to navigate to this file and press **Enter**.
The file will open in a text editor.
You will probably notice that text editing works like in Windows.
You can close the text editor using the **Alt+F4** keyboard shortcut.

The `handout.html` file is located in the home folder as well and you are probably reading it now.
When you select the file and press **Enter**, the Mozilla Firefox browser opens and shows the file content.

## Quick introduction to the Orca screen reader

Orca has most of the functions that you might expect from a modern screen reader.
Similarly to NVDA, for example, Orca has its **special key** that we will refer to as the **Orca**.
By default, it corresponds with the **CapsLock** key.

As a matter of course, Orca offers a solid number of settings.
The **Preferences** dialogue can be activated using **Orca+Space**.
The focus will be placed on a row of tabs which can be browsed using the **right and left arrows**.
The **Tab** key iterates over the controls (**Shift+Tab** in the reversed  order).
The buttons, checkboxes and radio-buttons can be activated using the  **Spacebar** key.
Any list item is selected using the **up and down arrows**.
It is the same way you toggle radio buttons and move sliders.
If you want to save the changes, remember to activate the **OK** button.

An interesting setting for you will probably be the keyboard layout.
This switch is located on the **General** tab and you can reach it by  pressing **Tab** immediately after the Settings dialogue opens.
If you change the layout to **Desktop**, the Orca key will be set to the **Insert** key and some other changes will be made as well to enable better  ergonomics on a fullsize keyboard with a numerical block.
Some of you might want to change the voice synthesis.
You can do so on the **Speech** tab.
Change only the **Speech Synthesizer** and **Person** values and leave the **Speech system** as is.

## Keyboard shortcuts

It will suffice to remember just a couple of important keyboard shortcuts.
You can activate the _tutorial mode_ by pressing the **Orca+H** combination.
In this mode, you can try using various keyboard shortcuts and Orca will tell  you what they stand for.
Use the **F2** key to list them all.
The **F3** key  shows the list of shortcuts available in the currently running application. 
This might help when in the Firefox browser, for example.
The **Escape**  key terminates the tutorial mode.

Another important shortcut is the **Alt-Super-O** combination.
The **Super**  key is represented by the key with the Windows logo that is usually placed between  the left **Ctrl** and **Alt** keys.
This combination restarts the screen reader.
When it happens that Orca stops responding, you can make it work again by using  this combination.

To reach the list of installed applications, you can use the **Alt-F1** combination.
The applications are sorted in categories.
Use **up** and  **down** arrows to browse the menu, unfold the categories using the right arrow.
To reach the desktop, use the above mentioned **Ctrl-Alt-D** shortcut.
Consult the `keyboard_shortcuts.txt` file in the home directory to get a full list of keyboard shortcuts.

## Panels

By default, there is one panel placed above the workspace.
You can switch between the workspace and the panels using the **Ctrl+Alt+Tab** keyboard shortcut.
When you have switched to the panel, use the **Tab** and **Shift+Tab** to cycle trough the particular items.
On the panel, you  will find icons for network connections, volume settings, battery indicator, and further notifications.

Unfortunately, the icons may not be correctly announced, especially after the system has just started.
It is recommended to navigate throughout the whole panel using the **Tab** key first to have the icons announced correctly on consecutive passes.
You can activate the icon by pressing the **Spacebar** key.

You can add more panels, or add icons to already existing panels.
Use  the **Shift+F10** combination to open the corresponding menu.
To return to the workspace, use the **Ctrl+Alt+D** combination.

## Web Browsing

Fegora uses the pre-installed Mozilla Firefox browser.
Web browsing with Firefox and Orca does not differ much from the Firefox and NVDA combination.
The **Tab** key works as expected and you can use it to navigate between links and form items.
Orca offers two modes which can be cycled between using the **Orca+A** shortcut.

The *browse mode* is recommended whenever you need to browse through a page and read the text.
There is a plenty of various keyboard shortcuts that you can use to move among the page elements.
For instance, the **H** key takes you to the next heading while **Shift+H** takes you to the previous one.
The **Alt+Shift+H** combination lists all available headings.
To see all  such keyboard shortcuts, switch on the *learning mode* in the active Firefox  window and press the **F3** key.
Obviously, all arrow keys as well as their  combinations with the **Shift** key to select pieces of text do work.

The *focus mode* corresponds with the *form mode* in NVDA.
You will mainly use this mode to work with forms.
This makes it possible to type into form fields, toggle switches, and so on.
This would not work in the browsing mode, because the reader would interpret the majority of the keys  as navigation keys and would move you around the page.

The screenreader should be able to tell automatically that you have entered a form and should immediately switch to the focus mode.
This is only indicated by the speech but not by any sound.
To toggle the modes manually, you can use the **Orca+A** combination.
If you make two quick consecutive presses of this combo, the focus mode will lock and stay active even upon leaving the form.
This can be useful on some complicated web pages.

## Virtual workspaces

The graphical interface includes so called virtual workspaces.
Imagine there are four monitors in front of you with different windows opened on each of them.
That's exactly how workspaces work.
You don't have to spend time browsing all your windows whilst searching for the one you need.
You can have one workspace dedicated just for the internet browser, another workspace with a draft document, and so on.

By default there are four virtual workspaces adjacent to one another, and when you log in, you go into the far left one.
You can switch among the workspaces using CTRL+ALT+arrows.
When you open a window on the workspace, it stays there.
But it's possible to move it; just go to that window and press CTRL+ALT+SHIFT+arrows.

## Where can I get more information?

You can find the main page with the information about the modified distribution Fegora [here](https://a-fs.cz/fedora-29-mate-pro-nevidome/).(CZ)
I have to say that the page is outdated.
I recommend you joining some of conferences listed below.

We also recommend you join the [e-mail conference](https://a-fs.cz/emailova-konference/), which was established together with the a-fs.cz website.
We send the latest news about Fegora there, and most importantly, it's a place where we answer your questions and suggestions.

Another conference we recommend is the Orca screen reader conference.
It's in English language and very active.
You can find it [here](https://mail.gnome.org/mailman/listinfo/orca-list).

As we mentioned above, Fegora is based on the Fedora distribution.
You can find the official English website [here](https://getfedora.org).

You can also contact us via e-mail adresses mentioned at the beginning of this document.
