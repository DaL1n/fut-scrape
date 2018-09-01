#!/usr/bin/env bash
# SQLite does not support parallel insertions (the database is locked by one process)
parallel -j1 --progress --delay 0.1 --results results "echo -e '.separator ;\n.import /vagrant/data/{1}.csv {1}' | sqlite3 data/fut.db" ::: {clubs,leagues,nations,player_attributes,player_clubs,player_leagues,player_nations,player_specialities,player_traits,players}
