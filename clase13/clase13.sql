#1
INSERT INTO customer (store_id, first_name, last_name, email, address_id, active)

SELECT 1, 'Alejo Luis', 'Diaz Broilo', 'diazbroiloalejol@gmail.com', MAX(a.address_id), 1
FROM address a
WHERE  city_id IN (SELECT city_id FROM city WHERE country_id IN (SELECT country_id FROM country WHERE country = 'United States'));
#2
INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
SELECT NOW(),i.inventory_id,c.customer_id, NULL,s.staff_id 
FROM inventory AS i
INNER JOIN film AS f USING (film_id)
INNER JOIN customer AS c ON c.customer_id=1
INNER JOIN staff AS s ON s.store_id = 2  
WHERE f.title = 'RANDOM GO';      
#3
UPDATE film
SET release_year = 
    CASE rating
        WHEN 'G' THEN '2001'
        WHEN 'PG' THEN '2002'
        WHEN 'PG-13' THEN '2003'
        WHEN 'R' THEN '2005'
        WHEN 'NC-17' THEN '2008'
        ELSE '2000' 
END;	
#4
SELECT F.film_id
FROM film as F
         INNER JOIN inventory AS I on I.film_id = F.film_id
         INNER JOIN rental AS R on I.inventory_id = R.inventory_id
WHERE R.return_date > CURRENT_DATE()
ORDER BY rental_date DESC
LIMIT 1;	
#5	
/*
  en resumen, hay que borrar todas las entidades relacionadas con la entidad que queremos borrar,
  si hubiesemos puesto un ON DELETE CASCADE, esto se haria automaticamente
*/
DELETE FROM rental
WHERE inventory_id IN (SELECT inventory_id FROM inventory WHERE film_id = 1);

DELETE FROM payment
WHERE rental_id IN (SELECT rental_id FROM rental WHERE inventory_id IN (SELECT inventory_id FROM inventory WHERE film_id = 1));

DELETE FROM film_actor
WHERE film_id = 1;

DELETE FROM film_category
WHERE film_id = 1;

DELETE FROM inventory
WHERE film_id = 1;

DELETE FROM film
WHERE film_id = 1;

select * from film;
#6
INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
VALUES (CURRENT_DATE(), (SELECT I.inventory_id
                         FROM inventory AS I
                         WHERE NOT EXISTS(SELECT *
                                          FROM rental AS R
                                          WHERE R.inventory_id = I.inventory_id
                                            AND R.return_date < CURRENT_DATE())
                         LIMIT 1), 1, CURRENT_DATE(), 1);
INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
VALUES (1, 1, (SELECT LAST_INSERT_ID()), 10.2, CURRENT_DATE);
