CLL Kompetensnyckel demonstrator
===

Detta är en demonstrator av hur ett verktyg för att synliggöra karriärvägar och förmågor inom ett konsultföretag kan se ut.

Installation
====
Systemet kan köras i de flesta ruby miljöer men är främst testat på linux under ruby 1.9.3 med ruby gems och bundler installerat. Systemet kräver också tillgång till en databas och är förkonfigurerat för posgresql, även om det går att konfigurera för exempelvis sqlite.
Systemet kräver alltså att en databas finns i bakgrunden för konfigurerad.

För att få igång system:

git clone https://github.com/PabloK/CLL.git # Gör en kopia av koden
cd CLL
bundle install # Installerar nödvändiga biblotek
!!! Konfigurera miljövariabler exempel finns i config/bashrc.conf.example!!! 
!!! Konfigurera en posgres databas !!!
rake migrate # Migrerar databasen
rake autopopulate # Populerar databasen med defaultdata från config/default_data.yaml
rackup # Startar en server på den configurerade porten

Kommandon
===
rake migrate # Migrerar databasen
rake autopopulate # Populerar databasen med defaultdata från config/default_data.yaml
rake spec # Kör tester !!! Kräver att en testdatabas konfigurerats !!!

Projekt struktur
===
assets # Javascript och css som skall kompileras från coffeescript eller SASS innan användning.
config # Allmän konfiguration
config.ru # Denna fil är projektets huvud fil och inkluderar allt annat den inehåller configuration av routes till de olika kontrollerarna
Gemfile # Listar biblotek som behövs av systemet. Används av bundler
Gemfile.lock # Listar nuvarande versioner på systemets biblotek. Används av bundler
lib # Denna mapp inehåller projektets modeller och kontrollers 
public # Statiska bilder, javascript och css hamnar här
rakefile # Definierar rake kommandon som kan köras i skalet
spec # Testfiler hamnar i undermappar till denna mappen. Dessa test körs med hjälp av spec_helper och rake.
TODO # Enkelt issuehanterings system
views # Html vyer hamnar här dessa är skrivna i templatespråket haml

Projekt ansvariga
===
Pablo.Karlsson (Pablo.Karlsson@combitech.se)
Niclas Fock (Niclas.Fock@combitech.se)
