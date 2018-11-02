# Oblig2-INF122

Du skal skrive all kode til obligen i dette repoet. 

## Installasjonsinstrukser

#### Før du starter må du ha dette installert:
1. Git (https://www.atlassian.com/git/tutorials/install-git)
2. Haskell og Cabal (https://www.haskell.org/platform/) 

#### Installasjon

1. Åpne terminal og naviger til en passende mappe

2. Klon repoet:
```
git clone git@github.com:aaalvik/Oblig2-INF122.git
cd Oblig2-INF122
```

3. Start å kode! 


## Instrukser til Del 2

For å få kompilert og kjørt koden i denne mappen må du bruke ```cabal```, fordi det er brukt noen pakker som ikke fungerer i ghci.

For å bygge prosjektet (kompilere):
```
cd Del2
cabal build
```

For å kjøre programmet, altså main-funksjonen i Main.hs:
```
cabal run 
```

