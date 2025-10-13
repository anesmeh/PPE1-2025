#!/bin/zsh

echo "argument donnÃ© : $1"

CHEMIN=$1
TYPE=$2
ANNEE=$3

echo "Nombre de $TYPE en $ANNEE :"
cat $CHEMIN/$ANNEE/* | grep $TYPE  | wc -l
