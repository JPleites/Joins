1) Realizar una consulta donde pueda obtener los paises donde estan ubicadas cada universidad.
SELECT u.university_name ,c.country_name  FROM university u 
inner join country c on u.country_id = c.id ;

2) Conocer cuantas universidades hay en cada pais.
SELECT c.country_name , count(u.id) 'Cantidad de Universidades' FROM country c 
INNER JOIN university u on c.id =u.country_id 
GROUP BY c.country_name 
ORDER BY c.country_name ASC

3) Conocer cuantos paises no tienen universidades en el ranking.
SELECT COUNT(DISTINCT u.country_id) AS cantidad_paises_sin_universidades
FROM universities.dbo.university AS u
LEFT JOIN universities.dbo.university_ranking_year AS ury ON u.id = ury.university_id
WHERE ury.university_id IS NULL;

4) Mostrar los criterios de cada tipo de ranking.
SELECT rs.system_name, rc.criteria_name
FROM universities.dbo.ranking_system AS rs
JOIN universities.dbo.ranking_criteria AS rc ON rs.id = rc.ranking_system_id;

5) Conocer el ranking que tiene mas criterios
SELECT rs.system_name, COUNT(rc.id) AS num_criteria
FROM universities.dbo.ranking_system AS rs
JOIN universities.dbo.ranking_criteria AS rc ON rs.id = rc.ranking_system_id
GROUP BY rs.id, rs.system_name
ORDER BY num_criteria DESC;

6) Cual es el top de universidades de forma descendente del ano 2012 por cada criterio
SELECT rc.criteria_name, u.university_name, ury.score
FROM universities.dbo.university_ranking_year AS ury
JOIN universities.dbo.ranking_criteria AS rc ON ury.ranking_criteria_id = rc.id
JOIN universities.dbo.university AS u ON ury.university_id = u.id
WHERE ury.year = 2012
ORDER BY rc.criteria_name, ury.score DESC;

7) Mostrar las 5 universidad con mas cantidades de score 100 del ranking tipo 'Center for World University Rankings'
SELECT TOP 5 u.university_name, ury.score
FROM universities.dbo.university_ranking_year AS ury
JOIN universities.dbo.university AS u ON ury.university_id = u.id
JOIN universities.dbo.ranking_criteria AS rc ON ury.ranking_criteria_id = rc.id
JOIN universities.dbo.ranking_system AS rs ON rc.ranking_system_id = rs.id
WHERE rs.system_name = 'Center for World University Rankings' AND ury.score = 100
ORDER BY ury.score DESC;

8) Mostrar que paises se posicionaron con universidades con un score mayor a 90
SELECT c.country_name
FROM universities.dbo.university_ranking_year AS ury
JOIN universities.dbo.university AS u ON ury.university_id = u.id
JOIN universities.dbo.country AS c ON u.country_id = c.id
WHERE ury.score > 90
GROUP BY c.country_name;

9) Mostrar las universidades que utilizan los criterios del tipo ranking 'Shangai Ranking'
SELECT u.university_name
FROM universities.dbo.university_ranking_year AS ury
JOIN universities.dbo.ranking_criteria AS rc ON ury.ranking_criteria_id = rc.id
JOIN universities.dbo.ranking_system AS rs ON rc.ranking_system_id = rs.id
JOIN universities.dbo.university AS u ON ury.university_id = u.id
WHERE rs.system_name = 'Shanghai Ranking'
GROUP BY u.university_name;

10) Mostrar el top 10 de las peores posiciones del tipo ranking 'Times Higher....'
SELECT TOP 10 u.university_name, ury.score
FROM universities.dbo.university_ranking_year AS ury
JOIN universities.dbo.ranking_criteria AS rc ON ury.ranking_criteria_id = rc.id
JOIN universities.dbo.ranking_system AS rs ON rc.ranking_system_id = rs.id
JOIN universities.dbo.university AS u ON ury.university_id = u.id
WHERE rs.system_name = 'Times Higher Education World University Ranking'
      AND ury.year = 2012
ORDER BY ury.score ASC;

