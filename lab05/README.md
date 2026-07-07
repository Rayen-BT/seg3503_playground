# Lab 05 - Stubs, Mocks et Architecture

## Grades (Elixir/Phoenix)

Au debut, l'app plante des que je clique sur "Calculate". L'erreur est claire :
`Grades.Calculator.letter_grade/1` n'existe pas, le module n'a jamais ete cree.
`GradesWeb.PageLive` s'attend a ce que ce module existe deja avec trois
fonctions (`percentage_grade`, `numeric_grade`, `letter_grade`), mais personne
ne les a ecrites.

### Le stub

J'ai cree un `Grades.Calculator` qui retourne toujours les memes valeurs
peu importe ce qu'on entre dans le formulaire (75.0% / 6 / B). Ca enleve
le crash tout de suite, mais evidemment ce n'est pas la vraie note. C'est
juste la pour montrer que l'app peut fonctionner de bout en bout (le
formulaire, le bouton, l'affichage) avant meme que le calcul soit fait.
Ca permet de separer le travail : on peut tester l'UI sans attendre que
la logique de calcul soit prete.

### La vraie implementation

Ensuite j'ai remplace le stub par une vraie logique de calcul :
- Devoirs : 20%
- Labos : 20%
- Intra : 30%
- Final : 30%

Le pourcentage final est converti en note lettre et en note numerique
sur l'echelle sur 10 de l'Universite d'Ottawa. J'ai aussi ajoute des
tests ExUnit dans `test/grades/calculator_test.exs` pour verifier
quelques cas (note parfaite, formulaire vide, cas realiste).

Petit detail d'environnement : mon setup Elixir de base ne pouvait meme
pas compiler le projet a cause de versions trop recentes (cowlib/cowboy
pas compatibles avec mon OTP, et webpack qui plantait avec Node 22 a
cause d'OpenSSL). J'ai du mettre a jour cowboy/cowlib/plug_cowboy et
ajouter `NODE_OPTIONS=--openssl-legacy-provider` pour que tout demarre.

## Twitter (Java, EasyMock)

### Probleme d'environnement (avant meme les tests)

Deux choses ont du etre corrigees juste pour que `./bin/test` tourne sur
mon PC Windows :

1. Le classpath dans `bin/compile` et `bin/test` utilisait `:` comme
   separateur, ce qui marche sur Mac/Linux mais pas sur Windows (il faut
   `;`).
2. Une fois ca corrige, je suis tombee exactement sur le bug montre dans
   les slides : EasyMock (via cglib) essaie de faire un `setAccessible`
   sur une classe interne du JDK, et ca plante sur les versions recentes
   de Java parce que le module `java.base` n'est pas "ouvert". Le fix
   est celui suggere dans les slides : ajouter
   `--add-opens java.base/java.lang=ALL-UNNAMED` a la commande java dans
   `bin/test`.

### Les 4 tests manquants

Je les ai implementes avec `partialMockBuilder(Twitter.class).addMockedMethod("loadTweet")`,
comme dans `mock_partial_object()` deja fourni. L'idee c'est de mocker
seulement `loadTweet()` pour controler exactement le contenu du tweet, et
de laisser `isMentionned()` s'executer normalement.

En lancant les tests juste apres les avoir ecrits, 2 vrais bugs sont
sortis :

1. **`isMentionned_handleNull` plante avec un NullPointerException.**
   Le code fait `tweet.contains(...)` sans jamais verifier si `tweet`
   est `null`. Or `loadTweet()` peut retourner `null` (~10% du temps en
   vrai), et le code n'etait pas prepare pour ca.

2. **`isMentionned_dontReturnSubstringMatches` echoue.**
   Pour un tweet `"hello @meat"`, `isMentionned("me")` retournait `true`
   au lieu de `false`. En fait `"hello @meat".contains("@me")` est vrai,
   parce que `String.contains()` fait juste une recherche de sous-chaine :
   `"meat"` commence par `"me"`, donc ca matche alors que ca ne devrait
   pas.

Ces deux bugs auraient ete tres difficiles a attraper en testant avec le
vrai `loadTweet()`, vu qu'il est aleatoire et prend 4 secondes a chaque
appel. C'est exactement pour ca qu'on mocke : ca permet de forcer le
tweet exact qu'on veut tester, a chaque fois, instantanement.

### La correction

J'ai corrige `isMentionned()` dans `Twitter.java` pour :
- retourner `false` tout de suite si le tweet est `null`
- utiliser une regex avec frontiere de mot (`@nom\b`) au lieu de
  `String.contains`, pour eviter que "@meat" matche "me"

Apres la correction, les 4 nouveaux tests passent a chaque fois. Le test
`actual_call()` qui etait deja la echoue encore de temps en temps, mais
c'est normal : il appelle le vrai `loadTweet()` (aleatoire) et ne verifie
que le cas "@me", donc il rate chaque fois que le tirage donne "@you" ou
`null`. C'est justement la lenteur et l'instabilite que le mock permet
d'eviter dans les autres tests.

## Resume des commits

1. Unzip initial, avant toute modification, l'app plante
2. `grades`: Calculator stubbe (valeurs fixes)
3. `twitter`: corrections d'environnement (classpath Windows + EasyMock/JDK)
4. `twitter`: 4 tests implementes, 2 bugs decouverts
5. `twitter`: correction du code (null + substring)
6. `grades`: vraie implementation du Calculator
