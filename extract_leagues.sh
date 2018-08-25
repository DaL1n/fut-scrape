#!/usr/bin/env bash
cat data/raw_data.json | jq -c '.items[] | {player_id: .id, league_id: .league.id}' | json2csv -p -d ";" -k player_id,league_id > data/player_leagues.csv
cat data/raw_data.json | jq -c '.items[].league | {league_id: .id, league_name: .name, league_abbr_name: .abbrName}' | json2csv -p=false -d ";" -k league_id,league_name,league_abbr_name | sort -u > data/leagues.csv
# Add header line at the start of file
echo 'league_id;league_name;league_abbr_name' | cat - data/leagues.csv > temp && mv temp data/leagues.csv