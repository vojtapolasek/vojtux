# Pocket Linux

This document was created as a part of the Podzimní Agora workshop
in 2019. It was updated in October 2021.

Created by Vojtěch Polášek <vojtech.polasek@gmail.com>.

Other contributors to this project include Bohdan Milar <bmilar@redhat.com>, Lukáš
Tyrychtr <ltyrychtr@redhat.com> and Pavel Vlček <pvlcek@redhat.com>.
Flashdisks for participants of the 'Pocket Linux' workshop were provided by  [Red
Hat](https://www.redhat.com/).

## What is Linux?

Linux is a free operating system. Linux, together with Windows and
macOS, is one of the most popular operating systems on desktop
and portable computers. Linux is also commonly used on servers,
smartphones, industrial devices, routers, supercomputers, and other
computers.

To make the terminology clear, we use the word _Linux_ to denote the
operating system, but also the kernel of the operating system.
When we say we use Linux, such as Fegora, what we mean is that we
use a Linux distribution. A Linux distribution is a combination of
a Linux kernel, graphical user interface, and pre-installed
applications. Armed with the knowledge of Linux terminology,
let us move on.

## Linux and visually impaired users

This workshop is aimed at beginner users, so I expect most of you
will use Linux with the graphical user interface. However, note
that you can fully control Linux by using only a text interface as well.

[Orca](https://help.gnome.org/users/orca/stable/) is the only
screen reader that works completely on Linux. You can use other
screen readers on Linux, but only Orca works with the graphical interface.
Other screen readers work only in the command line interface, which
is not in scope of this workshop.

The subject of this workshop is Fegora. The name Fegora a blend
of the words Fedora and Agora. [Fedora](https://getfedora.org/) is a
Linux distribution supported by [Red Hat](https://redhat.com/).
[Agora](https://www3.teiresias.muni.cz/cz/vzdelavani-sport-a-volny-cas/agora)
is a Czech series of workshops about information technologies aimed at visually
impaired users. We based Fegora on
[Fedora Mate Compiz](https://spins.fedoraproject.org/mate-compiz/). Fedora
Mate Compiz provides a good accessibility base for visually impaired users.
However, we have added a number of improvements to ensure better experience.
For example, the screen reader now works in the login screen, and Fegora comes
pre-installed with a number of useful programs, such as OCR-based
text-recognition software.

## Jak si můžu Linux vyzkoušet?

Existují dvě možnosti, jak si můžete Linux vyzkoušet bez toho, abyste se
báli, že si rozbijete svůj stávající operační systém. Zjednodušeně
řečeno si stáhnete soubor, který obsahuje plně funkční operační systém.
Takovému souboru říkáme obraz disku. První možnost spočívá v tom, že
použijete virtuální počítač a Linux spustíte v něm. Druhou možností je
přenést obraz disku na USB disk a spustit Linux místo vašeho hlavního
operačního systému. I když to zní trochu nebezpečně, tak se nemusíte
bát. Pokud budete postupovat podle instrukcí, s vašimi daty by se nic
nemělo stát.

Linuxové distribuce můžeme často stáhnout ve formě tzv. live obrazů
(live images). To znamená, že si stáhneme obraz a jedním z výše
nastíněných způsobů z něj spustíme plnohodnotný operační systém. Tento
systém nikam neinstalujeme a můžeme jej okamžitě začít používat. Zároveň
ale platí, že všechny změny, které uděláme v rámci systému (instalace
aplikací, změna nastavení odečítače obrazovky) zůstanou v platnosti
pouze do vypnutí nebo restartu systému. Zároveň nemůžete flashdisk
použít pro nic jiného, bude obsahovat pouze live distribuci. Tento
způsob jsme zvolili například na Podzimní Agoře 2018. Po dvouletém experimentu s předinstalovanými obrazy pro USB disky jsme se k live obrazům opět vrátili.

### Spuštění z USB disku

Dostáváme se k samotnému spuštění Linuxu. Pokud to děláte poprvé,
najděte si někoho vidícího. Nemělo by to zabrat víc než pár minut.
Vypněte počítač a připojte USB disk, na který jste zapsali obraz,
případně jste jej obdrželi na workshopu. Počítač zapněte a požádejte
vidící osobu, aby pečlivě sledovala monitor. Na několik vteřin se hned
po zapnutí počítače objeví zpráva typu "Press F12 for boot menu". Na
každém počítači může zpráva vypadat trochu jinak, takže vám nemůžu dát
přesnější informace. Příslušnou klávesu si dobře zapamatujte, budete ji
používat při každém spuštění Fegory z USB disku.

Pokud jste nestihli stisknout správnou klávesu, nic se neděje, naběhne
váš běžný operační systém. Počítač vypněte, znovu zapněte a proces
opakujte. Hned po zapnutí mačkejte příslušnou klávesu. Objeví se
bootovací nabídka, která vám umožní zvolit zařízení, ze kterého se bude
načítat operační systém. Opět toto menu může vypadat na každém počítači
jinak. Pomocí šipek zvolte "USB" nebo "USB disk". Zapamatujte si,
kolikrát musíte po zobrazení menu stisknout šipku. Potvrďte volbu
klávesou Enter. Pokud je váš počítač vybaven interním reproduktorem,
spouštění Fegory bude oznámeno krátkou znělkou. Nyní již pomoc vidící
osoby potřebovat nebudete.

Existuje také možnost změnit nastavení počítače tak, aby z USB disků
spouštěl systém automaticky. Bohužel přesný popis postupu, jak toho
docílit, je mimo naše síly, protože se liší počítač od počítače.
Požádejte vidící osobu o pomoc. Doporučuji použít internetové
vyhledávače a najít návod, jak toho docílit na vašem počítači.

Když tímto způsobem spustíte Linux z USB disku, tak chvilku počkejte,
systém se spouští. Hodně záleží na rychlosti vašeho disku, doporučujeme
používat rychlé flashdisky s rozhraním USB 3.0. Ujistěte se, že máte
zapnuté reproduktory nebo připojená sluchátka. Po několika desítkách
vteřin by se měla ozvat hláška "Čtečka obrazovky zapnuta". Právě jste
spustili Linux a můžete jej začít používat, gratulujeme!

### Spuštění ve virtuálním počítači

Tato metoda se může zdát pohodlnější, protože vám umožní mít spuštěný
váš hlavní operační systém a zároveň si hrát s Linuxem. Bohužel jsem ale
zjistil, že přístupnost programů pro práci s virtuálními počítači není
tak dobrá, jak jsem předpokládal. Testoval jsem programy na systému
Windows s odečítačem NVDA. Proto vám doporučuji použít metodu s USB
diskem. Pokud se přece jen rozhodnete jít cestou virtuálních počítačů,
připravte se na to, že budete občas trochu bojovat s přístupností.

nejprve si musíte stáhnout software pro práci s virtuálními počítači.
Virtuální počítače jsou přesně to, co napovídá jejich název. Umožňují
mít spuštěný virtuální počítač ve vašem fyzickém počítači. A v tomto
virtuálním počítači můžete mít spuštěný třeba Linux a zároveň neopustíte
svůj hlavní operační systém. Doporučuji vyzkoušet program
{Virtualbox}(https://www.virtualbox.org/wiki/Downloads). Podobných
programů je více, například VMWare Workstation nebo Microsoft Virtual
PC, ale nemám s nimi dostatečné zkušenosti.

Protože nevím, jaký software budete používat, popíšu kroky jen obecně.
Nejprve musíte vytvořit virtuální počítač. Během tohoto procesu se vás
program nejspíš zeptá na to, jaký operační systém na tomto počítači
budete spouštět, zvolte Linux. Nastavte počítač tak, aby měl k dispozici
alespoň 4 Gb paměti RAM. přidejte počítači CD mechaniku tak, aby její obsah odkazoval na stažený live obraz Fegory. Pokud si chcete Linux opravdu jen vyzkoušet, nemusíte přidávat žádný virtuální pevný disk. Pokud si chcete vyzkoušet i instalaci, přidejte dostatečně velký pevný disk (20 GiB by mělo stačit. Pak už jen stačí spustit
virtuální počítač a Linux by měl automaticky naběhnout.

## Podařilo se mi spustit Linux, a co teď?

Ještě jednou vám gratuluji, právě jste prošli tím nejtěžším, co
začátečníky s Linuxem čeká a občas také odradí. Teď už půjde všechno
relativně hladce. Jak jsem psal výše, po úspěšném startu systému
uslyšíte hlášku "Čtečka obrazovky zapnuta".

Stiskněte kombinaci kláves CTRL+ALT+d a ocitnete se na
pracovní ploše. Je to nutné po spuštění udělat, jinak od vás systém
nebude přijímat klávesové zkratky. Je možné, že systém na vás bude
mluvit příliš nahlas. Můžete změnit hlasitost systémového zvuku pomocí
hardwarových tlačítek k tomu určených a nebo pomocí kláves ALT+WIN+šipky
nahoru a dolů.

Nacházíte se na pracovní ploše. Pomocí šipek si můžete projít několik
ikon. Ikony aktivujete stiskem klávesy Enter. Pokud tak učiníte na ikoně
"Domov liveuser", otevře se správce souborů s vaší domovskou složkou. Zde
už je vytvořeno několik složek a ukládá se sem veškeré vaše nastavení.

Na ploše bude nejspíš zajímavý soubor klavesove_zkratky.txt, který
obsahuje seznam užitečných klávesových zkratek. Pokud se šipkami
přesunete na tento soubor a stisknete Enter, otevře se soubor v textovém
editoru. Nejspíš zjistíte, že práce s textem zde funguje jako v
systémech Windows. Editor můžete zavřít známou zkratkou Alt+F4.

Na ploše se též nachází soubor handout,html, který nejspíš právě čtete.
Po vybrání souboru a stisknutí klávesy Enter se otevře Prohlížeč Mozilla
Firefox a zobrazí se obsah souboru.

## Quick introduction to the Orca screen reader

Orca has most of the functions that you might expect from a modern
screen reader. Similary to NVDA, for example, Orca has its **special key**
that we will refer to as the **Orca**. By default, it corresponds with
the **CapsLock** key.

As a matter of course, Orca offers a solid number of settings. The **Preferences**
dialogue can be activated using **Orca+Space**. The focus will be placed on
a row of tabs which can be browsed using the **right and left arrows**. 
The **Tab** key iterates over the controls (**Shift+Tab** in the reversed 
order). The buttons, checkboxes and radio-buttons can be activated using the 
**Spacebar** key. Any list item is selected using the **up and down arrows**. 
The same way you toggle switches and move sliders. If you want to save the
changes, remember to activate the **OK** button.

An interesting setting for you will probably be the keyboard layout.
This switch is located on the **General** tab and you can reach it by 
pressing **Tab** immediately after the Settings dialogue opens. If you
change the layout to **Desktop**, the Orca key will be set to the **Insert**
key and some other changes will be made as well to enable better 
ergonomics on a fullsize keyboard with a numerical block. Some of you
might want to change the voice synthesis. You can do so on the **Speech** tab.
Change only the **Speech Synthesizer** and **Person** values and leave the **Speech
system** as is.

## Keyboard shortcuts

It will suffice to remember just a couple of important keyboard shortcuts.
You can activate the _tutorial mode_ by pressing the **Orca+H** combination. 
In this mode, you can try using various keyboard shortcuts and Orca will tell 
you what they stand for. Use the **F2** key to list them all. The **F3** key 
shows the list of shortcuts available in the currently running application. 
This might help when in the Firefox browser, for example. The **Escape** 
key terminates the tutorial mode.

Another important shortcut is the **Alt-Super-O** combination. The **Super** 
key is represented by the key with the Windows logo that is usually placed between 
the left **Ctrl** and **Alt** keys. This combination restarts the screen reader. 
When it happens that Orca stops responding, you can make it work again by using 
this combination.

To reach the list of installed applications, you can use the **Alt-F1**
combination. The applications are sorted in categories. Use **up** and 
**down** arrows to browse the menu, unfold the categories using the right arrow.

To reach the desktop, use the above mentioned **Ctrl-Alt-D** shortcut. 
Consult the `keyboard_shortcuts.txt` file in the home directory to
get a full list of keyboard shortcuts.

## Panels

By default, there is one panel placed above the workspace. You can switch
between the workspace and the panels using the **Ctrl+Alt+Tab** keyboard
shortcut. When you have switched to the panel, use the **Tab** and
**Shift+Tab** to cycle trough the particular items. On the panel, you 
will find icons for network connections, volume settings, battery
indicator, and further notifications.

Unfortunately, the icons may not be correctly announced, especially after
the system has just started. It is recommended to navigate throughout the
whole panel using the **Tab** key first to have the icons announced
correctly on consecutive passes. You can activate the icon by pressing
the **Spacebar** key.

You can add more panels, or add icons to already existing panels. Use 
the **Shift+F10** combination to open the corresponding menu.
To return to the workspace, use the **Ctrl+Alt+D** combination.

## Web Browsing

Fegora uses the pre-installed Mozilla Firefox browser. Web browsing
with Firefox and Orca does not differ much from the Firefox and NVDA
combination. The **Tab** key works as expected and you can use it to
navigate between links and form items. Orca offers two modes
which can be toggled between using the **Orca+A** shortcut.

The *browse mode* is recommended whenever you need to browse through
a page and read the text. There is a plenty of various keyboard shortcuts
that you can use to move among the page elements. For instance, the **H**
key takes you to a next heading while **Shift+H** takes you to the previous
one. The **Alt+Shift+H** combination lists all available headings. To see all 
such keyboard shortcuts, switch on the *learning mode* in the active Firefox 
window and press the **F3** key. Obviously, all arrow keys as well as their 
combinations with the **Shift** key to select pieces of text do work.

The *focus mode* corresponds with the *form mode* in NVDA. You will
mainly use this mode to work with forms. This makes it possible to type
into form fields, toggle switches, and so on. This would not work in the
browsing mode, because the reader would interpret the majority of the keys 
as navigation keys and would move you around the page.

The reader should be able to tell automatically that you have entered
a form and should immediately switch to the focus mode. This is only
indicated by the speech but not by any sound. To toggle the modes manually,
you can use the **Orca+A** combination. If you make two quick consecutive presses
of this combo, the focus mode will lock and stay active even upon leaving
the form. This can be useful on some complicated web pages.

## Virtual workspaces

The graphical interface includes so called virtual workspaces.
Imagine there are four monitors in front of you with different windows
opened on each of them. That's exactly how workspaces work.
You don't have to spend time browsing all your windows whilst searching
for the one you need. You can have one workspace dedicated just for the internet
browser, another workspace with a draft document, and so on.

By default there are four virtual workspaces adjacent to one another, and when
you log in, you go into the far left one. You can switch between the workspaces
using CTRL+ALT+arrows. When you open a window on the workspace, it stays there.
But it's possible to move it; just go to that window and press CTRL+ALT+SHIFT+arrows.

## Where can I get more information?

You can find the main page with the information about the modified distribution
Fegora [here](https://a-fs.cz/fedora-29-mate-pro-nevidome/).(CZ)
It contains the newest information about this distribution and links
to download the image of the latest version as well as other useful files.

We also recommend you join the [e-mail
conference](https://a-fs.cz/emailova-konference/), which was established
together with the a-fs.cz website. We send the latest news
about Fegora there, and most importantly, it's a place where we answer
your questions and suggestions.

Another conference we recommend is the Orca screen reader conference. It's in
English language and very active. You can find it
[here](https://mail.gnome.org/mailman/listinfo/orca-list).

As we mentioned above, Fegora is based on the Fedora distribution. You can find
a Czech website dedicated to the Fedora distribution
[here](https://www.mojefedora.cz), and the official English website
[here](https://getfedora.org).

You can also contact us via e-mail adresses mentioned at the beginning
of this document.
