-- How many entries in the database are from Africa?
SELECT COUNT(*) AS 'number of countries from Africa'
FROM countries
WHERE continent = 'Africa';

-- What was the total population of Oceania in 2005?
SELECT SUM(population_years.population) AS 'total pop. of oceania in 2005'
FROM countries
JOIN population_years
	ON countries.id = population_years.country_id
WHERE countries.continent = 'Oceania'
	AND population_years.year = 2005;

-- What is the average population of countries in South America in 2003?
SELECT ROUND(AVG(population_years.population),6) AS 'average pop. of south america in 2003'
FROM countries
JOIN population_years
	ON countries.id = population_years.country_id
WHERE countries.continent = 'South America'
	AND population_years.year = 2003;
	
-- What country had the smallest population in 2007?
SELECT countries.name, population_years.population
FROM population_years
JOIN countries
	ON population_years.country_id = countries.id
WHERE year = 2007 
	AND population_years.population IS NOT NULL
ORDER BY population_years.population
LIMIT 1;

-- What is the average population of Poland during the time period covered by this dataset?
SELECT ROUND(AVG(population_years.population), 6) AS 'average population of Poland'
FROM countries
JOIN population_years
	ON countries.id = population_years.country_id
WHERE countries.name = 'Poland';

-- How many countries have the word "The" in their name?
SELECT COUNT(*)
FROM countries
WHERE name LIKE '%the';

-- What was the total population of each continent in 2010?
SELECT countries.continent, SUM(population_years.population) AS 'total population in 2010'
FROM countries
JOIN population_years
	ON population_years.country_id = countries.id
WHERE population_years.year = 2010
GROUP BY countries.continent;

