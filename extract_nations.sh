#!/usr/bin/env bash
# Convert JSON to CSV
cat data/raw_data.json | jq -c '.items[] | {player_id: .id, nation_id: .nation.id}' | json2csv -p -d ";" -k player_id,nation_id > data/player_nations.csv
# Convert JSON to CSV, take only unique values and add header line
cat data/raw_data.json | jq -c '.items[].nation | {nation_id: .id, nation_name: .name, nation_abbr_name: .abbrName}' | json2csv -p=false -d ";" -k nation_id,nation_name,nation_abbr_name | sort -u | header -a 'nation_id;nation_name;nation_abbr_name' > data/nations.csv