--1. Start by getting a feel for the stream table and the chat table: 
--Select all columns from the first 20 rows.
--What columns do the tables have?

--  The CSV file contained headers in the first row which I was able to import into the DB and use as the column headers.
SELECT *
FROM stream
LIMIT 20;

-- The CSV file did nto contain headers, so I created a table in the DB and named all the fields manually.
SELECT *
FROM chat
LIMIT 20;

-- 2. What are the unique games in the stream table?
SELECT DISTINCT game
FROM stream;

-- 3. What are the unique channels in the stream table?
SELECT DISTINCT channel
FROM stream;

-- 4. What are the most popular games in the stream table? 
-- Create a list of games and their number of viewers using GROUP BY.
SELECT game, COUNT(*) as num_users
FROM stream
GROUP BY game
ORDER BY num_users DESC;
-- It depends on how you want to measure popularity - whether you want to measure which games get played the most regardless of whether it is the same player (device) continually logging in and playing at different times, or whether you want to see how many unique players play the game. 
-- If the former, COUNT all the rows, if the latter, COUNT (DISTINCT device_id).
-- Note - the dataset in the Code Academy web-based platform is much smaller than the downloadable data from GitHub.

-- 5. These are some big numbers from the game League of Legends (also known as LoL). 
-- Where are these LoL stream viewers located?
-- Create a list of countries and their number of LoL viewers using WHERE and GROUP BY. 
SELECT country, COUNT(*)
FROM stream
WHERE game = "League of Legends"
GROUP BY country
ORDER BY 2 DESC;

-- 6. The player column contains the source the user is using to view the stream (site, iphone, android, etc).
-- Create a list of players and their number of streamers.
SELECT player, COUNT(*)
FROM stream 
GROUP BY player
ORDER BY 2 DESC;

-- 7. Create a new column named genre for each of the games.
-- Group the games into their genres: Multiplayer Online Battle Arena (MOBA), First Person Shooter (FPS), Survival, and Other.
SELECT game,
  CASE game
    WHEN "League of Legends" THEN "MOBA"
	WHEN "Dota 2"  THEN "MOBA"
	WHEN "Heroes of the Storm" THEN "MOBA"
	WHEN "Counter-Strike: Global Offensive" THEN "FPS"
	WHEN "DayZ" THEN "Survival"
	WHEN "Survival Evolved" THEN "Survival"
	ELSE "Other"
  END AS "genre",
  COUNT(*)
FROM stream
GROUP BY game
ORDER BY 3 DESC;

-- 8-10. How does view count change in the course of a day?
SELECT strftime('%H', time) as "hour", COUNT(*)
FROM stream
WHERE country = "AU"
GROUP BY 1
ORDER BY 2 DESC;

-- 11. The stream table and the chat table share a column: device_id. Let’s join the two tables on that column.
SELECT *
FROM stream
JOIN chat
  ON stream.device_id = chat.device_id
 LIMIT 10;
 
 -- 12. Our own queries
 -- What is the date range for the stream data?
 SELECT MIN(time) AS earliest, MAX(time) AS latest
 FROM stream;
 -- Answer: The stream table contains data from midnight on 1 January 2015 until 11:59pm on 1 January 2015.
 
 -- How many unique devices (users?) stream from Twitch in this time?
 SELECT COUNT(DISTINCT device_id)
 FROM stream;
-- Answer: 267629 unique devices streamed from Twitch.

-- How many devices played more than one game?
WITH number_of_games_each_device AS (
  SELECT device_id, COUNT(DISTINCT game) AS num_of_games
  FROM stream
  WHERE device_id IS NOT NULL
  GROUP BY device_id
  ORDER BY 2 DESC
)
SELECT COUNT(*)
FROM number_of_games_each_device
WHERE num_of_games > 1;
 
 
