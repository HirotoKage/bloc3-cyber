# Prérequis TP5 — dépôt `bloc3-cyber` de mise à niveau

BTS SIO1 — Bloc 3 : Cybersécurité des services informatiques — 2026-2027 — T. Robert

## À qui s'adresse ce dépôt

Le **TP5 — Analyse de risques de la chaîne Git** s'appuie sur un dépôt que vous avez
normalement créé au **TP1** : `bloc3-cyber`, *public*, sur votre compte GitHub.
Sans lui, le TP5 n'a pas d'objet : il consiste à auditer **votre** chaîne Git.

Ce dépôt de mise à niveau est là si vous êtes dans l'un de ces cas :

- vous étiez **absent au TP1** ;
- vous n'avez **jamais créé** `bloc3-cyber` ;
- vous l'avez **perdu** (poste reformaté, dossier supprimé, dépôt supprimé) ;
- vous n'avez **plus accès** au compte GitHub du début d'année.

> **Si vous avez votre vrai `bloc3-cyber`, n'utilisez pas ce dépôt.** Travaillez sur
> le vôtre : les vulnérabilités que le TP5 vous fait constater doivent être les vôtres.

## Ce que contient ce dépôt

Un historique Git de 9 commits qui simule un semestre de travail sur le Bloc 3,
avec les livrables des TP précédents et quelques **défauts volontaires** — ce sont
eux que l'audit du TP5 doit mettre au jour.

| Chemin | Rôle |
|---|---|
| `tp1-rgpd/classification.csv` | Livrable TP1 : les colonnes de l'export auditées et classées (NP / DIR / IND / SENS) |
| `tp1-rgpd/rapport-audit.md` | Livrable TP1 : le rapport d'audit RGPD |
| `tp3-dicp/grille-dicp-git.md` | Livrable TP (DICP) : la grille D-I-C-P appliquée à Git, utile à l'étape 3 du TP5 |
| `data/participants-atelier.csv` | Fichier de **données personnelles versionné** — un défaut volontaire |
| `config/.env` | **Présent dans l'historique, absent du dernier état** : retiré par un commit, donc toujours là |
| `.gitignore` | Existe, mais **ne couvre pas `.env`** — autre défaut volontaire |
| `scripts/approprier-le-depot.sh` | Transforme ce clone en *votre* dépôt `bloc3-cyber` |

## Mise à niveau — à faire chez vous, avant la séance (~15 min)

### 1. Créez le dépôt vide sur votre compte GitHub

Sur github.com : **New repository** → nom `bloc3-cyber` → visibilité **Public** →
**n'ajoutez ni README, ni .gitignore, ni licence**. Le dépôt doit rester vide.

### 2. Clonez ce dépôt et appropriez-le

Dans **Git Bash** :

```bash
cd "$(cygpath -u "$USERPROFILE")/Desktop"
git clone https://github.com/timotirob/bloc3-sio1-prerequis-tp5.git
cd bloc3-sio1-prerequis-tp5
bash scripts/approprier-le-depot.sh VOTRE-USERNAME-GITHUB
```

Le script crée `Bureau/bloc3-sio1/bloc3-cyber` avec tout l'historique, y branche
*votre* dépôt distant, et ajoute un commit de reprise signé de *votre* nom.

### 3. Poussez

```bash
cd "$(cygpath -u "$USERPROFILE")/Desktop/bloc3-sio1/bloc3-cyber"
git push -u origin main
```

### 4. Ajoutez l'enseignant en collaborateur

Sur votre dépôt : **Settings** → **Collaborators** → **Add people** → `timotirob`.

### 5. Vérifiez — vous devez pouvoir répondre oui aux trois lignes

```bash
git remote -v          # origin pointe sur VOTRE compte
git log --oneline      # 10 commits, du TP0 au commit de reprise
git shortlog -sn HEAD  # votre nom apparaît
```

Vous êtes prêt pour le TP5 : le dossier `bloc3-cyber` est sur votre Bureau, le dépôt
est en ligne sur votre compte, et son historique a quelque chose à raconter.

## Avertissements

**Toutes les données de ce dépôt sont fictives.** Les noms, adresses e-mail et
« secrets » qu'il contient ont été fabriqués pour l'exercice. Le fichier
`config/.env` de l'historique ne donne accès à rien : ses valeurs sont des
marqueurs, pas des identifiants. C'est pour cela que ce dépôt *peut* être public.

**La règle du TP1 reste entière.** On ne pousse jamais sur une forge de vraies
données personnelles ni un vrai secret. Un secret réellement poussé doit être
considéré comme compromis et **renouvelé** : nettoyer l'historique ne suffit pas.
Ici vous auditez une mise en scène ; en entreprise, vous auditeriez un incident.

**N'auditez que vos propres dépôts.** La règle éthique du TP (OSINT) s'applique au
TP5 : jamais le compte d'un camarade sans son accord explicite.

---

### Note pour l'enseignant

Ce dépôt sert deux usages :

1. **la mise à niveau** des étudiants sans `bloc3-cyber` (procédure ci-dessus) ;
2. **le support de projection** de l'étape 2 du TP5 quand les dépôts de la classe
   sont trop vides : l'audit local y trouve un secret dans l'historique, un
   `.gitignore` incomplet et un fichier de données personnelles suivi.

Pour l'étape 2.2 (audit de la forge), les étudiants auditent *leur* copie sur *leur*
compte : visibilité, collaborateurs, 2FA et protection de `main` sont donc bien les
leurs, et les constats restent personnels.
