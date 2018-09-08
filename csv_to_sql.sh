# csvsql does not work properly with GNU parallel, bash "for" loops or Drake
# Therefore, this is excecuted as a separate script
# Examples:
# 1. parallel -j1 --progress --delay 0.1 "csvsql --db sqlite:///data/fut.db --table {/.} --insert data/{}" ::: {players.csv,clubs.csv,leagues.csv,nations.csv,player_attributes.csv,player_clubs.csv,player_leagues.csv,player_nations.csv,player_specialities.csv,player_traits.csv}
# 		Only "players" table is inserted to the sqlite file data/fut.db
# 2. Drake workflow will hang if this script (or its contents) are executed there
csvsql --db sqlite:///data/fut.db --table clubs --insert data/clubs.csv
csvsql --db sqlite:///data/fut.db --table leagues --insert data/leagues.csv
csvsql --db sqlite:///data/fut.db --table nations --insert data/nations.csv
csvsql --db sqlite:///data/fut.db --table player_attributes --insert data/player_attributes.csv
csvsql --db sqlite:///data/fut.db --table player_clubs --insert data/player_clubs.csv
csvsql --db sqlite:///data/fut.db --table player_leagues --insert data/player_leagues.csv
csvsql --db sqlite:///data/fut.db --table player_nations --insert data/player_nations.csv
csvsql --db sqlite:///data/fut.db --table player_specialities --insert data/player_specialities.csv
csvsql --db sqlite:///data/fut.db --table player_traits --insert data/player_traits.csv
csvsql --db sqlite:///data/fut.db --table players --insert data/players.csv
# The following works in parallel and Drake but doesn't infer column data types and therefore is useless if we want to aggregate the sql data:
# parallel -j1 --progress --delay 0.1 "echo -e '.separator ;\n.import {} {/.}' | sqlite3 $OUTPUT" ::: $INPUTS