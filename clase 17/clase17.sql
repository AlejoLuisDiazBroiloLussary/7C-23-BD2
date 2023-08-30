#1
# ejemplo con in
SELECT a.address, a.postal_code, ci.city, co.country
FROM address AS a
JOIN city AS ci ON a.city_id = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id
WHERE a.postal_code IN ('35200', '17886', '83579');
#12ms
# ejemplo sin usar in
SELECT a.address, a.postal_code, ci.city, co.country
FROM address AS a
JOIN city AS ci ON a.city_id = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id
WHERE a.postal_code NOT IN ('35200', '17886', '83579');
#5ms
#creacion del index: Al crearlo, indexamos la columna en cuenstion, esto le permite al motor acceder a los datos requeridos de forma mas rapida, porque
# reducen la cantidad de escaneos realizadas y reorganizan los datos de la forma mas eficiente posible
CREATE INDEX PostalCode ON address(postal_code);
#el crear el index redujo el tiempo de respuesta a 4ms y 4ms
#2
SELECT first_name
FROM actor
ORDER BY first_name;
#12ms
# sakila no tienen un index para first_name, entonces la query tiene la velocidad normal y poco eficiente
SELECT last_name
FROM actor
ORDER BY last_name;
#4ms
# last_name si esta indexado, entonces las queries son mas rapidas

SHOW INDEX FROM actor; #la query para mostrar los index existentes

#3------------------------------------------------------------------------------

SELECT description
FROM film
WHERE description LIKE "%Character%"
ORDER BY description;
# 80ms

#para usar match y against, se necesita tener un index llamado "Fulltext"
CREATE FULLTEXT INDEX FullText_idx ON film(description);

SELECT description
FROM film
WHERE MATCH(description) AGAINST("Character")
ORDER BY description;
# 13ms
# 80ms != 13ms, gracias al index
