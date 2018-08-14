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
	< data/page1.txt > jq '.'
	