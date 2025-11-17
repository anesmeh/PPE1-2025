#!/bin/bash

# Vérifie qu'un fichier d'URLs est fourni
if [ -z "$1" ]; then
  echo "Usage : $0 fichier_urls"
  exit 1
fi

echo "<html><head><meta charset='UTF-8'><title>Mini projet</title></head><body>" > tableaux/tableau-fr.html
echo "<h1>Analyse des URLs</h1>" >> tableaux/tableau-fr.html
echo "<table border='1'>" >> tableaux/tableau-fr.html
echo "<tr><th>ligne</th><th>url</th><th>code</th><th>encodage</th><th>mots</th></tr>" >> tableaux/tableau-fr.html

n=0

while read -r url
do
  n=$((n+1))

  # Récupération de la page
  curl -s "$url" -D header.txt -o page.html

  # Code HTTP
  code=$(grep "HTTP/" header.txt | head -n1 | awk '{print $2}')

  # Encodage (très simple)
  enc=$(grep -i "charset=" header.txt | sed 's/.*charset=//' | head -n1)
  if [ -z "$enc" ]; then
    enc="inconnu"
  fi

  # Comptage des mots visibles (simplifié)
  texte=$(sed 's/<[^>]*>/ /g' page.html)
  mots=$(echo "$texte" | wc -w)

  # Ajout dans le tableau HTML
  echo "<tr><td>$n</td><td>$url</td><td>$code</td><td>$enc</td><td>$mots</td></tr>" >> tableaux/tableau-fr.html

done < "$1"

echo "</table></body></html>" >> tableaux/tableau-fr.html

echo "Fichier HTML généré dans tableaux/tableau-fr.html"
