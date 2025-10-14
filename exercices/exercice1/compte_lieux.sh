#!/usr/bin/bash

CHEMIN=$1
ANNEE=$2
#MOIS = $3
#NB_LIEUX = $3
echo "fichier lieux.txt créé dans le répertoire courant"
cat "$CHEMIN/$ANNEE"/* \
  | awk '{ if ($2 == "Location") print $5 }' \
  | sort -k1,1 \
  | uniq -c \
  | sort -n -r -k1,1 \
  > lieux.txt
