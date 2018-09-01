#!/usr/bin/env bash
# Convert JSON to CSV
cat data/raw_data.json | jq -c '.items[] | {player_id: .id, club_id: .club.id}' | json2csv -p -d ";" -k player_id,club_id > data/player_clubs.csv
# Convert JSON to CSV, take only unique values and add header line
cat data/raw_data.json | jq -c '.items[].club | {club_id: .id, club_name: .name, club_abbr_name: .abbrName}' | json2csv -p=false -d ";" -k club_id,club_name,club_abbr_name | sort -u | header -a 'club_id;club_name;club_abbr_name' > data/clubs.csv