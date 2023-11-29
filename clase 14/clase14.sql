-- 1. Write a query that gets all the customers that live in Argentina. Show the first and last name in one column, the address and the city.
    select concat(c.first_name, ' ', c.last_name) as full_name, a.address, ci.city
    from customer c
    inner join address a on a.address_id = c.address_id
    inner join city ci on ci.city_id = a.city_id
    inner join country co on co.country_id = ci.country_id
    where co.country like 'Argentina';

-- 2. Write a query that shows the film title, language and rating. Rating shall be shown as the full text described here: https://en.wikipedia.org/wiki/Motion_picture_content_rating_system#United_States. Hint: use case.
    select f.title, l.name,
    case
        when rating = 'G' then 'All Ages Are Admitted.'
        when rating = 'PG' then 'Some Material May Not Be Suitable For Children.'
        when rating = 'PG-13' then 'Some Material May Be Inappropriate For Children Under 13.'
        when rating = 'R' then 'Under 17 Requires Accompanying Parent Or Adult Guardian.'
        when rating = 'NC-17' then 'No One 17 and Under Admitted.'
    end as rating_description
    from film f
    inner join language l on l.language_id = f.language_id;

-- 3. Write a search query that shows all the films (title and release year) an actor was part of. Assume the actor comes from a text box introduced by hand from a web page. Make sure to "adjust" the input text to try to find the films as effectively as you think is possible.
    select f.title, f.release_year, concat(a.first_name, ' ', a.last_name) as full_name
    from film f
    inner join film_actor fa on fa.film_id = f.film_id
    inner join actor a on a.actor_id = fa.actor_id
    where CONCAT_WS(first_name, ' ', last_name) like trim(upper("sAPo Pepe"));

-- 4. Find all the rentals done in the months of May and June. Show the film title, customer name and if it was returned or not. There should be returned column with two possible values 'Yes' and 'No'.
    select f.title, concat(c.first_name, ' ', c.last_name) as full_name,
    case when r.return_date is not null then 'Yes'
    else 'No' end as was_returned,
    MONTHNAME(r.rental_date) as month
    from film f
    inner join inventory i on i.film_id = f.film_id
    inner join rental r on r.inventory_id = i.inventory_id
    inner join customer c on c.customer_id = r.customer_id
    where MONTHNAME(r.rental_date) like 'May'
    or MONTHNAME(r.rental_date) like 'June';

-- 5. Investigate CAST and CONVERT functions. Explain the differences if any, write examples based on sakila DB.

    No hay casi diferencias se utilizan para cambiar el tipo de dato de una columna en una consulta SQL. La diferencia principal radica en que CAST es una función estándar SQL para conversiones de tipo genérico, mientras que CONVERT tiende a ser más específica para formatos de fecha y hora y puede variar en su sintaxis según el sistema de gestión de bases de datos que estés utilizando.

    CAST EJEMPLO: 
        SELECT CAST(rental_date AS DATE) AS rental_date_only FROM rental;
    CONVERT EJEMPLO:
        SELECT CONVERT(VARCHAR(10), rental_date, 23) AS rental_date_formatted

-- 6. Investigate NVL, ISNULL, IFNULL, COALESCE, etc type of function. Explain what they do. Which ones are not in MySql and write usage examples.

1. NVL:

Se usa en Oracle db.
reemplazar valores NULL con un valor predeterminado especificado
NVL(expresión, valor_predeterminado).
Ejemplo:
    SELECT nombre, NVL(telefono, 'N/A') AS telefono_contacto
    FROM clientes;
.

2. ISNULL:

reemplazar valores NULL con un valor de reemplazo especificado.
Ejemplo: 
    SELECT nombre, ISNULL(correo, 'No disponible') AS correo_contacto
    FROM clientes;


3. IFNULL:

Se utiliza en MySQL y MariaDB.
reemplazar valores NULL con un valor de reemplazo especificado.
Ejemplo: 
    SELECT nombre, IFNULL(direccion, 'Dirección no proporcionada') AS direccion_contacto
    FROM clientes;


4. COALESCE:
se utiliza en muchos sistemas de bases de datos relacionales, incluyendo Oracle, SQL Server, MySQL y más.
Retorna el primer valor no NULL de una lista de expresiones.
Ejemplo: 
    SELECT nombre, COALESCE(telefono, correo, 'No hay información de contacto disponible') AS info_contacto
    FROM clientes;
