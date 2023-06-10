#!/bin/bash

fichier_commandes="tests"
fichier_resultats="results"
if [ ! -f "$fichier_commandes" ]; then
  echo "Le fichier $fichier_commandes n'existe pas."
  exit 1
fi

if [ -f "$fichier_resultats" ]; then
  rm "$fichier_resultats"
fi

counter=1
zob=1

echo "---------------------------" >> "$fichier_resultats"
while IFS= read -r commande; do
  if ((zob % 2 == 1)); then
    echo "[Exécution de la commande : $commande | Test N°$counter]" >> "$fichier_resultats"
    echo "" >> "$fichier_resultats"
    eval "$commande" >> "$fichier_resultats" 2>&1
    status=$?
    if [ $status -ne 0 ]; then
      echo "$output" | tr -d '\0' >> "$fichier_resultats"
    else
      echo -e "\033[0;32mTest N°$((counter-1)) : ✔\033[0m"
    fi
    echo "" >> "$fichier_resultats"
    echo "[Exit status : $status]" >> "$fichier_resultats"
    echo "" >> "$fichier_resultats"
    echo "---------------------------" >> "$fichier_resultats"
    echo "" >> "$fichier_resultats"
    counter=$((counter+1))
  fi
  zob=$((zob+1))
done < "$fichier_commandes"
