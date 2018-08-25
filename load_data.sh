#!/usr/bin/env bash
mkdir -p data
# Load page 1 as sample data
curl -s https://www.easports.com/fifa/ultimate-team/api/fut/item?page=1 | jq '.' > data/sample_raw_data.json
# Parallel query all pages from FUT API and write to single JSON file
parallel -j0 --progress --delay 0.01 --results results "curl -s https://www.easports.com/fifa/ultimate-team/api/fut/item?page={1}" ::: {1..902} > data/raw_data.json