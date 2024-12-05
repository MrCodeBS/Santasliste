#!/bin/bash

input_file="Namensliste.csv"
output_file="samichlaus_nachrichten.txt"
uebersicht_file="samichlaus_uebersicht.txt"

# Liste der Witze
jokes=(
  "Warum können Geister so schlecht lügen? Weil man durch sie hindurchsieht!"
  "Warum können Skelette so schlecht lügen? Weil sie keinen Körper haben!"
  "Warum können Vampire so schlecht lügen? Weil sie immer im Dunkeln tappen!"
  "Warum können Mumien so schlecht lügen? Weil sie immer eingewickelt sind!"
  "Warum können Zombies so schlecht lügen? Weil sie immer so zerstreut sind!"
)

# Nachrichten erstellen und in Datei speichern
{
  read
  while IFS=, read -r name ort artig; do
    joke=${jokes[$RANDOM % ${#jokes[@]}]}
    if [[ "$artig" == "ja" ]]; then
      nachricht="Ho, ho, ho! Lieber/Liebe $name, du warst dieses Jahr sehr artig! Der Samichlaus kommt bald zu dir nach $ort. Hier ist ein Witz für dich: $joke"
    else
      nachricht="Ho, ho, ho! Lieber/Liebe $name, du warst dieses Jahr nicht artig! Vielleicht besucht dich der Samichlaus nächstes Jahr in $ort. Hier ist ein Witz für dich: $joke"
    fi
    echo "$nachricht"
    echo "$nachricht" >> "$output_file"
    echo ""  # Neue Zeile als Lücke
  done
} < "$input_file"

# Ausgabe der Nachrichten in der Konsole
cat "$output_file"

# Bonus: Nachrichten nach Wohnorten sortieren und Sammelübersicht erstellen
declare -A orte

{
  read
  while IFS=, read -r name ort artig; do
    status="Nicht artig"
    if [[ "$artig" == "ja" ]]; then
      status="Artig"
    fi
    orte["$ort"]+="$name: $status"$'\n'
  done
} < "$input_file"

for ort in "${!orte[@]}"; do
  echo "$ort:" >> "$uebersicht_file"
  echo "${orte[$ort]}" >> "$uebersicht_file"
  echo "" >> "$uebersicht_file"
done