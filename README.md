[![Waffle.io - Columns and their card count](https://badge.waffle.io/smomni/fut-scrape.svg?columns=all)](https://waffle.io/smomni/fut-scrape)

# fut-scrape

fut-scrape is a tool for scraping and analyzing FIFA Ultimate Team ("FUT") player stats using bash, SQL and Python.
## Motivation

I have a background in Python, R and Octave/Matlab but I've never quite got the hang of bash. Until I decided to pick a book called "Data Science at the Command Line: Facing the Future with Time-Tested Tools" by Jeroen Janssens (2014). I got inspired by the concept of Unix pipes and the robustness of bash command line tools, and wanted to excercise using those tools by doing a small project that I have personal interest in. Enter FIFA, a game second closest to my heart right after my high school sweetheart World of Warcraft. Electronic Arts ("EA") has an API for querying FUT player card stats which I utilize in this project. 

This project has the following objectives:

1. Scrape and archive FUT player card stats starting from FIFA 18
2. Explore the data and identify interesting correlations
3. Visualize the findings


## Prerequisites

* [git](https://git-scm.com/downloads)
* [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](https://www.vagrantup.com/downloads.html)

## Install instructions

1. Install git, Virtualbox and Vagrant
2. Use git clone to download the repository: `git clone https://github.com/smomni/fut-scraper`
3. Go to download directory: `cd fut-scraper`
4. Initialize and start the Vagrant box: `vagrant up`
5. Connect to the Vagrant box via SSH: `vagrant ssh`

Local files in the `fut-scraper` directory are mapped to `/vagrant` in the Vagrant box.

## Data workflow

The data workflow is implemented using [Drake](https://github.com/Factual/drake) in a [Drakefile](Drakefile). To execute the workflow, run `drake` in shell.
