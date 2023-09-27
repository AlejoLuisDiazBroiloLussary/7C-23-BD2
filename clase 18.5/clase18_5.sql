#1

CREATE FUNCTION AmountCopiesInStore(filmIdentifier INT, storeId INT) RETURNS INT
BEGIN
    DECLARE copies INT;

    IF filmIdentifier < 1000 THEN
        SELECT COUNT(*) INTO copies
        FROM inventory i
        WHERE i.store_id = storeId
        AND i.film_id = filmIdentifier;
    ELSE
        SELECT COUNT(*) INTO copies
        FROM inventory i
        JOIN film f ON i.film_id = f.film_id
        WHERE i.store_id = storeId
        AND f.title = filmIdentifier;
    END IF;

    RETURN copies;
END //

DELIMITER ;
SELECT AmountCopiesInStore('3', 2);

#2

CREATE PROCEDURE GetCustomerListInCountry(
    IN countryName VARCHAR(50),
    OUT customerNames VARCHAR(255)
)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE firstName VARCHAR(50);
    DECLARE lastName VARCHAR(50);
    DECLARE fullName VARCHAR(100);

    DECLARE customerCursor CURSOR FOR
        SELECT first_name, last_name
        FROM customer cu
        JOIN address ad ON cu.address_id = ad.address_id
        JOIN city ci ON ad.city_id = ci.city_id
        JOIN country co ON ci.country_id = co.country_id
        WHERE co.country = countryName;

    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    SET customerNames = '';

    OPEN customerCursor;

    readLoop: LOOP
        FETCH customerCursor INTO firstName, lastName;

        IF done THEN
            LEAVE readLoop;
        END IF;

        SET fullName = CONCAT(firstName, ' ', lastName);

        IF customerNames = '' THEN
            SET customerNames = fullName;
        ELSE
            SET customerNames = CONCAT(customerNames, '; ', fullName);
        END IF;
    END LOOP;

    CLOSE customerCursor;
END;
//
DELIMITER ;
SET @outputCustomerList = '';

CALL GetCustomerListInCountry('Argentina', @outputCustomerList);

SELECT @outputCustomerList;

#3
/*
inventory_in_stock:
Con esta funcion revisamos si x pelicula esta en stock. 
x representa a inventory_id, con este id el procedimiento buscara si este se encuentra registrado o no, returneando true or false (0,1)
*si la funcion no encuentra alquileres existentes para x devolvera true*

IF v_rentals = 0 THEN
      RETURN TRUE;
    END IF;
*en caso de encontrar alquileres, la funcion revisara el estado del alquiler.
Dependiendo del estado de la fecha de devolucion (not null) significara que la pelicula fue devuelta o si sigue sin estar disponible para alquilar.
  *
    IF v_out > 0 THEN
      RETURN FALSE;
    ELSE
      RETURN TRUE;
    END IF;
  
*/
  
#Ejemplos de Uso:
SELECT inventory_in_stock(1111); # Devuelve 1 
SELECT inventory_in_stock(4568); # Devuelve 0 

/*
film_in_stock:

Con esta funcion verificamos si p_film_id (pelicula a buscar) se encuentra en p_store_id (tienda en la que buscar), a esta funcion le podemos agregar p_film_count,
con este parametro limitamos la cantidad de resultados obtenidos

  WHERE film_id = p_film_id *revisamos si la pelicula coincide con p_film_id*
  AND store_id = p_store_id *revisamos si la pelicula se encuentra en la tienda especificada*
  AND inventory_in_stock(inventory_id); *usando el metodo anterior revisamos si la pelicula esta en stock*

  *luego contamos la cantidad de coincidencias y las almacenamos*
  
    SELECT COUNT(*)
    FROM inventory
    WHERE film_id = p_film_id
    AND store_id = p_store_id
    AND inventory_in_stock(inventory_id)
    INTO p_film_count;
*/


# Llama al procedimiento para encontrar elementos del inventario de la película con ID 2 en la tienda con ID 2
CALL film_in_stock(1, 3, @total);

# Muestra la cantidad de elementos disponibles
SELECT @total;

#Este ejemplo llama al procedimiento film_in_stock para encontrar elementos del inventario de la película con ID 1 en la tienda con ID 3 y almacena el recuento de elementos disponibles en la variable @total, mostrando el resultado
