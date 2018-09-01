#!/usr/bin/env bash
# Convert JSON to CSV
cat data/raw_data.json | jq -c '.items[] | {player_id: .id, league_id: .league.id}' | json2csv -p -d ";" -k player_id,league_id > data/player_leagues.csv
# Convert JSON to CSV, take only unique values and add header line
cat data/raw_data.json | jq -c '.items[].league | {league_id: .id, league_name: .name, league_abbr_name: .abbrName}' | json2csv -p=false -d ";" -k league_id,league_name,league_abbr_name | sort -u | header -a 'league_id;league_name;league_abbr_name' > data/leagues.csv