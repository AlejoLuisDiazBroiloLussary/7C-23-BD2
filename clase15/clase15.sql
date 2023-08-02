#1
CREATE OR REPLACE VIEW list_of_customers AS
  SELECT c.customer_id, concat(c.first_name, ' ' ,c.last_name) as customer_full_name, c.store_id, concat(a.address, ' ', a.address2) as address, a.phone, co.country_id, c.active
  FROM customer c
  INNER JOIN address a on a.address_id = c.address_id 
  INNER JOIN city ci on ci.city_id = a.city_id 
  INNER JOIN country co on co.country_id = ci.country_id
  ;


#2
CREATE OR REPLACE VIEW film_details AS
  SELECT f.film_id, f.title, f.description, c.name as category, f.length, f.rating , GROUP_CONCAT(concat(a.first_name, ' ' ,a.last_name) ORDER BY a.actor_id SEPARATOR ',') AS actor_list
  FROM film f
  INNER JOIN film_category fc on fc.film_id = f.film_id
  INNER JOIN category c on c.category_id = fc.category_id
  INNER JOIN film_actor fa on fa.film_id = f.film_id
  INNER JOIN actor a on a.actor_id = fa.actor_id
  group by f.film_id, c.name
  ;



#3
CREATE OR REPLACE VIEW  sales_by_film_category AS
  SELECT c.category_id, c.name, c.last_update as last_update_category, r.rental_id, r.rental_date , r.inventory_id, r.customer_id, r.return_date, r.staff_id, r.last_update  as last_update_rental
  FROM category c
  INNER JOIN film_category fc on c.category_id = fc.category_id
  INNER JOIN film f on fc.film_id = f.film_id
  INNER JOIN inventory i on i.film_id = f.film_id
  INNER JOIN rental r on i.inventory_id = r.inventory_id
  ;

#4
CREATE OR REPLACE VIEW actor_information AS
  SELECT a.actor_id, a.first_name, a.last_name, count(f.film_id)
  FROM actor a
  INNER JOIN film_actor fa on a.actor_id = fa.actor_id
  INNER JOIN film f on fa.film_id = f.film_id
  group by a.actor_id
  ;
#5
/*
Explicación de la consulta:
1: CREATE VIEW actor_information AS // aca creamos una view referenciada como actor_information. 

2: SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS film_count // aca especificamos las columnas que queremos seleccionar y mostrar en la vista resultante. 
(el id del actore, su nombre, su apellido, la cantidad de peliculas en las que participo dicho actor)

3: Usando INNER JOIN, conectamos tablas film y actor, usando film_actor como intermedia (se hace una interseccion entre dichas tablas)

4:usamos GROUP BY a.actor_id para agrupar los resultados.

*/

#6
/*
Una vista materializada es una tabla física en una base de datos que contiene los resultados precalculados de una 
consulta realizada en una o más tablas fuente. A diferencia de las vistas regulares, que son consultas virtuales y no 
almacenan datos directamente, las vistas materializadas contienen datos reales y se actualizan periódicamente para 
mantenerlos sincronizados con las tablas originales. Esto permite mejorar el rendimiento y optimizar las consultas al 
acceder a datos precalculados en lugar de realizar cálculos repetitivos sobre los datos fuente.

######################################################################################################################

Su sintaxis es la siguiente:

CREATE MATERIALIZED VIEW nombre_de_la_vista
AS
SELECT columnas
FROM tablas
WHERE condiciones
[REFRESH {FAST | COMPLETE | FORCE | ON DEMAND | NEVER}];

######################################################################################################################

Las ventajas se pueden agrupar en estos 3 puntos claves:

    1: mejora del rendimiento: Cuando necesitamos hacer consultas demandantes para nuestro sistema o cuando necesitamos
      acceder a ciertos datos de forma repetida, el mantener los resultados de dichas consultas ya almacenados
      nos ahorra dichas exigencias a nuestro sistema.
    
    2: Agregación y resumen de datos: A menudo se utilizan para agregar, resumir o transformar datos, lo que permite
      a los usuarios acceder eficientemente a información resumida sin consultar todo el conjunto de datos.

    3: Soporte para datos remotos: Las vistas materializadas se pueden utilizar para almacenar 
       datos de bases de datos remotas, lo que facilita el trabajo con sistemas distribuidos.

######################################################################################################################

Algunas alternativas:

° Vistas Regulares: Las vistas regulares son consultas virtuales que proporcionan una vista actualizada de las tablas subyacentes cada
                    vez que se consultan, adecuadas para datos en tiempo real y consultas menos complejas.

° Caché: Los resultados son almacenados en una memoria volatil. En corto, reducen la carga del sistema, a costa de volumen de datos
         mas todas implicaciones del guardado de datos en dichas memorias 

° Indexación: Consiste en crear estructuras especiales, llamadas índices, que almacenan copias ordenadas de ciertas columnas o campos
              de una tabla Los índices adecuados en columnas frecuentemente consultadas mejoran el rendimiento sin necesidad de 
              vistas materializadas, al optimizar el acceso a los datos.

######################################################################################################################

¿En cuales SGBD podemos usarlas? (o equivalentes)


1. Oracle Database
2. PostgreSQL (versión 9.3 en adelante)
3. Microsoft SQL Server (conocidadas como vistas indexadas)
4. IBM Db2 (las MQTs son un equivalente)
5. MySQL

*/

