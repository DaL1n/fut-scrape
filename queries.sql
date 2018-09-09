/* List all players in club "Real Madrid" */
SELECT DISTINCT a.name FROM players AS a JOIN player_clubs AS b USING (player_id) JOIN clubs AS c USING (club_id) WHERE club_name = "Real Madrid";
/* List all players and their maximum ratings in club "FC Barcelona" */
SELECT MAX(a.rating) as max_rating, a.name FROM players AS a JOIN player_clubs AS b USING (player_id) JOIN clubs AS c USING (club_id) WHERE club_name = "FC Barcelona" GROUP BY name ORDER BY max_rating DESC;
/* List all normal player cards (types 'rare' and 'standard') 
player_type: 
TEAM OF THE YEAR
TEAM OF THE SEASON
special edition
Icon
Team of the Week
man of the match
rare
standard
*/
SELECT * FROM players WHERE player_type IN ('standard', 'rare');
/* Top 10 club average player rating (normal cards only) */
SELECT club_name, AVG(rating) AS avg_rating FROM players JOIN player_clubs USING (player_id) JOIN clubs USING (club_id) WHERE player_type IN ('standard', 'rare') GROUP BY club_name ORDER BY avg_rating DESC LIMIT 10;
/* List best normal card rating for each player */
SELECT name, MAX(rating) as max_rating FROM players WHERE player_type IN ('standard', 'rare') GROUP BY (name) ORDER BY max_rating DESC;
/* Best normal card in position */
SELECT position, MAX(rating) AS max_rating, name, club_name as max_rating FROM players JOIN player_clubs USING (player_id) JOIN clubs USING (club_id) WHERE player_type IN ('standard', 'rare') GROUP BY (position) ORDER BY max_rating DESC;
/* Top 10 players with most Man of the Match ("MOTM") special cards */
SELECT name, club_name, COUNT(player_id) as motm_cards FROM players JOIN player_clubs USING (player_id) JOIN clubs USING (club_id) WHERE player_type = 'man of the match' GROUP BY name, club_name ORDER BY motm_cards DESC LIMIT 10;
/* Top 10 players with most Team of the Week ("TOTW") special cards */
SELECT name, club_name, COUNT(player_id) as motm_cards FROM players JOIN player_clubs USING (player_id) JOIN clubs USING (club_id) WHERE player_type = 'Team of the Week' GROUP BY name, club_name ORDER BY motm_cards DESC LIMIT 10;