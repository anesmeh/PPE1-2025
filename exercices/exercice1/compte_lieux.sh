#!/usr/bin/bash

CHEMIN=$1
ANNEE=$2
#MOIS = $3
#NB_LIEUX = $3
echo "heheh"
cat $CHEMIN/$ANNEE/* | sort -k5,5 | awk '{ if ($2 == "Location") print $5 }' | uniq -c >> lieux.txt