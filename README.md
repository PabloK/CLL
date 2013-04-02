CLL Kompetensnyckel demonstrator
===
Projektet som detta dokument följer med är en demonstrator av ett system som skall tas fram för Combitechs räkning. Systemet
tas fram för att synliggöra karriär vägar inom Combitech men också för att hjälpa till i reflektionen kring den personliga utvecklingen i sammband
med utvecklings samtalet.

Syfte med dokumentet
===
Detta dokument är tillför att ge en översiktlig bild av hur mjukvaran fungerar, installeras och vilka inställningar som behöver göras. För
mer komplett information av de olika delarn kan koden konsulteras. Koden skall vara väl kommenterad med beskrivningar av viktiga delar i systemet.

Installation
===
Systemet kan köras i de flesta ruby miljöer men är främst testat på linux med ruby 1.9.3, ruby gems och bundler installerat. En
för konfigurerad databas krävs också för att systemet skall fungera. Systemet är förkonfigurerat för att arbeta mot postgres.
Det finns exempel på den configuration som krävs för att systemet skall hitta din postgres instans i "config/bashrc.conf.example" .


För att få igång system:

```bash
git clone https://github.com/PabloK/CLL.git # Gör en kopia av koden
cd CLL
!!! Detta steg kan kräva att extra biblotek och kompilatorer installeras !!!
bundle install # Installerar nödvändiga biblotek
!!! Installera och konfigurera posgres !!!
!!! Konfigurera miljövariabler exempel finns i config/bashrc.conf.example!!! 
rake migrate # Migrerar databasen
rake autopopulate # Populerar databasen med defaultdata från config/default_data.yaml
rackup # Startar en server på den configurerade porten 
```

Kommandon
===

| Kommando | Beskrivning |
|-------------|-------------|
| rake migrate | Migrerar databasen |
| rake autopopulate | Populerar databasen med defaultdata från config/default_data.yaml |
| rake spec | Kör tester !!! Kräver att en testdatabas konfigurerats !!! |

Projekt struktur
===
| Fil/Mapp | Beskrivning |
|-------------|-------------|
| assets | Javascript och css som skall kompileras från coffeescript eller SASS innan användning. |
| config | Allmän konfiguration |$
| config.ru | Denna fil är projektets huvud fil och inkluderar allt annat den inehåller configuration av routes till de olika kontrollerarna |
| Gemfile | Listar biblotek som behövs av systemet. Används av bundler |
| Gemfile.lock | Listar nuvarande versioner på systemets biblotek. Används av bundler |$
| lib | Denna mapp inehåller projektets modeller och kontrollers  |
| public | Statiska bilder, javascript och css hamnar här |
| rakefile | Definierar rake kommandon som kan köras i skalet |
| spec | Testfiler hamnar i undermappar till denna mappen. Dessa test körs med hjälp av spec_helper och rake. |
| views | Html vyer hamnar här dessa är skrivna i templatespråket haml |

Projekt ansvariga
===
Pablo.Karlsson (pablo.karlsson@combitech.se)
Niclas Fock (niclas.fock@combitech.se)
