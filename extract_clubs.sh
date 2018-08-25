#!/usr/bin/env bash
cat data/raw_data.json | jq -c '.items[] | {player_id: .id, club_id: .club.id}' | json2csv -p -d ";" -k player_id,club_id > data/player_clubs.csv
cat data/raw_data.json | jq -c '.items[].club | {club_id: .id, club_name: .name, club_abbr_name: .abbrName}' | json2csv -p=false -d ";" -k club_id,club_name,club_abbr_name | sort -u > data/clubs.csv
# Add header line at the start of file
echo 'club_id;club_name;club_abbr_name' | cat - data/clubs.csv > temp && mv temp data/clubs.csv