#!/usr/bin/env bash
cat data/raw_data.json | jq -c '.items[] | {player_id: .id, nation_id: .nation.id}' | json2csv -p -d ";" -k player_id,nation_id > data/player_nations.csv
cat data/raw_data.json | jq -c '.items[].nation | {nation_id: .id, nation_name: .name, nation_abbr_name: .abbrName}' | json2csv -p=false -d ";" -k nation_id,nation_name,nation_abbr_name | sort -u > data/nations.csv
# Add header line at the start of file
echo 'nation_id;nation_name;nation_abbr_name' | cat - data/nations.csv > temp && mv temp data/nations.csv
