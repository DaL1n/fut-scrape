/* List all players in club "Real Madrid" */
SELECT DISTINCT a.name FROM players AS a JOIN player_clubs AS b USING (player_id) JOIN clubs AS c USING (club_id) WHERE club_name = "Real Madrid";
/* List all players and their maximum ratings in club "FC Barcelona" */
SELECT MAX(a.rating) as max_rating, a.name FROM players AS a JOIN player_clubs AS b USING (player_id) JOIN clubs AS c USING (club_id) WHERE club_name = "FC Barcelona" GROUP BY name ORDER BY max_rating DESC;