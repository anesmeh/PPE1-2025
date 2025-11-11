#Journal de bord du projet encadré




#Mini projet 1

1- Il ne faut pas utiliser cat avec une boucle while read  car cela crée un sous-shell.
Dans ce cas, les variables modifiées à l’intérieur de la boucle ne sont pas conservées après la fin de la boucle.

2- J’ai ajouté une vérification pour être sûr qu’un fichier est bien passé en argument :
if [ -z "$1" ]; then
  echo "Usage: $0 <fichier_urls>"
  exit 1
fi
et pour vérifier que le fichier existe :
if [ ! -f "$URLFILE" ]; then
  echo "Erreur : fichier introuvable"
  exit 2
fi

3-  J'ai ajouté un compteur n=$((n+1))

4- Pour chaque site :
J’ai utilisé curl pour télécharger le contenu et les en-têtes :
curl -s -L -D header.txt -o page.html "$url"
J’ai extrait :
le code HTTP avec :
grep "HTTP/" header.txt | tail -n1 | awk '{print $2}'
l’encodage avec grep "charset=" et un petit sed.
le nombre de mots en supprimant les balises HTML avec sed 's/<[^>]*>/ /g' puis wc -w.

5- J’ai affiché les résultats avec des tabulations :
echo -e "$n\t$url\t$code\t$enc\t$mots"
et j’ai redirigé la sortie vers un fichier TSV :
./programmes/miniprojet.sh urls/fr.txt > tableaux/tableau-fr.tsv


Problèmes rencontrés
Erreur avec sed sur macOS : le [:alnum:] ne fonctionnait pas dans ma regex


#Mini projet 2

Le script lit le fichier ligne par ligne.
La première ligne est traitée comme l’en-tête du tableau (<th>).
Les lignes suivantes sont ajoutées comme données (<td>).
Chaque valeur est insérée dans une cellule de tableau correspondante.

while IFS=$'\t' read -r a b c d e : lit le fichier TSV ligne par ligne, en séparant les colonnes par des tabulations (\t).
