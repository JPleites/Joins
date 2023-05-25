1) Mostrar la lista de los ganadores de medalla de oro en eventos de Futbol, Baloncesto y Golf
SELECT p.full_name, e.event_name, c.city_name, g.games_name
FROM olympics.dbo.medal m
JOIN olympics.dbo.competitor_event ce ON ce.medal_id = m.id
JOIN olympics.dbo.games_competitor gc ON gc.id = ce.competitor_id
JOIN olympics.dbo.person p ON p.id = gc.person_id
JOIN olympics.dbo.event e ON e.id = ce.event_id
JOIN olympics.dbo.games g ON g.id = gc.games_id
JOIN olympics.dbo.games_city gcit ON gcit.games_id = g.id
JOIN olympics.dbo.city c ON c.id = gcit.city_id
JOIN olympics.dbo.sport s ON s.id = e.sport_id
WHERE m.medal_name = 'Gold' AND s.sport_name IN ('Football', 'Basketball', 'Golf');

2) Cuales son los eventos que se jugaron en el año 2000
SELECT e.event_name, g.games_name
FROM olympics.dbo.event e
JOIN olympics.dbo.games_competitor gc ON gc.games_id = e.games_id
JOIN olympics.dbo.games g ON g.id = e.games_id
WHERE g.games_year = 2000;

3) Cuales son las 20 principales ciudades donde se han jugado mas Olimpiadas
SELECT c.city_name, COUNT(gc.games_id) AS total_olympics
FROM olympics.dbo.city c
JOIN olympics.dbo.games_city gc ON gc.city_id = c.id
GROUP BY c.city_name
ORDER BY total_olympics DESC;

4) Liste los paises no tienen ningun participante en las ultimas 10 olimpiadas
SELECT nr.region_name
FROM olympics.dbo.noc_region nr
LEFT JOIN olympics.dbo.person_region pr ON pr.region_id = nr.id
LEFT JOIN olympics.dbo.games_competitor gc ON gc.person_id = pr.person_id
LEFT JOIN olympics.dbo.games g ON g.id = gc.games_id
WHERE g.games_year >= YEAR(GETDATE()) - 10
GROUP BY nr.region_name
HAVING COUNT(gc.id) = 0;

5) liste los 5 paises que mas ganan medallas de oro, plata y bronce
SELECT nr.region_name, COUNT(medal.id) AS total_medals
FROM olympics.dbo.noc_region nr
JOIN olympics.dbo.person_region pr ON pr.region_id = nr.id
JOIN olympics.dbo.games_competitor gc ON gc.person_id = pr.person_id
JOIN olympics.dbo.medal ON medal.id = gc.medal_id
WHERE medal.medal_name IN ('Gold', 'Silver', 'Bronze')
GROUP BY nr.region_name
ORDER BY total_medals DESC;

6) El evento con mayor cantidad de personas participando
SELECT e.event_name, COUNT(gc.id) AS total_participants
FROM olympics.dbo.event e
JOIN olympics.dbo.competitor_event ce ON ce.event_id = e.id
JOIN olympics.dbo.games_competitor gc ON gc.id = ce.competitor_id
GROUP BY e.event_name
ORDER BY total_participants DESC;

7) Liste los deportes que en todas las olimpiadas siempre se llevan a cabo
SELECT s.sport_name
FROM olympics.dbo.sport s
WHERE NOT EXISTS (
  SELECT g.id
  FROM olympics.dbo.games g
  WHERE NOT EXISTS (
    SELECT e.id
    FROM olympics.dbo.event e
    WHERE e.sport_id = s.id
    AND e.id IN (
      SELECT ce.event_id
      FROM olympics.dbo.competitor_event ce
      JOIN olympics.dbo.games_competitor gc ON gc.id = ce.competitor_id
      WHERE gc.games_id = g.id
    )
  )
);

8) Muestre la comparacion de la cantidad de veces entre los dos generos(M,F) que ganado medallas de cualquier tipo
SELECT p.gender, COUNT(*) AS total_medals
FROM olympics.dbo.person p
JOIN olympics.dbo.games_competitor gc ON gc.person_id = p.id
JOIN olympics.dbo.competitor_event ce ON ce.competitor_id = gc.id
GROUP BY p.gender;

9) Cual es la altura y peso que mas es mas frecuente en los participantes del deporte de Boxeo
SELECT p.height, p.weight, COUNT(*) AS frequency
FROM olympics.dbo.person p
JOIN olympics.dbo.games_competitor gc ON gc.person_id = p.id
JOIN olympics.dbo.competitor_event ce ON ce.competitor_id = gc.id
JOIN olympics.dbo.event e ON e.id = ce.event_id
JOIN olympics.dbo.sport s ON s.id = e.sport_id
WHERE s.sport_name = 'Boxing'
GROUP BY p.height, p.weight
ORDER BY COUNT(*) DESC;

10) Muestre los participantes menores de edad que participan en las olimpiadas
SELECT p.id, p.full_name, p.age
FROM olympics.dbo.person p
JOIN olympics.dbo.games_competitor gc ON gc.person_id = p.id
WHERE p.age < 18;
