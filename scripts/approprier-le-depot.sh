#!/usr/bin/env bash
# ============================================================
#  approprier-le-depot.sh
#  Bloc 3 SIO1 - Prerequis du TP5
#
#  Transforme ce clone en VOTRE depot "bloc3-cyber" :
#    - le recopie, avec tout son historique, dans
#      Bureau/bloc3-sio1/bloc3-cyber (l'emplacement attendu par les TP) ;
#    - y branche VOTRE depot distant GitHub ;
#    - ajoute un commit de reprise signe de VOTRE nom.
#
#  A lancer dans Git Bash, depuis la racine du clone :
#      bash scripts/approprier-le-depot.sh VOTRE-USERNAME-GITHUB
# ============================================================

set -e

# ------------------------------------------------------------
# 1. Le nom de compte GitHub
# ------------------------------------------------------------
USERNAME="$1"
if [ -z "$USERNAME" ]; then
    printf "Votre nom de compte GitHub : "
    read -r USERNAME
fi
if [ -z "$USERNAME" ]; then
    echo "Sans nom de compte GitHub, impossible de brancher le depot distant."
    echo "Relancez :  bash scripts/approprier-le-depot.sh VOTRE-USERNAME-GITHUB"
    exit 1
fi

# ------------------------------------------------------------
# 2. Verifications : on doit etre a la racine du clone
# ------------------------------------------------------------
if [ ! -d .git ] || [ ! -f scripts/approprier-le-depot.sh ]; then
    echo "Ce script doit etre lance depuis la racine du clone, ainsi :"
    echo "    cd bloc3-sio1-prerequis-tp5"
    echo "    bash scripts/approprier-le-depot.sh $USERNAME"
    exit 1
fi

# Par défaut : le Bureau, car le dossier personnel est un lecteur réseau.
BUREAU="$(cygpath -u "$USERPROFILE" 2>/dev/null)/Desktop"
[ -d "$BUREAU" ] || BUREAU="$HOME/Desktop"
DEST="$BUREAU/bloc3-sio1/bloc3-cyber"

if [ -e "$DEST" ]; then
    echo "Le dossier existe deja : $DEST"
    echo
    echo "Vous avez donc peut-etre deja un depot bloc3-cyber : dans ce cas,"
    echo "c'est LUI qu'il faut auditer au TP5, pas celui-ci."
    echo "Si vous voulez vraiment repartir de ce depot de mise a niveau,"
    echo "renommez ou supprimez d'abord le dossier ci-dessus."
    exit 1
fi

# ------------------------------------------------------------
# 3. La copie, avec tout l'historique
# ------------------------------------------------------------
mkdir -p "$BUREAU/bloc3-sio1"
git clone -q . "$DEST"
cd "$DEST"
git config core.safecrlf false

# ------------------------------------------------------------
# 4. Votre depot distant, a la place de celui du cours
# ------------------------------------------------------------
git remote set-url origin "https://github.com/$USERNAME/bloc3-cyber.git"

# ------------------------------------------------------------
# 5. Votre identite Git (c'est elle qui signera vos commits)
# ------------------------------------------------------------
NOM="$(git config user.name  || true)"
MAIL="$(git config user.email || true)"

if [ -z "$NOM" ]; then
    printf "Votre nom complet (il apparaitra dans l'historique) : "
    read -r NOM
    git config user.name "$NOM"
fi
if [ -z "$MAIL" ]; then
    printf "Votre e-mail GitHub : "
    read -r MAIL
    git config user.email "$MAIL"
fi

# ------------------------------------------------------------
# 6. Le commit de reprise : votre nom entre dans l'historique
# ------------------------------------------------------------
cat > MISE-A-NIVEAU.md <<EOF
# Reprise du depot

Ce depot a ete repris depuis le depot de mise a niveau du cours
(bloc3-sio1-prerequis-tp5), faute de depot bloc3-cyber disponible.

Repris par : $NOM <$MAIL>
Compte GitHub : https://github.com/$USERNAME
Le : $(date +%Y-%m-%d)

Les commits anterieurs a celui-ci ont des auteurs fictifs et des donnees
fictives : ils simulent un semestre de travail, pour que l'analyse de risques
du TP5 ait une matiere a auditer.
EOF

git add MISE-A-NIVEAU.md
git commit -q -m "Reprise du depot de mise a niveau pour le TP5"

# ------------------------------------------------------------
# 7. La suite, qui ne peut pas etre automatisee
# ------------------------------------------------------------
echo
echo "============================================================"
echo " Depot pret : $DEST"
echo " $(git rev-list --count HEAD) commits, dernier auteur : $NOM"
echo " origin -> $(git remote get-url origin)"
echo "============================================================"
echo
echo "Il reste 3 choses a faire, a la main :"
echo
echo " 1. Creer le depot VIDE sur github.com"
echo "    New repository -> nom : bloc3-cyber -> visibilite : Public"
echo "    -> NE PAS ajouter de README, de .gitignore ni de licence."
echo
echo " 2. Pousser l'historique :"
echo "      cd \"$DEST\""
echo "      git push -u origin main"
echo
echo " 3. Ajouter l'enseignant en collaborateur :"
echo "    Settings -> Collaborators -> Add people -> timotirob"
echo
echo "Vous pourrez alors faire le TP5 dans ce dossier."
