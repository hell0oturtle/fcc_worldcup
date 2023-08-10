#! /bin/bash
if [[ $1 == "test" ]]; then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "Total number of goals in all games from winning teams:"
$PSQL "SELECT SUM(winner_goals) FROM games;"

echo -e "\nTotal number of goals in all games from both teams combined:"
$PSQL "SELECT SUM(winner_goals + opponent_goals) FROM games;"

echo -e "\nAverage number of goals in all games from the winning teams:"
$PSQL "SELECT AVG(winner_goals) FROM games;"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
$PSQL "SELECT ROUND(AVG(winner_goals)::numeric, 2) FROM games;"

echo -e "\nAverage number of goals in all games from both teams:"
$PSQL "SELECT AVG(winner_goals + opponent_goals) FROM games;"

echo -e "\nMost goals scored in a single game by one team:"
$PSQL "SELECT MAX(winner_goals) FROM games;"

echo -e "\nNumber of games where the winning team scored more than two goals:"
$PSQL "SELECT COUNT(*) FROM games WHERE winner_goals > 2;"

echo -e "\nWinner of the 2018 tournament team name:"
$PSQL "SELECT teams.name FROM games INNER JOIN teams ON games.winner_id = teams.team_id WHERE games.year = 2018 AND games.round = 'Final';"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
$PSQL "SELECT DISTINCT teams.name FROM teams INNER JOIN games ON teams.team_id = games.winner_id OR teams.team_id = games.opponent_id WHERE games.year = 2014 AND games.round = 'Eighth-Final' ORDER BY teams.name;"


echo -e "\nList of unique winning team names in the whole data set:"
$PSQL "SELECT DISTINCT name FROM teams WHERE team_id IN (SELECT winner_id FROM games) ORDER BY name;"

echo -e "\nYear and team name of all the champions:"
$PSQL "SELECT year, (SELECT name FROM teams WHERE team_id = winner_id) FROM games WHERE round = 'Final' ORDER BY year;"

echo -e "\nList of teams that start with 'Co':"
$PSQL "SELECT teams.name FROM teams WHERE teams.name LIKE 'Co%';"
