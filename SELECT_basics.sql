# show the population of Germany
SELECT population 
FROM world
WHERE name = 'Germany'

#Show the name and the population for 'Sweden', 'Norway' and 'Denmark'.
SELECT name, population 
FROM world
WHERE name IN ('Sweden', 'Norway', 'Denmark');

#show the country and the area for countries with an area between 200,000 and 250,000.
SELECT name, area 
FROM world
WHERE area BETWEEN 200000 AND 250000

#quiz
#1. Select the code which produces this table
# 1 => 3
# 2 => E
# 3 => 5
# 4 => 3
# 5 => 3
# 6 => 3
# 7 => 3