#!/bin/bash

echo "<html><body><table border='1'>" > tableau-fr.html

while IFS=$'\t' read -r a b c d e
do
  echo "<tr><td>$a</td><td>$b</td><td>$c</td><td>$d</td><td>$e</td></tr>" >> tableau-fr.html
done < tableau-fr.tsv

echo "</table></body></html>" >> tableau-fr.html
