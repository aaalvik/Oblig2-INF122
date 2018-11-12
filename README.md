# Oblig2-INF122

Du skal skrive all kode til obligen i dette repoet. Hver deloppgave forklarer hvilken fil/mappe du skal jobbe i. 

## Installasjonsinstrukser

#### Før du starter må du ha dette installert:
1. Git (https://www.atlassian.com/git/tutorials/install-git)
2. Stack (https://docs.haskellstack.org/en/stable/README/)

#### Installasjon

1. Åpne terminal/cmd og naviger til en passende mappe

2. Klon repoet:
```
git clone https://github.com/aaalvik/Oblig2-INF122.git
cd Oblig2-INF122
```

3. Start å kode! Hver deloppgave forklarer hvilken fil/mappe i repoet du skal jobbe i. 


## Instrukser til bruk av visAST

For å få kompilert og kjørt koden i mappen VisAST/ må du bruke ```stack```, fordi det er brukt noen eksterne pakker. Det betyr at du ikke får testet koden i ghci, men må følge instruksene under for å kompilere og kjøre: 

For å bygge prosjektet/kompilere (kan ta lang tid første gangen, og må gjøres på nytt for hver endring i koden):
```
cd VisAST
stack build
```

For å kjøre programmet i oppgave 1.1 – testing av parseren (fortsatt i mappen VisAST/)
```
stack exec TestParser-exe
```

For å kjøre programmet i oppgave 2.1 – utvidelse av mainStep
```
stack exec Del2-exe 
```

