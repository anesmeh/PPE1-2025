#!/bin/bash

# Vérification des arguments
if [ -z "$1" ]; then
  echo "Usage: $0 <fichier_urls>"
  exit 1
fi

URLFILE="$1"

if [ ! -f "$URLFILE" ]; then
  echo "Erreur : fichier $URLFILE introuvable"
  exit 2
fi

echo -e "ligne\turl\tcode_http\tencodage\tnb_mots"

n=0

while read -r url
do
  n=$((n+1))

  # ignorer les lignes vides
  if [ -z "$url" ]; then
    echo -e "$n\t(ligne vide)\t-\t-\t0"
    continue
  fi

  # Récupérer la page et l'en-tête
  curl -s -L -D header.txt -o page.html "$url"

  # Code HTTP
  code=$(grep "HTTP/" header.txt | tail -n1 | awk '{print $2}')

  # Encodage (très basique)
  enc=$(grep -i "charset=" header.txt | head -n1 | sed -E 's/.*charset=([A-Za-z0-9._-]+).*/\1/')
  if [ -z "$enc" ]; then
    enc=$(grep -i -m1 "charset=" page.html | sed -E 's/.*charset=([A-Za-z0-9._-]+).*/\1/')
  fi
  if [ -z "$enc" ]; then
    enc="inconnu"
  fi

  # Compter les mots (en supprimant les balises HTML)
  texte=$(sed 's/<[^>]*>/ /g' page.html)
  mots=$(echo "$texte" | wc -w | tr -d ' ')

  # Afficher les résultats
  echo -e "$n\t$url\t$code\t$enc\t$mots"

done < "$URLFILE"

# Nettoyage
rm -f header.txt page.html
