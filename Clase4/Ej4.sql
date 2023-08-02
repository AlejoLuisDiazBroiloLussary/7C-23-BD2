use sakila;

#1 Show title and special_features of films that are PG-13; 

SELECT title AS titulo_pelicula, special_features AS tags 
FROM film AS F 
WHERE rating = 'PG-13';

#2 Get a list of all the different films duratiON.;

<<<<<<< HEAD
SELECT DISTINCT length AS duracion 
=======
SELECT DISTINCT length AS duraciON 
>>>>>>> 348dcae7d232c1ef0588f045badd706628c4ac9e
FROM film AS F 
order by length ASc;

#3 Show title, rental_rate and replacement_cost of films that have replacement_cost FROM 20.00 up to 24.00;

SELECT title AS titulo_pelicula, rental_rate AS costo_renta, replacement_cost AS multa 
FROM film AS F 
WHERE costo_remplazo BETWEEN 20.00 AND 24.00;

#4 Show title, category and rating of films that have 'Behind the Scenes' AS special_features;

SELECT title AS titulo_pelicula, C.name AS category, rating
FROM film AS F
INNER JOIN film_category AS FC ON F.film_id = FC.film_id 
INNER JOIN category AS C ON FC.category_id = C.category_id 
WHERE special_features LIKE '%Behind the Scenes%';

# 5 Show first name and lASt name of actors that acted in 'ZOOLANDER FICTION';

SELECT A.first_name AS nombre_actor, A.lASt_name AS apellido_actor 
FROM actor AS A 
INNER JOIN film_actor AS FA ON A.actor_id = FA.actor_id 
INNER JOIN film AS F ON F.film_id = FA.film_id 
WHERE F.title = 'ZOOLANDER FICTION';

#6 Show the address, city and country of the store with id 1

SELECT address AS direcciON, city AS ciudad, country AS pais 
FROM store AS S 
INNER JOIN address AS AD ON S.address_id = AD.address_id 
INNER JOIN city AS C ON AD.city_id = C.city_id 
INNER JOIN country AS CON ON C.country_id = CON.country_id 
WHERE S.store_id = 1;

#7 Show pair of film titles and rating of films that have the same rating.;

SELECT F1.title AS titulo_2, F1.rating AS rating_1, F2.title AS titulo_2, F2.rating AS rating_2 
FROM film F1, film F2 
WHERE F1.film_id < F2.film_id AND F1.rating = F2.rating;

#8 Get all the films that are available in store id 2 and the manager first/lASt name of this store (the manager will appear in all the rows).;

<<<<<<< HEAD
SELECT DISTINCT F.film_id, F.title AS Pelicula, S.store_id AS Tienda, concat(M.first_name, ' ', M.lASt_name) AS Manager
FROM inventory I 
INNER JOIN film F on I.film_id = F.film_id
INNER JOIN store S on I.store_id = S.store_id
INNER JOIN staff M on S.manager_staff_id = M.staff_id
WHERE S.store_id = 2;
=======
SELECT DISTINCT F.film_id, F.title AS Titulo, S.store_id AS Tienda, cONcat(M.first_name, ' ', M.lASt_name) AS Manager
FROM inventory I 
INNER JOIN film F ON I.film_id = F.film_id
INNER JOIN store S ON I.store_id = S.store_id
INNER JOIN staff M ON S.manager_staff_id = M.staff_id
WHERE S.store_id = 2;

#end of program
>>>>>>> 348dcae7d232c1ef0588f045badd706628c4ac9e
