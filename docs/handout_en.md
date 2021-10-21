# Linux v kapse

Tento dokument vznikl jako součást workshopu v rámci Podzimní Agory
2019. Byl aktualizován v říjnu 2021.

Vytvořil Vojtěch Polášek <vojtech.polasek@gmail.com>.

Na projektu dále spolupracovali Bohdan Milar <bmilar@redhat.com>, Lukáš
Tyrychtr <ltyrychtr@redhat.com> a Pavel Vlček <pvlcek@redhat.com>.
Flashdisky pro účastníky workshopu Linux v kapse poskytla firma [Red
Hat](https://www.redhat.com/).

## Co je to Linux?

Linux je svobodný operační systém. Spolu se systémy Windows a macOS
patří mezi nejpoužívanější systémy na stolních a přenosných počítačích.
Mimo jiné se také často používá na serverech, chytrých telefonech,
průmyslových zařízeních, routerech, superpočítačích atd.

Jen abychom si na začátku ujasnili pojmy, slovo Linux se používá pro
označení operačního systému, ale především je to označení jeho jádra.
Když říkáme, že používáme Linux, jako třeba v tomto případě Fegoru,
myslíme tím, že používáme linuxovou distribuci. Linuxová distribuce je
kombinace linuxového jádra, grafického rozhraní a předinstalovaných
aplikací. Dost teorie, pojďme na to.

## Linux a nevidomí uživatelé

Protože tento workshop byl vytvořen pro začátečníky, předpokládám, že
budete Linux používat skrze jeho grafické rozhraní. Jen pro úplnost
dodávám, že jej lze ovládat i skrze čistě textové rozhraní.

Pro Linux existuje pouze jeden odečítač obrazovky, který se jmenuje
[Orca](https://help.gnome.org/users/orca/stable/). Pro úplnost,
odečítačů existuje více, ale jen tento lze použít s grafickým rozhraním.
Ostatní odečítače se dají použít jen v příkazové řádce a tou se zde
zabývat nebudeme.

Budeme používat distribuci Fegora. Název Fegora vznikl spojením slov
Fedora a Agora. [Fedora](https://mojefedora.cz/) je Linuxová distribuce
podporovaná firmou [Red Hat](https://redhat.com/) a
[Agora](https://www3.teiresias.muni.cz/cz/vzdelavani-sport-a-volny-cas/agora)
je cyklus workshopů o informačních technologiích pro zrakově postižené.
Konkrétně jsme vycházeli z odnože [Fedora Mate
Compiz](https://spins.fedoraproject.org/mate-compiz/). Tato
verze sama o sobě byla relativně dobře přístupná pro nevidomé uživatele,
ale provedli jsme různá vylepšení, aby se používala ještě lépe.
Především jsme zajistili, aby odečítač mluvil už na přihlašovací
obrazovce a nainstalovali některé zajímavé programy, například pro
rozpoznávání textu pomocí technologie OCR.

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

## Rychlý úvod do odečítače Orca

Orca umí většinu funkcí, které očekáváte od moderního odečítače
obrazovky. Stejně jako například NVDA má Orca svou speciální klávesu,
kterou zde budu označovat jako Orca. Ve výchozím nastavení je to klávesa
Capslock.

Orca samozřejmě disponuje slušnou řádkou nastavení. Okno s předvolbami
aktivujete stisknutím zkratky Orca+Mezerník. Kurzor se bude nacházet na
řadě karet, mezi kterými se přepínáte šipkami vlevo a vpravo. Po
ovládacích prvcích se klasicky pohybujete klávesou TAB, v opačném směru
klávesou Shift+TAB. Tlačítka a zaškrtávací pole aktivujete stiskem
klávesy Mezerník. Položku ze seznamu vyberete pomocí šipek nahoru a
dolů, stejně tak přepínáte přepínače a posouváte posuvníky. Pokud chcete
uložit změny, nezapomeňte aktivovat tlačítko "Budiž". Mimochodem s tímto
tlačítkem se budete setkávat skoro všude. Nebojte se, je to to samé jako
OK.

Zajímavým nastavením pro vás nejspíš bude výběr rozložení klávesnice.
Tento přepínač se nachází na kartě "Obecné" a dostanete se na něj
stisknutím TAB hned po otevření nastavení. Pokud změníte rozložení na
Stolní počítač", klávesa Orca bude mapována na klávesu Insert a dojde i
k jiným změnám tak, aby se Orca příjemně používala na plnohodnotné
klávesnici s numerickým blokem. Někteří by si možná rádi změnili
hlasovou syntézu. Toho docílíte na kartě"Hlas". Měňte pouze seznamy
označené"Hlasový výstup\" a "osoba", v seznamu "Řečový systém" nechte
původní hodnotu.

## Klávesové zkratky

Stačí, když si zapamatujete jen několik důležitých klávesových zkratek.
Klávesovou zkratkou Orca+H aktivujete výukový režim. V tomto režimu si
můžete zkoušet různé klávesové zkratky a Orca vám řekne, co dělají.
Klávesou F2 si můžete zobrazit jejich seznam. Klávesou F3 si zobrazíte
seznam zkratek specifických pro právě spuštěnou aplikaci, hodí se to
třeba v prohlížeči Firefox. Výukový režim opustíte stisknutím klávesy
Escape.

Další důležitou zkratkou je kombinace ALT+Super+O. Klávesou Super se zde
myslí klávesa s logem Windows, která je většinou umístěna mezi levým
CTRL a ALT. Tato kombinace restartuje čtečku obrazovky. Občas se stane,
že Orca přestane reagovat, pro tento případ je tu právě tato zkratka.

Do nabídky nainstalovaných aplikací se dostanete stiskem kombinace
ALT+F1. Aplikace jsou roztříděny podle kategorií. Nabídky procházejte
šipkami nahoru a dolů, rozbalte kategorii šipkou vpravo.

Na pracovní plochu se přesunete již zmíněnou zkratkou CTRL+ALT+D. Další
klávesové zkratky naleznete v souboru klavesove_zkratky.txt, který je
umístěn v domovské složce.

## Panely

Ve výchozím nastavení je nad pracovní plochou umístěn jeden panel. Mezi
plochou a panely se přepínáte pomocí klávesové zkratky CTRL+Alt+TAB. Po
přepnutí na panel přecházíte mezi jednotlivými položkami pomocí kláves
TAB a Shift+TAB. Na panelu najdete ikonu pro nastavení připojení k síti,
nastavení hlasitosti, ukazatel baterie a případná další oznámení.

Bohužel se hlavně po spuštění systému stává, že některé ikony nejsou
ohlašovány. Doporučuji nejprve projít úplně celým panelem pomocí
opakovaného mačkání TAB a při druhém průchodu už jsou všechny ikony
korektně ohlašovány. Ikonu aktivujete klávesou Mezerník.

je možné přidat další panely, či na stávající panely přidat další ikony.
Příslušnou nabídku otevřete klávesovou zkratkou Shift+F10. Na pracovní
plochu se můžete opět vrátit zkratkou CTRL+ALT+D.

## Prohlížení webu

Fegora má předinstalovaný prohlížeč Mozilla Firefox. Prohlížení
internetu s Firefoxem a odečítačem Orca se příliš neliší třeba od
kombinace Firefox a NVDA. Klávesa TAB funguje podle očekávání a můžete
ji použít k přesunu mezi odkazy a formulářovými prvky. Dále Orca
disponuje dvěma módy prohlížení, mezi nimiž se přepínáte pomocí zkratky
Orca+A.

Režim prohlížení doporučuji používat, pokud se potřebujete pohybovat po
stránce a číst text. Můžete použít spoustu klávesových zkratek pro
přecházení po různých ovládacích prvcích. Například klávesa H vás
přenese na následující nadpis. Kombinace Shift+H na předchozí. A
kombinace ALT+SHIFT+H zobrazí seznam všech nadpisů. Pro seznam všech
takovýchto zkratek doporučuji v aktivním okně Firefox zapnout výukový
režim a stisknout klávesu F3. Samozřejmě fungují kurzorové šipky včetně
jejich kombinací s klávesou Shift pro výběr textu.

Režim zaměřování by se dal přirovnat k formulářovému režimu v NVDA.
Používá se v případě, kdy pracujete s formuláři. V takovém režimu můžete
psát do editačních polí, přepínat přepínače a podobně. V režimu
prohlížení by toto nefungovalo, protože by většinu kláves odchytával
odečítač a přesouval vás po stránce.

Odečítač by měl rozpoznat, kdy jste vstoupili do formuláře a automaticky
se přepínat mezi režimy prohlížení a zaměřování. Je to indikováno pouze
hlasem, nikoli zvukem. Pokud se chcete přepínat mezi režimy sami,
použijte zkratku Orca+A. Pokud ji stisknete dvakrát rychle za sebou,
uzamkne se režim zaměřování a zůstane aktivní i v případě, kdy opustíte
formulář. Může se to hodit na některých složitějších stránkách.

## Virtuální plochy

Součástí grafického prostředí jsou tzv. virtuální plochy. Představte si,
že před sebou máte čtyři monitory a na každém máte otevřená jiná okna.
Přesně tak virtuální plochy fungují. Nemusíte tak dlouze procházet
seznam všech oken a hledat to správné. Na jedné ploše můžete mít třeba
okna prohlížeče, na jiné rozpracovaný dokument atd.

Ve výchozím nastavení máte připraveny čtyři virtuální plochy vedle sebe,
při čemž po přihlášení se nacházíte na té nejvíce vlevo. Mezi plochami
se přesouváte pomocí zkratky CTRL+ALT+šipky. Pokud otevřete okno na
nějaké ploše, tak už tam zůstane. Můžete jej ale přesunout. Stačí se do
okna přepnout a použít kombinaci CTRL+ALT+SHIFT+šipky.

## Kde seženu další informace?

Hlavní stránka, ze které můžete získat informace o upravené distribuci
Fegora se nachází [zde](https://a-fs.cz/fedora-29-mate-pro-nevidome/).
Na této stránce budou nejnovější informace o distribuci a bude zde i
odkaz ke stažení obrazu aktuální verze či dalších užitečných souborů.

Zároveň vám velmi doporučujeme přihlásit se do [emailové
konference](https://a-fs.cz/emailova-konference/), která je zřízena
společně se stránkou a-fs.cz. V této konferenci budeme také posílat
aktuální novinky ohledně Fegory a hlavně je to místo, kde budeme
odpovídat na vaše dotazy a podněty.

Druhou konferencí, kterou doporučím, je konference odečítače Orca. Je v
angličtině, ale je velmi aktivní. Nachází se
[zde](https://mail.gnome.org/mailman/listinfo/orca-list).

Jak jsme psali výše, Fegora je založena na distribuci Fedora. České
stránky věnující se této distribuci jsou
[zde](https://www.mojefedora.cz), oficiální anglické pak
[zde](https://getfedora.org).

Můžete nás také kontaktovat na emailových adresách uvedených na začátku
tohoto dokumentu.
