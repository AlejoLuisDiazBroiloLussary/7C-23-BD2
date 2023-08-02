-- Active: 1681488495868@@127.0.0.1@3306@sakila

USE sakila;

#Class 6
select a.first_name
from actor a
WHERE exists(
        select cu.first_name
        from customer cu
        where
            cu.first_name = a.first_name
    );

select a.first_name
from actor a
WHERE a.first_name in (
        select first_name
        from customer
    );

SELECT title, length
FROM film
WHERE length > any (
        SELECT length
        FROM
            film
    );

select title, length
from film
WHERE length > any(
        SELECT min(length)
        FROM
            film
    );

SELECT title, length
FROM film
WHERE length <> (
        SELECT max(length)
        FROM
            film
    );

select
    title,
    max(length) as maximo
from film f
group by title
ORDER BY maximo DESC
limit 1;

#class 7 may 3 select max(return_date) from rental;

select
    first_name,
    count(rental_id), (
        select max(r.return_date)
        from rental r
        where
            r.customer_id = c1.customer_id
    ) as maximo
from customer c1
    inner join rental using(customer_id)
group by first_name, maximo;

#informe de cada cliente su cantidad de rentals y su ultima devolucion
select c2.first_name
from customer c2, (
        select
            first_name,
            count(rental_id) as cantidad,
            max(return_date) as maximo
        from customer c1
            inner join rental using(customer_id)
        group by first_name
        having cantidad > 30
    ) as t1
where
    c2.first_name = t1.first_name;

select
    first_name,
    count(rental_id) as cantidad,
    max(return_date) as maximo
from customer c1
    inner join rental using(customer_id)
group by first_name;

select title,(select avg(`length`) from film)from film;

#class may 10 select title,(select max(length) from film)from film;

#venta maxima de los ventas promedio
select payment_id, amount
from payment
WHERE amount != (
        select min(amount)
        from payment
    ) AND amount != (
        select max(amount)
        from payment
    );

select
    c.first_name,
    sum(p.amount) as monto_total
from customer c
    inner join payment p using (customer_id)
group by c.first_name
having sum(p.amount) > 11;


#la diferencia entre las dos siguientes queries, el join pone un dato al lado del otro, por lo que toma valores de mas. Mientras que la subquery hace un filtrado de datos. 
select avg(f.length)#forma incorrecta
from film f, inventory i #obtiene el promedio buscando las pelis que esten en el inventario de la tienda 1
where f.film_id = i.film_id
    and i.store_id = 1;

select avg(length) #forma correcta
from film # busca el promedio de las pelis que esten dentro de un conjunto ya filtrado
WHERE film_id in(select film_id
        from inventory
        where store_id = 1
    );

use sakila;


#CLass 9

/*

    1_Get the amount of cities per country in the database. Sort them by country, country_id.

    2_Get the amount of cities per country in the database. Show only the countries with more than 10 cities, order from the highest amount of cities to the lowest

    3_Generate a report with customer (first, last) name, address, total films rented and the total money spent renting films.
        Show the ones who spent more money first .

    4_Which film categories have the larger film duration (comparing average)?
        Order by average in descending order

    5_Show sales per film rating
*/

#1

SELECT co.country, COUNT(ci.city)
FROM country co
JOIN city ci ON co.country_id = ci.country_id
GROUP BY co.country
ORDER BY co.country;

#2

SELECT co.country, COUNT(ci.city) 
FROM country co
JOIN city ci ON co.country_id = ci.country_id
GROUP BY co.country
HAVING COUNT(ci.city) > 10
ORDER BY COUNT(ci.city) DESC;

#3
SELECT  c.first_name, 
        c.last_name, 
        (SELECT a.address FROM address a WHERE a.address_id = c.address_id) AS `address`,
        (SELECT COUNT(*) FROM rental r WHERE c.customer_id = r.customer_id) AS `quantity_rented`,
        (SELECT SUM(p.amount) FROM payment p WHERE c.customer_id = p.customer_id) AS `total_spent`
FROM customer c
ORDER BY `total_spent` DESC;

#4
SELECT c.name, AVG(f.`length`)
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
HAVING AVG(f.`length`) > (SELECT AVG(f2.`length`) FROM film f2)
ORDER BY AVG(f.`length`) DESC;

#5
SELECT f.rating AS 'rating', COUNT(r.rental_id) AS 'total_rentals'
FROM film f
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY f.rating
ORDER BY 'rating';













/*
 1_Find the films with less duration, show the title and rating.
 2_Write a query that returns the tiltle of the film which duration is the lowest. If there are more than one film with the lowest durtation, the query returns an empty resultset.
 3_Generate a report with list of customers showing the lowest payments done by each of them. Show customer information, the address and the lowest amount, provide both solution using ALL and/or ANY and MIN.
 4_Generate a report that shows the customer's information with the highest payment and the lowest payment in the same row.
 */

#1
select title, length
from film
where length = (
        select min(length)
        from film
    );

#2
select title, length
from film as f1
where length <= (
        select min(length)
        from film
    ) and not EXISTS(
        select *
        from film AS f2
        where
            f2.film_id != f1.film_id
            and f2.length <= f1.length
    );

#3
select
    c.first_name as nombre,
    c.last_name as apellido,
    a.address as direccion, (
        select min(amount)
        from payment p
        where
            c.customer_id = p.customer_id
    ) as min
from customer c
    JOIN address a on c.address_id = a.address_id
order by c.first_name;

#4
select
    c.first_name as nombre,
    c.last_name as apellido,
    a.address as direccion, (
        select min(amount)
        from payment p
        where
            c.customer_id = p.customer_id
    ) as min, (
        select max(amount)
        from payment p
        where
            c.customer_id = p.customer_id
    ) AS max
from customer c
    JOIN address a on c.address_id = a.address_id
order by c.first_name;

/*
 List all the actors that share the last name. Show them in order
 Find actors that don't work in any film
 Find customers that rented only one film
 Find customers that rented more than one film
 List the actors that acted in 'BETRAYED REAR' or in 'CATCH AMISTAD'
 List the actors that acted in 'BETRAYED REAR' but not in 'CATCH AMISTAD'
 List the actors that acted in both 'BETRAYED REAR' and 'CATCH AMISTAD'
 List all the actors that didn't work in 'BETRAYED REAR' or 'CATCH AMISTAD'
 */

#List all the actors that share the last name. Show them in order
SELECT first_name, last_name
FROM actor a
WHERE EXISTS (
        SELECT *
        FROM actor a2
        WHERE
            a.last_name = a2.last_name
            AND a.actor_id <> a2.actor_id
    )
ORDER BY a.last_name;

#2 Find actors that dont work in any film
SELECT
    a.first_name,
    a.last_name
FROM actor a
WHERE NOT EXISTS (
        SELECT *
        FROM film_actor fa
        WHERE
            a.actor_id = fa.actor_id
    );

# Find customers that rented only one film
SELECT
    c.first_name,
    c.last_name
FROM customer c
WHERE 1 = (
        SELECT COUNT(*)
        FROM rental r
        WHERE
            c.customer_id = r.customer_id
    );

# Find customers that rented more than one film
SELECT
    c.first_name,
    c.last_name
FROM customer c
WHERE 1 < (
        SELECT COUNT(*)
        FROM rental r
        WHERE
            c.customer_id = r.customer_id
    );

# List the actors that acted in 'BETRAYED REAR' or in 'CATCH AMISTAD'
SELECT
    A.actor_id,
    A.first_name,
    A.last_name
FROM actor A
WHERE EXISTS(
        SELECT TITLE
        FROM film F
            INNER JOIN film_actor FA ON F.film_id = FA.film_id
        WHERE
            F.film_id = FA.film_id
            AND A.actor_id = FA.actor_id
            AND (
                F.title = 'BETRAYED REAR'
                OR F.title = 'CATCH AMISTAD'
            )
    );

# List the actors that acted in 'BETRAYED REAR' but not in 'CATCH AMISTAD'
SELECT
    actor_id,
    first_name,
    last_name
FROM actor A
WHERE EXISTS(
        SELECT title
        FROM film F
            INNER JOIN film_actor FA ON F.film_id = FA.film_id
        WHERE
            F.film_id = FA.film_id
            AND A.actor_id = FA.actor_id
            AND F.title = 'BETRAYED REAR'
    )
    AND NOT EXISTS (
        SELECT title
        FROM film F
            INNER JOIN film_actor FA ON F.film_id = FA.film_id
        WHERE
            F.film_id = FA.film_id
            AND A.actor_id = FA.actor_id
            AND F.title = 'CATCH AMISTAD'
    );

# List the actors that acted in both 'BETRAYED REAR' and 'CATCH AMISTAD'
SELECT
    actor_id,
    first_name,
    last_name
FROM actor A
WHERE EXISTS(
        SELECT title
        FROM film F
            INNER JOIN film_actor FA ON F.film_id = FA.film_id
        WHERE
            F.film_id = FA.film_id
            AND A.actor_id = FA.actor_id
            AND F.title = 'BETRAYED REAR'
    )
    AND EXISTS (
        SELECT title
        FROM film F
            INNER JOIN film_actor FA ON F.film_id = FA.film_id
        WHERE
            F.film_id = FA.film_id
            AND A.actor_id = FA.actor_id
            AND F.title = 'CATCH AMISTAD'
    );

# List all the actors that didn't work in 'BETRAYED REAR' or 'CATCH AMISTAD'
SELECT
    actor_id,
    first_name,
    last_name
FROM actor A
WHERE NOT EXISTS(
        SELECT title
        FROM film F
            INNER JOIN film_actor FA ON F.film_id = FA.film_id
        WHERE
            F.film_id = FA.film_id
            AND A.actor_id = FA.actor_id
            AND (
                F.title = 'BETRAYED REAR'
                OR F.title = 'CATCH AMISTAD'
            )
    );
