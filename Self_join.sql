# How many stops are in the database.
SELECT COUNT(*)
  FROM stops

# Find the id value for the stop 'Craiglockhart'
SELECT id
  FROM stops
 WHERE name = 'Craiglockhart'

# Give the id and the name for the stops on the '4' 'LRT' service.
SELECT id, name
  FROM stops
  JOIN route ON route.stop = stops.id
 WHERE num = 4
   AND company = 'LRT'
 ORDER BY pos

# The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53).
SELECT company, num, COUNT(*) AS count
  FROM route WHERE stop=149 OR stop=53
 GROUP BY company, num
HAVING count = 2

# Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes.
SELECT a.company, a.num, a.stop, b.stop
  FROM route a JOIN route b ON
      (a.company=b.company AND a.num=b.num)
 WHERE a.stop=53
   AND b.stop=149

# The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name
SELECT a.company, a.num, stopa.name, stopb.name
  FROM route a JOIN route b ON
      (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
 WHERE stopa.name='Craiglockhart'
   AND stopb.name='London Road'

# Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')
SELECT a.company, a.num
  FROM route a JOIN route b ON
      (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
 WHERE stopa.id='115'
   AND stopb.id='137'
 GROUP BY company, num

# Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
SELECT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'
  AND stopb.name='Tollcross'
GROUP BY company, num

# Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself
SELECT stopb.name, a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'

# Find the routes involving two buses that can go from Craiglockhart to Lochend.
SELECT first.num, first.company, first.name, second.num, second.company
FROM
  (SELECT stops.name, a.num, a.company FROM route a
     JOIN route b ON (a.num=b.num AND a.company=b.company)
     JOIN stops ON (stops.id=a.stop)
    WHERE b.stop = (SELECT id FROM stops
                    WHERE name = 'Craiglockhart')) AS first
  JOIN
  (SELECT stops.name, a.num, a.company FROM route a
     JOIN route b ON (a.num=b.num AND a.company=b.company)
     JOIN stops ON (stops.id=a.stop)
    WHERE b.stop = (SELECT id FROM stops
                    WHERE name = 'Lochend')) AS second
WHERE first.name=second.name