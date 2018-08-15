# Setup

	mkdir ds-toolbox
	cd ds-toolbox
	# Use the data-science-at-the-command-line Vagrant box
	vagrant init data-science-toolbox/data-science-at-the-command-line
	# Start the Vagrant box
	vagrant up
	# Connect to the Vagrant box via SSH (NOTE: Windows requires Cygwin or similar)
	# Login info (user: vagrant, pw: vagrant)
	vagrant ssh
	# Hint: Local files in the `ds-toolbox` folder are mapped to the virtualbox folder `/vagrant`
	
	
# Download data 

	# Make data directory that is mapped on local storage
	mkdir /vagrant/data
	cd /vagrant
	curl -s https://www.easports.com/fifa/ultimate-team/api/fut/item?page=1 > data/page1.txt
	# Parse JSON
	cat data/page1.txt | jq '.items[] | {id, name, rating, position, quality, color, composure, height, weight, birthdate, age, acceleration, aggression, agility, balance, ballcontrol, foot, skillMoves, crossing, curve, dribbling, finishing, freekickaccuracy, gkdiving, gkhandling, gkkicking, gkpositioning, gkreflexes, headingaccuracy, interceptions, jumping, longpassing, longshots, marking, penalties, positioning, potential, reactions, shortpassing, shotpower, slidingtackle, sprintspeed, standingtackle, stamina, strength, vision, volleys, weakFoot, atkWorkRate, defWorkRate, playerType}'

	# Serial read all pages from FUT API and write to separate files
	parallel -j1 --progress --delay 0.1 --results results "curl -s https://www.easports.com/fifa/ultimate-team/api/fut/item?page={1} > data/page{1}.txt" ::: {1..902}
	# Computer:jobs running/jobs completed/%of started jobs/Average seconds to complete
	# local:0/902/100%/1.4s

	# Parallel read and parse all pages from FUT API and write to single file
	parallel -j0 --progress --delay 0.01 --results results "curl -s https://www.easports.com/fifa/ultimate-team/api/fut/item?page={1} | jq '.items[] | {id, name, rating, position, quality, color, composure, height, weight, birthdate, age, acceleration, aggression, agility, balance, ballcontrol, foot, skillMoves, crossing, curve, dribbling, finishing, freekickaccuracy, gkdiving, gkhandling, gkkicking, gkpositioning, gkreflexes, headingaccuracy, interceptions, jumping, longpassing, longshots, marking, penalties, positioning, potential, reactions, shortpassing, shotpower, slidingtackle, sprintspeed, standingtackle, stamina, strength, vision, volleys, weakFoot, atkWorkRate, defWorkRate, playerType}'" ::: {1..902} > data/all.json
	# Computer:jobs running/jobs completed/%of started jobs/Average seconds to complete
	# local:0/902/100%/0.0s

	# TODO: JSON to csv (Note that jq has -c flag!)
	cat data/page1.txt | jq -c '.items[] | {id, name, rating, position, quality, color, composure, height, weight, birthdate, age, acceleration, aggression, agility, balance, ballcontrol, foot, skillMoves, crossing, curve, dribbling, finishing, freekickaccuracy, gkdiving, gkhandling, gkkicking, gkpositioning, gkreflexes, headingaccuracy, interceptions, jumping, longpassing, longshots, marking, penalties, positioning, potential, reactions, shortpassing, shotpower, slidingtackle, sprintspeed, standingtackle, stamina, strength, vision, volleys, weakFoot, atkWorkRate, defWorkRate, playerType}' | json2csv -p -k id,name,rating | csvlook
	cat data/all.json | json2csv -p -k name > data/all.csv





	