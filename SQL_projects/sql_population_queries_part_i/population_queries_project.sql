-- 3. What years are covered by the dataset? (you can manually count the number of years returned).
SELECT DISTINCT year from population_years;

-- 4. What is the largest population size for Gabon in this dataset?
SELECT *
FROM population_years
WHERE country = 'Gabon'
ORDER BY population DESC
LIMIT 1;

-- 5. What were the 10 lowest population countries in 2005?
SELECT *
FROM population_years
WHERE year = 2005
ORDER BY population ASC
LIMIT 10;

-- 6. What are all the distinct countries with a population of over 100 million in the year 2010?
SELECT *
FROM population_years
WHERE population >100
	AND year = 2010;
	
-- 7. How many countries in this dataset have the word “Islands” in their name?
SELECT DISTINCT country
FROM population_years
WHERE country LIKE '%islands%';

-- 8. What is the difference in population between 2000 and 2010 in Indonesia?
-- Note: it’s okay to figure out the difference by hand after pulling the correct data.
SELECT * 
FROM population_years
WHERE country = 'Indonesia' 
	AND (year = 2000 OR year = 2010);