#1
CREATE TABLE `employees` (
  `employeeNumber` int(11) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `extension` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `officeCode` varchar(10) NOT NULL,
  `reportsTo` int(11) DEFAULT NULL,
  `jobTitle` varchar(50) NOT NULL,
  PRIMARY KEY (`employeeNumber`)
);

INSERT INTO
    employees (
        employeeNumber,
        lastName,
        firstName,
        extension,
        email,
        officeCode,
        reportsTo,
        jobTitle
    )
VALUES (
        69420,
        'perdon',
        'malchiste',
        'x123',
        NULL,
        '1',
        NULL,
        'DBA'
    );
# En la creacion de la tabla se especifica que la misma no puede ser null, si nosotros intentamos insertar en la tabla 'employees'
# un mail que sea null nos va a tirar el error: Error Code: 1048. Column 'email' cannot be null

# 2
UPDATE employees SET employeeNumber = employeeNumber - 20;
# al ejecutar esta linea sql intentara sumar a todos los registros de la tabla 'employees' 20 a su columna 'employeeNumber'.
/*
| employeeNumber | lastName | firstName | extension | email            | officeCode | reportsTo | jobTitle |
|----------------|----------|-----------|-----------|------------------|------------|-----------|----------|
| 69400          | perdon   | malchiste | x123      | NULL             | 1          | NULL      | DBA      |
*/
# En el siguiente caso, el procedimiento es el mismo, solo que en lugar de restar 20 se suma
UPDATE employees SET employeeNumber = employeeNumber + 20;
# Asumo que tengo que aclarar que si por algun motivo el resultado de la suma o resta de este atributo su resultado es igual al valor de otro resgistro, esto nos va a tirar un error
# de duplicidad
# 3
ALTER TABLE employees
ADD COLUMN age INT CHECK (age >= 16 AND age <= 70);

# 4
# La tabla film guarda los artibutos de las peliculas (guardan los datos de las peliculas)
# La tabla actor guarda los atributosd de los actores (la informacion de los actores, nombre, apellido, etc...)
# La tabla film actor guarda una referencia de film y actor (Se guarda su primary key porque este atributo es el que distingue un registro de otro, osea se pueden usar otros atributos
# pero la primary key al ser unica es el mejor atributo para referenciar), estas referencias se guardan para establecer una relacion entre ambas tablas.
# La integridad referencial en este contexto asegura lo siguiente:
#     Las películas listadas en la tabla "film_actor" (a través de la columna "film_id") deben corresponder a registros de películas existentes en la tabla "film".
#     Los actores listados en la tabla "film_actor" (a través de la columna "actor_id") deben corresponder a registros de actores existentes en la tabla "actor".

# 5
ALTER TABLE employees
ADD COLUMN lastUpdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE employees
ADD COLUMN lastUpdateUser VARCHAR(100);

DELIMITER //
CREATE TRIGGER update_lastUpdate
BEFORE UPDATE ON employees FOR EACH ROW
BEGIN
    SET NEW.lastUpdate = CURRENT_TIMESTAMP;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER update_lastUpdateUser
BEFORE UPDATE ON employees FOR EACH ROW
BEGIN
    SET NEW.lastUpdate = CURRENT_TIMESTAMP;
END;
//
DELIMITER ;

show TRIGGERS;
#6

----------------- INS_FILM ------------------
-- Inserta una nueva pelicula en film_text --
/*
BEGIN
    INSERT INTO film_text (film_id, title, description)
        VALUES (new.film_id, new.title, new.description);
END
/
------------------------ UPD_FILM ------------------------
-- Actualiza el film_text existente por uno actualizado --
/
BEGIN
    IF (old.title != new.title) OR (old.description != new.description) OR (old.film_id != new.film_id)
    THEN
        UPDATE film_text
            SET title=new.title,
                description=new.description,
                film_id=new.film_id
        WHERE film_id=old.film_id;
    END IF;
END
/
---------------------------------- DEL_FILM --------------------------------
-- Elimina el film_text existente que corresponde a la pelicula eliminada --
/
BEGIN
    DELETE FROM film_text WHERE film_id = old.film_id;
END
*/