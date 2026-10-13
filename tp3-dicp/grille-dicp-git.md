# Grille DICP appliquee a Git

| Critere | Git le garantit ? | Preuve tiree du TP (commande + observation) | Ce qu'il faut ajouter |
|---|---|---|---|
| **D** isponibilite | Oui | `git clone` d'un depot puis suppression du dossier local : le depot est reconstitue a l'identique depuis le clone. Chaque clone est une copie complete. | Une sauvegarde hors de la forge : si le compte est ferme, les clones restent, mais plus la forge. |
| **I** ntegrite | Oui | `git cat-file -p HEAD` affiche l'empreinte SHA-1 de l'arbre et du parent ; modifier un octet d'un fichier commite change l'empreinte (effet avalanche). | Rien pour detecter l'alteration ; mais `git push --force` peut reecrire : protection de branche necessaire. |
| **C** onfidentialite | Non | `git log -p` affiche en clair tout le contenu de l'historique ; sur un depot public, sans aucun compte. Git ne chiffre rien. | Le chiffrement (AES) pour les donnees, et surtout : ne jamais versionner le secret. Depot prive + habilitations. |
| **P** reuve | Partiellement | `git log --format='%an %ae %ad'` affiche l'auteur... que l'on peut choisir : `git -c user.name="Quelqu'un" commit` attribue le commit a n'importe qui. | La **signature** des commits (`git commit -S`) avec une cle privee : la tracabilite devient non-repudiation. |

## Conclusion pour le DPO

« Les donnees sont versionnees dans Git » **n'est pas** une mesure de securite
suffisante pour le registre. Git garantit la disponibilite et l'integrite, mais il
n'apporte **aucune confidentialite** — sur un depot public, l'historique est
lisible par le monde entier, sans compte — et sa tracabilite est **declarative** :
l'auteur d'un commit est un champ librement renseigne, pas une preuve.

A la place, il faut ecrire : « le registre est versionne dans un depot **prive**,
dont les acces sont nominatifs et revus, protege en ecriture sur `main`, et dont
les commits sont **signes** ; les donnees personnelles n'y figurent pas en clair. »
