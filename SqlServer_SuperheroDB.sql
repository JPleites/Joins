1) Mostrar una lista de los superpoderes que tiene cada Super Heroe
SELECT s.superhero_name, p.power_name
FROM superhero.dbo.superhero AS s
JOIN superhero.dbo.hero_power AS hp ON s.id = hp.hero_id
JOIN superhero.dbo.superpower AS p ON hp.power_id = p.id;

2) Mostrar la cantidad de superpoderes con los que cuenta cada Super Heroe
SELECT s.superhero_name, COUNT(hp.power_id) AS total_superpowers
FROM superhero.dbo.superhero AS s
LEFT JOIN superhero.dbo.hero_power AS hp ON s.id = hp.hero_id
GROUP BY s.superhero_name;

3) Mostrar los diez superpoderes que es mas frecuente en cada Super Heroe
SELECT s.superhero_name, sp.power_name, COUNT(hp.power_id) AS power_count
FROM superhero.dbo.superhero AS s
JOIN superhero.dbo.hero_power AS hp ON s.id = hp.hero_id
JOIN superhero.dbo.superpower AS sp ON hp.power_id = sp.id
GROUP BY s.superhero_name, sp.power_name
ORDER BY s.superhero_name, power_count DESC;

4) Mostrar los diez superpoderes que es mas frecuente en cada Super Heroe
SELECT s.superhero_name, sp.power_name, COUNT(hp.power_id) AS power_count
FROM superhero.dbo.superhero AS s
JOIN superhero.dbo.hero_power AS hp ON s.id = hp.hero_id
JOIN superhero.dbo.superpower AS sp ON hp.power_id = sp.id
GROUP BY s.superhero_name, sp.power_name
HAVING COUNT(hp.power_id) > 0
ORDER BY s.superhero_name, power_count DESC
OFFSET 0 ROWS
FETCH NEXT 10 ROWS ONLY;

5) Mostrar los Super Heroes que no cuentan con el Atributo de Intelligence
SELECT sh.superhero_name
FROM superhero.dbo.superhero AS sh
LEFT JOIN superhero.dbo.hero_attribute AS ha ON sh.id = ha.hero_id
LEFT JOIN superhero.dbo.attribute AS a ON ha.attribute_id = a.id
WHERE a.attribute_name IS NULL OR a.attribute_name <> 'Intelligence';

6) Mostrar los Super Heroes que cuentan con tres o 5 Atributos
SELECT sh.superhero_name
FROM superhero.dbo.superhero AS sh
JOIN superhero.dbo.hero_attribute AS ha ON sh.id = ha.hero_id
JOIN superhero.dbo.attribute AS a ON ha.attribute_id = a.id
GROUP BY sh.id, sh.superhero_name
HAVING COUNT(DISTINCT ha.attribute_id) IN (3, 5);

7) Mostrar la lista de las mujeres que son Super Heroes
SELECT sh.superhero_name, sh.full_name
FROM superhero.dbo.superhero AS sh
JOIN superhero.dbo.gender AS g ON sh.gender_id = g.id
WHERE g.gender = 'Female';

8) Mostrar la lista de los colores de como se identifca un Super Heroe (color de ojos, traje y pelo)
SELECT s.superhero_name, e.colour AS eye_colour, h.colour AS hair_colour, sk.colour AS skin_colour
FROM superhero.dbo.superhero AS s
JOIN superhero.dbo.colour AS e ON s.eye_colour_id = e.id
JOIN superhero.dbo.colour AS h ON s.hair_colour_id = h.id
JOIN superhero.dbo.colour AS sk ON s.skin_colour_id = sk.id;

9) Mostrar la lista de Super Heroe indicando su origen (race) y cantidad de superpoderes
SELECT s.superhero_name, r.race, COUNT(sp.id) AS cantidad_superpoderes
FROM superhero.dbo.superhero AS s
JOIN superhero.dbo.race AS r ON s.race_id = r.id
LEFT JOIN superhero.dbo.superpower AS sp ON s.id = sp.id
GROUP BY s.superhero_name, r.race;

10) Mostrar la cantidad de superheroes que tienen un papel de Superheroe Bueno(alignment) agrupado por cada editor(publisher)
SELECT p.publisher_name, COUNT(s.id) AS cantidad_superheroes
FROM superhero.dbo.superhero AS s
JOIN superhero.dbo.alignment AS a ON s.alignment_id = a.id
JOIN superhero.dbo.publisher AS p ON s.publisher_id = p.id
WHERE a.alignment = 'Bueno'
GROUP BY p.publisher_name;