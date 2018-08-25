#!/usr/bin/env bash
# Note that attributes.chemistryBonus is omitted from extract
cat data/raw_data.json | jq -c '.items[] | {player_id: .id, attribute_name: .attributes[].name, attribute_value: .attributes[].value}' | json2csv -p -d ";" -k player_id,attribute_name,attribute_value > data/player_attributes.csv