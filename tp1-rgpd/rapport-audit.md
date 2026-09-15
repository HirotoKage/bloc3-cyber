# TP1 — Audit RGPD du depot MyCom

## Ce que l'audit a trouve

Deux fichiers problematiques ont ete introduits dans l'historique du depot
`mycom-audit` :

- un **export de production** place dans `data/`, contenant dix colonnes dont
  deux relevent de l'article 9 (le numero de securite sociale et un champ de
  commentaire libre ou figurent sante, appartenance syndicale et pratique
  religieuse) ;
- un **fichier de configuration** place dans `config/`, contenant les identifiants
  de connexion a la base de production et un jeton d'API.

Aucune valeur n'est recopiee ici : ce rapport cite les colonnes et les categories,
jamais le contenu. Un rapport d'audit qui recopie les donnees est lui-meme une fuite.

## Qui, et quand

`git log` attribue les deux ajouts au meme auteur, a quelques minutes d'intervalle,
dans la meme semaine. L'export a ete ajoute "pour tester l'import CSV" : c'est le
motif le plus courant des fuites de ce type. Deux semaines plus tard, un second
auteur a retire l'export en invoquant une alerte du DPO.

## La suppression n'efface pas

Le commit de retrait fait disparaitre le fichier du **dernier etat**, pas de
l'**historique**. `git log --diff-filter=D` le retrouve, et `git show` du commit
precedent affiche encore son contenu integral. Toute personne ayant clone le depot
en detient une copie complete, hors de portee de toute suppression ulterieure.

## Prevention

1. Un `.gitignore` couvrant `.env`, `*.csv` de production et les dossiers d'export,
   **avant** le premier commit : il protege l'avenir, pas le passe.
2. Des jeux de test **anonymises** (agregats, tranches d'age) pour tout ce qui
   sert a developper.
3. Pour un secret deja pousse : le **renouveler**. Nettoyer l'historique ne suffit
   pas, il faut considerer le secret comme compromis.
4. Une revue avant le premier `push` d'un depot vers une forge publique.
