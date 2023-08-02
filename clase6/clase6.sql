#ej1;
SELECT a.lASt_name, a.first_name, a.actor_id
FROM actor a
WHERE a.lASt_name IN (
    SELECT a2.lASt_name
    FROM actor a2
    GROUP BY a2.lASt_name
    HAVING COUNT(*) > 1
)
ORDER BY a.lASt_name, a.first_name;

#ej2;
SELECT actor_id,lASt_name,first_name
FROM actor
WHERE actor_id not IN (
    SELECT actor_id
    FROM film_actor
);
#ej3;
SELECT customer_id,first_name,lASt_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id FROM (
        SELECT count(customer_id) AS cant,customer_id
        FROM rental
        GROUP BY customer_id 
        ORDER BY count(customer_id)
    ) AS countCustomers
    WHERE cant = 1
);
#ej4;
SELECT customer_id,first_name,lASt_name
FROM customer
    WHERE customer_id not IN (
    SELECT customer_id FROM (
    SELECT count(customer_id) AS cant,customer_id
    FROM rental
    GROUP BY customer_id 
    ORDER BY count(customer_id))
    AS countCustomers
    WHERE cant = 1
);
#ej5;
SELECT a.first_name, a.actor_id
FROM actor a
WHERE a.actor_id IN (
    SELECT fa.actor_id
    FROM film_actor fa
    WHERE fa.film_id IN (
        SELECT f.film_id
        FROM film f
        WHERE f.title = 'BETRAYED REAR'
        OR f.title = 'CATCH AMISTAD'
    )
)
GROUP BY a.actor_id;

#ej6;
SELECT a.first_name, a.actor_id
FROM actor a
WHERE a.actor_id IN (
    SELECT fa.actor_id
    FROM film_actor fa, film f
    WHERE a.actor_id = fa.actor_id
    AND f.film_id = fa.film_id
    AND f.title = 'BETRAYED REAR'
)
AND a.actor_id NOT IN (
    SELECT fa2.actor_id
    FROM film_actor fa2, film f2
    WHERE a.actor_id = fa2.actor_id
    AND f2.film_id = fa2.film_id
    AND f2.title = 'CATCH AMISTAD'
);

#ej7
SELECT first_name, actor_id
FROM actor 
WHERE actor_id IN (
    SELECT fa.actor_id
    FROM film_actor fa
    WHERE film_id IN(
        SELECT f.film_id
        FROM film f
        WHERE f.title = 'BETRAYED REAR'
    )
    GROUP BY actor_id
)
AND actor_id IN (
    SELECT fa.actor_id
    FROM film_actor fa
    WHERE fa.film_id IN(
        SELECT f.film_id
        FROM film f
        WHERE f.title = 'CATCH AMISTAD'
    )
    GROUP BY actor_id
);

#ej8;
SELECT a.first_name, a.actor_id
FROM actor a
WHERE a.actor_id NOT IN (
    SELECT fa.actor_id
    FROM film_actor fa, film f
    WHERE a.actor_id = fa.actor_id
    AND f.film_id = fa.film_id
    AND f.title = 'BETRAYED REAR'
)
AND a.actor_id NOT IN (
    SELECT fa2.actor_id
    FROM film_actor fa2, film f2
    WHERE a.actor_id = fa2.actor_id
    AND f2.film_id = fa2.film_id
    AND f2.title = 'CATCH AMISTAD'
);