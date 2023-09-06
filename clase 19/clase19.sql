# 1
CREATE USER 'data_analyst'@'localhost' IDENTIFIED BY 'contra';

#2
GRANT SELECT, UPDATE, DELETE ON sakila.* TO 'data_analyst'@'localhost';

#3
#mysql -u data_analyst -p 
#contra

  use sakila;
create table MyTable (
    id_table int primary key auto_increment,
    title varchar(100),
    description varchar(250)
);
-- ERROR 1142 (42000): CREATE command denied to user 'data_analyst'@'localhost' for table 'MyTable'

#4
use sakila;

UPDATE film
    SET title = 'other title'
WHERE title = 'Academy Dinosaur';

#ahora cuando hagas una query de los titulos de la peliculas, la pelicula con el id que tenia 'Academy Dinosaur' va a tener de titulo 'other title'
#esto lo puedo hacer porque yo le di los derechos de 'UPDATE'
  
#5
REVOKE UPDATE ON sakila.* FROM data_analyst;

#6
#mysql -u data_analyst -p 
#contra

use sakila;
UPDATE film SET title = 'Barbenheimer' WHERE film_id = 1;
#ERROR 1142 (42000): UPDATE command denied to user 'data_analyst'@'localhost' for table 'film'
