mkdir -p data
# Define columns to extract
DATA_COLUMNS=id,name,rating,position,quality,color,composure,height,weight,birthdate,age,acceleration,aggression,agility,balance,ballcontrol,foot,skillMoves,crossing,curve,dribbling,finishing,freekickaccuracy,gkdiving,gkhandling,gkkicking,gkpositioning,gkreflexes,headingaccuracy,interceptions,jumping,longpassing,longshots,marking,penalties,positioning,potential,reactions,shortpassing,shotpower,slidingtackle,sprintspeed,standingtackle,stamina,strength,vision,volleys,weakFoot,atkWorkRate,defWorkRate,playerType
# Parallel read and parse all pages from FUT API and write to single JSON file
parallel -j0 --progress --delay 0.01 --results results "curl -s https://www.easports.com/fifa/ultimate-team/api/fut/item?page={1} | jq -c '.items[] | {$DATA_COLUMNS}'" ::: {1..902} > data/all.json
# Convert JSON to CSV
cat data/all.json | json2csv -p -d ";" -k $DATA_COLUMNS > data/all.csv