DROP DATABASE IF EXISTS grupo12;

create DATABASE grupo12;

use grupo12;



CREATE Table Raza(
    id INT(11) NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(30) not null,
    CONSTRAINT id PRIMARY KEY (id)
);


CREATE Table Especie(
    id INT(11) NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(30) not null,
    CONSTRAINT id PRIMARY KEY (id)
);



CREATE Table Personalidad(
    id INT(11) NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(30) not null,
    CONSTRAINT id PRIMARY KEY (id)
);



CREATE Table Tamanio(
    id INT(11) NOT NULL AUTO_INCREMENT,
    nombre varchar(20),
    longitud_maxima int,
    longitud_minima int,
    altura_maxima int,
    altura_minima int,
    CONSTRAINT id PRIMARY KEY (id)
);



CREATE Table Mascota(
    id INT(11) NOT NULL AUTO_INCREMENT,
    nombre varchar(20),
    fecha_nacimiento date,
    genero BOOLEAN,
    estado BOOLEAN,
    especie int,
    tamanio int,
    raza int,
    personalidad int,
    CONSTRAINT id PRIMARY KEY (id)
);
ALTER TABLE Mascota
  ADD
    CONSTRAINT FOREIGN KEY (especie) REFERENCES Especie (id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Mascota
  ADD
    CONSTRAINT FOREIGN KEY (tamanio) REFERENCES Tamanio (id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Mascota
  ADD
    CONSTRAINT FOREIGN KEY (raza) REFERENCES Raza (id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Mascota
  ADD
    CONSTRAINT FOREIGN KEY (personalidad) REFERENCES Personalidad (id) ON DELETE CASCADE ON UPDATE CASCADE;



CREATE Table HistorialMedico(
    id INT(11) NOT NULL AUTO_INCREMENT,
    fecha_ultimo_registro DATE,
    estado BOOLEAN,
    mascota int,
    CONSTRAINT id PRIMARY KEY (id)
);
ALTER TABLE HistorialMedico
  ADD
    CONSTRAINT FOREIGN KEY (mascota) REFERENCES Mascota (id) ON DELETE CASCADE ON UPDATE CASCADE;



CREATE Table Vacuna(
    id INT(11) NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(30) not null,
    docis int,
    historial int,
    CONSTRAINT id PRIMARY KEY (id)
);

ALTER TABLE Vacuna
  ADD
    CONSTRAINT FOREIGN KEY (historial) REFERENCES HistorialMedico (id) ON DELETE CASCADE ON UPDATE CASCADE;



CREATE Table Consulta(
    id INT(11) NOT NULL AUTO_INCREMENT,
    medico VARCHAR(30) not null,
    fecha TIMESTAMP DEFAULT NOW(),
    historial int,
    CONSTRAINT id PRIMARY KEY (id)
);




ALTER TABLE Consulta
  ADD
    CONSTRAINT FOREIGN KEY (historial) REFERENCES HistorialMedico (id) ON DELETE CASCADE ON UPDATE CASCADE;



CREATE Table Cirugia(
    id INT(11) NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(30) not null,
    fecha TIMESTAMP DEFAULT NOW(),
    tipo varchar(30),
    historial int,
    CONSTRAINT id PRIMARY KEY (id)
);
ALTER TABLE Cirugia
  ADD
    CONSTRAINT FOREIGN KEY (historial) REFERENCES HistorialMedico (id) ON DELETE CASCADE ON UPDATE CASCADE;



CREATE Table Tratamiento(
    id INT(11) NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(30) not null,
    historial int,
    fecha TIMESTAMP DEFAULT NOW(),
    CONSTRAINT id PRIMARY KEY (id)
);
ALTER TABLE Tratamiento
  ADD
    CONSTRAINT FOREIGN KEY (historial) REFERENCES HistorialMedico (id) ON DELETE CASCADE ON UPDATE CASCADE;
  


CREATE Table Direccion(
    id INT(11) NOT NULL AUTO_INCREMENT,
    calle VARCHAR(30) not null,
    altura int,
    localidad varchar(30),
    CONSTRAINT id PRIMARY KEY (id)
);



CREATE Table Persona(
    id INT(11) NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(30) not null,
    email varchar(30),
    telefono varchar(30),
    fecha_nacimiento DATE,
    direccion int,
    CONSTRAINT id PRIMARY KEY (id)
);
ALTER TABLE Persona
  ADD
    CONSTRAINT FOREIGN KEY (direccion) REFERENCES Direccion (id) ON DELETE CASCADE ON UPDATE CASCADE;



CREATE Table Adoptante(
    id INT(11) NOT NULL AUTO_INCREMENT,
    persona int,
    CONSTRAINT id PRIMARY KEY (id)
);

ALTER TABLE Adoptante
  ADD
    CONSTRAINT FOREIGN KEY (persona) REFERENCES Persona (id) ON DELETE CASCADE ON UPDATE CASCADE;



CREATE Table Preferencia(
    id INT(11) NOT NULL AUTO_INCREMENT,
    edad int,
    especie int,
    tamanio int,
    raza int,
    personalidad int,
    adoptante int,
    CONSTRAINT id PRIMARY KEY (id)
);
ALTER TABLE Preferencia
  ADD
    CONSTRAINT FOREIGN KEY (especie) REFERENCES Especie (id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Preferencia
  ADD
    CONSTRAINT FOREIGN KEY (tamanio) REFERENCES Tamanio (id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Preferencia
  ADD
    CONSTRAINT FOREIGN KEY (raza) REFERENCES Raza (id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Preferencia
  ADD
    CONSTRAINT FOREIGN KEY (personalidad) REFERENCES Personalidad (id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Preferencia
  ADD
    CONSTRAINT FOREIGN KEY (adoptante) REFERENCES Adoptante (id) ON DELETE CASCADE ON UPDATE CASCADE;



CREATE Table Peticion(
    id INT(11) NOT NULL AUTO_INCREMENT,
    fecha_admicion date default null,
    fecha_creacion date default null,
    validacion BOOLEAN,
    adoptante int,
    mascota int,
    CONSTRAINT id PRIMARY KEY (id)
);
ALTER TABLE Peticion
  ADD
    CONSTRAINT FOREIGN KEY (adoptante) REFERENCES Adoptante (id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Peticion
  ADD
    CONSTRAINT FOREIGN KEY (mascota) REFERENCES Mascota (id) ON DELETE CASCADE ON UPDATE CASCADE;



CREATE Table Requerimientos(
    id INT(11) NOT NULL AUTO_INCREMENT,
    nombre Varchar(100),
    peticion int,
    CONSTRAINT id PRIMARY KEY (id)
);
ALTER TABLE Requerimientos
  ADD
    CONSTRAINT FOREIGN KEY (peticion) REFERENCES Peticion (id) ON DELETE CASCADE ON UPDATE CASCADE;



CREATE Table Estado_asistencia(
    id INT(11) NOT NULL AUTO_INCREMENT,
    estado varchar(30),
    CONSTRAINT id PRIMARY KEY (id)
);



CREATE Table Clase(
    id INT(11) NOT NULL AUTO_INCREMENT,
    nombre varchar(30) not null,
    CONSTRAINT id PRIMARY KEY (id)
);



CREATE Table Curso(
    id INT(11) NOT NULL AUTO_INCREMENT,
    progreso Varchar(30) not null,
    fecha DATE,
    hora TIME,
    clase int,
    CONSTRAINT id PRIMARY KEY (id)
);
ALTER TABLE Curso
  ADD
    CONSTRAINT FOREIGN KEY (clase) REFERENCES Clase (id) ON DELETE CASCADE ON UPDATE CASCADE;



CREATE Table Asistencia(
    id INT(11) NOT NULL AUTO_INCREMENT,
    mascota int,
    estado_asistencia int,
    curso int,
    CONSTRAINT id PRIMARY KEY (id)
);
ALTER TABLE Asistencia
  ADD
    CONSTRAINT FOREIGN KEY (mascota) REFERENCES Mascota (id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Asistencia
  ADD
    CONSTRAINT FOREIGN KEY (estado_asistencia) REFERENCES Estado_asistencia (id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Asistencia
  ADD
    CONSTRAINT FOREIGN KEY (curso) REFERENCES Curso (id) ON DELETE CASCADE ON UPDATE CASCADE;



CREATE Table Voluntario(
    id INT(11) NOT NULL AUTO_INCREMENT,
    genero Varchar(30) not null,
    CONSTRAINT id PRIMARY KEY (id)
);
ALTER TABLE Voluntario
  ADD
    CONSTRAINT FOREIGN KEY (id) REFERENCES Persona (id) ON DELETE CASCADE ON UPDATE CASCADE;



CREATE Table Actividad(
    id INT(11) NOT NULL AUTO_INCREMENT,
    nombre Varchar(100) not null,
    CONSTRAINT id PRIMARY KEY (id)
);



CREATE Table Cronograma(
    id INT(11) NOT NULL AUTO_INCREMENT,
    hora_inicio Time,
    hora_fin Time,
    dia DATE,
    voluntario int,
    actividad int,
    CONSTRAINT id PRIMARY KEY (id)
);
ALTER TABLE Cronograma
  ADD
    CONSTRAINT FOREIGN KEY (voluntario) REFERENCES Voluntario (id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Cronograma
  ADD
    CONSTRAINT FOREIGN KEY (actividad) REFERENCES Actividad (id) ON DELETE CASCADE ON UPDATE CASCADE;



CREATE Table Evento(
    id INT(11) NOT NULL AUTO_INCREMENT,
    nombre Varchar(100) not null,
    CONSTRAINT id PRIMARY KEY (id)
);



CREATE Table Patreon(
    id INT(11) NOT NULL AUTO_INCREMENT,
    nombre_empresa Varchar(30),
    evento int,
    CONSTRAINT id PRIMARY KEY (id)
);
ALTER TABLE Patreon
  ADD
    CONSTRAINT FOREIGN KEY (id) REFERENCES Persona (id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Patreon
  ADD
    CONSTRAINT FOREIGN KEY (evento) REFERENCES Evento (id) ON DELETE CASCADE ON UPDATE CASCADE;



CREATE Table Staff(
    id INT(11) NOT NULL AUTO_INCREMENT,
    voluntario int,
    evento int,
    CONSTRAINT id PRIMARY KEY (id)
);
ALTER TABLE Staff
  ADD
    CONSTRAINT FOREIGN KEY (evento) REFERENCES Evento (id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Staff
  ADD
    CONSTRAINT FOREIGN KEY (voluntario) REFERENCES Voluntario (id) ON DELETE CASCADE ON UPDATE CASCADE;

INSERT INTO Raza (nombre) VALUES 
('Chihuahua'),
('Bulldog'),
('Labrador Retriever'),
('Poodle'),
('German Shepherd'),
('Golden Retriever'),
('Shih Tzu'),
('Siberian Husky'),
('Doberman'),
('Rottweiler');

INSERT INTO Especie (nombre) VALUES 
('Perro'),
('Gato'),
('Loro'),
('Conejo'),
('Tortuga'),
('Pez'),
('Hamster'),
('Serpiente'),
('Ratón'),
('Caballo');

INSERT INTO Personalidad (nombre) VALUES 
('Amigable'),
('Leal'),
('Energético'),
('Juguetón'),
('Inteligente'),
('Protector'),
('Cariñoso'),
('Valiente'),
('Entusiasta'),
('Obediente');

INSERT INTO Tamanio (nombre, longitud_maxima, longitud_minima, altura_maxima, altura_minima) VALUES 
('Toy', 25, 15, 25, 15),
('Pequeño', 40, 25, 40, 25),
('Mediano', 60, 40, 60, 40),
('Grande', 75, 60, 75, 60),
('Gigante', 90, 75, 90, 75);


INSERT INTO Mascota (nombre, fecha_nacimiento, genero, estado, especie, tamanio, raza, personalidad) VALUES
('Luna', '2021-01-15', 0, 1, 1, 2, 1, 7),
('Max', '2020-03-10', 1, 1, 1, 3, 2, 2),
('Nala', '2019-11-25', 0, 1, 1, 4, 3, 4),
('Rocky', '2020-06-03', 1, 0, 1, 4, 4, 3),
('Simba', '2020-02-14', 1, 1, 1, 2, 2, 9),
('Zeus', '2019-08-12', 1, 0, 1, 5, 5, 6),
('Bella', '2021-02-20', 0, 1, 1, 1, 6, 1),
('Thor', '2020-09-08', 1, 1, 1, 3, 7, 8),
('Lola', '2019-06-01', 0, 1, 1, 2, 8, 5),
('Bruno', '2020-11-11', 1, 1, 1, 4, 9, 2);

INSERT INTO HistorialMedico (fecha_ultimo_registro, estado, mascota) VALUES
('2021-01-15', 0, 1),
('2020-03-10', 1, 2),
('2019-11-25', 0, 3),
('2020-06-03', 1, 4),
('2020-02-14', 1, 5),
('2019-08-12', 1, 6),
('2021-02-20', 0, 7),
('2020-09-08', 1, 8),
('2019-06-01', 0, 9),
('2020-11-11', 1, 10);

INSERT INTO Vacuna (nombre, docis, historial) VALUES 
('Vacuna1', 1, 1), 
('Vacuna1', 1, 2), 
('Vacuna1', 1, 3), 
('Vacuna1', 1, 4), 
('Vacuna1', 1, 5), 
('Vacuna1', 1, 6), 
('Vacuna1', 1, 7), 
('Vacuna1', 1, 8), 
('Vacuna1', 1, 9), 
('Vacuna1', 1, 10);

INSERT INTO Cirugia (nombre, tipo, historial) VALUES 
('cirugia', 'cirugia del corazon', 1), 
('cirugia', 'cirugia del corazon', 2), 
('cirugia', 'cirugia del corazon', 3), 
('cirugia', 'cirugia del corazon', 4), 
('cirugia', 'cirugia del corazon', 5);

INSERT INTO Tratamiento (nombre, historial) VALUES 
('Tratamiento A', 1),
('Tratamiento A', 2),
('Tratamiento B', 3),
('Tratamiento B', 4),
('Tratamiento B', 5);

INSERT INTO Direccion (calle, altura, localidad) VALUES
('Obispo Trejo', 500, 'Cordoba'),
('Laprida', 1200, 'Cordoba'),
('Fructuoso Rivera', 800, 'Cordoba'),
('San Jeronimo', 900, 'Cordoba'),
('Luis de Tejeda', 1500, 'Cordoba'),
('Dean Funes', 700, 'Cordoba'),
('General Paz', 1000, 'Cordoba'),
('Chacabuco', 1100, 'Cordoba'),
('Lima', 1300, 'Cordoba'),
('Rioja', 1400, 'Cordoba'),
('Calle Falsa', 123, 'Springfield'),
('Avenida Siempreviva', 742, 'Springfield'),
('Calle del Sol', 15, 'Barcelona'),
('Avenida de la Libertad', 20, 'Madrid'),
('Calle del Mar', 5, 'Valencia'),
('Avenida del Parque', 30, 'Sevilla'),
('Calle del Pilar', 10, 'Zaragoza'),
('Avenida de la Constitución', 50, 'Granada'),
('Calle Mayor', 100, 'Toledo'),
('Avenida de la Paz', 200, 'Málaga'),
('Calle Falsa', 123, 'Springfield'),
('Avenida Siempreviva', 742, 'Springfield'),
('Calle del Sol', 15, 'Barcelona'),
('Avenida de la Libertad', 20, 'Madrid'),
('Calle del Mar', 5, 'Valencia'),
('Avenida del Parque', 30, 'Sevilla'),
('Calle del Pilar', 10, 'Zaragoza'),
('Avenida de la Constitución', 50, 'Granada'),
('Calle Mayor', 100, 'Toledo'),
('Avenida de la Paz', 200, 'Málaga');

INSERT INTO Persona (nombre, email, telefono, fecha_nacimiento, direccion) VALUES
('Juan Perez', 'juan.perez@example.com', '+54115555555', '1990-05-15', 1),
('Maria Garcia', 'maria.garcia@example.com', '+54116666666', '1985-02-21', 2),
('Carlos Rodriguez', 'carlos.rodriguez@example.com', '+54117777777', '1995-10-12', 3),
('Ana Lopez', 'ana.lopez@example.com', '+54118888888', '2000-08-02', 4),
('Pedro Fernandez', 'pedro.fernandez@example.com', '+54119999999', '1978-11-28', 5),
('Laura Sanchez', 'laura.sanchez@example.com', '+541110101010', '1982-07-19', 6),
('Diego Gomez', 'diego.gomez@example.com', '+54112121212', '1998-03-06', 7),
('Valeria Torres', 'valeria.torres@example.com', '+54113232323', '1992-12-17', 8),
('Sofia Gonzalez', 'sofia.gonzalez@example.com', '+54114343434', '1975-09-23', 9),
('Gabriel Martinez', 'gabriel.martinez@example.com', '+54115454545', '1988-04-13', 10),
('Carlos', 'carlos@email.com', '555-1222', '1999-08-12', 11),
('Laura', 'laura@email.com', '555-1239', '2001-04-25', 17),
('Jorge', 'jorge@email.com', '555-1434', '1995-11-02', 14),
('Ana', 'ana@email.com', '555-1294', '1992-12-30', 12),
('Luis', 'luis@email.com', '555-1834', '1998-06-10', 20),
('Sofía', 'sofia@email.com', '555-2234', '2002-02-22', 13),
('Pablo', 'pablo@email.com', '555-3234', '1989-09-01', 19),
('María', 'maria@email.com', '555-6234', '1997-07-05', 14),
('Miguel', 'miguel@email.com', '555-1234', '1994-03-15', 16),
('Elena', 'elena@email.com', '555-1562', '2000-12-31', 15),
('Juan Perez', 'juan.perez@gmail.com', '555-1234', '1990-05-15', 21),
('Maria Rodriguez', 'maria.rodriguez@gmail.com', '555-5678', '1985-08-22', 22),
('Pedro Sanchez', 'pedro.sanchez@gmail.com', '555-9012', '1995-03-01', 23),
('Laura Fernandez', 'laura.fernandez@gmail.com', '555-3456', '1982-11-10', 24),
('Pablo Diaz', 'pablo.diaz@gmail.com', '555-7890', '1998-07-05', 25),
('Ana Garcia', 'ana.garcia@gmail.com', '555-2345', '1989-02-14', 26),
('Carlos Martin', 'carlos.martin@gmail.com', '555-6789', '1980-09-18', 27),
('Sara Gomez', 'sara.gomez@gmail.com', '555-0123', '1992-06-25', 28),
('David Jimenez', 'david.jimenez@gmail.com', '555-4567', '1997-12-03', 29),
('Carmen Torres', 'carmen.torres@gmail.com', '555-8901', '1987-04-20', 30);

INSERT into Adoptante (persona) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10);

INSERT INTO Preferencia (edad, especie, tamanio, raza, personalidad, adoptante) VALUES
(5, 1, 1, 1, 1, 1),
(5, 1, 2, 2, 2, 2),
(5, 1, 1, 1, 1, 3),
(5, 1, 1, 1, 1, 4),
(10, 1, 5, 5, 5, 5);

INSERT INTO Peticion (fecha_admicion, fecha_creacion, validacion, adoptante, mascota) VALUES
('2022-02-28', '2022-01-15', true, 1, 3),
('2022-03-01', '2022-01-16', true, 2, 1),
('2022-03-03', '2022-01-18', true, 4, 5),
('2022-03-04', '2022-01-19', false, 5, 4),
('2022-03-05', '2022-01-20', true, 6, 8),
('2022-03-06', '2022-01-21', true, 7, 6),
('2022-03-07', '2022-01-22', true, 8, 10),
('2022-03-08', '2022-01-23', false, 9, 7),
('2022-03-09', '2022-01-24', true, 10, 9);
INSERT INTO Peticion (fecha_admicion, validacion, adoptante, mascota) VALUES
('2022-03-02', false, 3, 2);


INSERT INTO Requerimientos (nombre, peticion) VALUES 
('Experiencia previa con mascotas', 1),
('Vivienda con patio', 2),
('No convivir con otros animales', 3),
('Niños en casa', 4),
('Tiempo disponible para pasear', 5),
('Compromiso a seguir el plan de vacunación', 6),
('Disponibilidad para asistir a reuniones con veterinario', 7),
('Capacidad para costear cuidado de mascota', 8),
('Habilidad para entrenamiento', 9),
('Ninguno', 10);

insert into Estado_asistencia (estado) VALUES
("vino"),
("no vino"),
("pendiente");

insert into Clase (nombre) VALUES
("paseo"),
("respeto"),
("mysql");

INSERT INTO Curso (progreso, fecha, hora, clase) VALUES 
(1, '2023-02-28', '18:00:00', 1),
(1, '2023-03-28', '18:00:00', 1),
(1, '2023-03-27', '14:30:00', 2),
(1, '2023-03-26', '16:15:00', 3),
(1, '2023-03-25', '10:00:00', 1),
(1, '2023-03-24', '13:45:00', 1),
(1, '2023-03-23', '19:30:00', 1),
(1, '2023-03-22', '12:00:00', 3),
(1, '2023-03-21', '15:45:00', 3),
(1, '2023-03-20', '17:30:00', 3),
(1, '2023-03-19', '09:00:00', 2);

INSERT INTO Asistencia (mascota, estado_asistencia, curso) VALUES 
(1, 1, 1),
(2, 1, 1),
(3, 2, 2),
(4, 1, 2),
(5, 2, 3),
(6, 2, 4),
(7, 1, 5),
(8, 1, 6),
(9, 2, 6),
(10, 1, 7);

INSERT INTO Voluntario(genero) VALUES
('Femenino'),
('Masculino'),
('Femenino'),
('Masculino'),
('No binario'),
('Femenino'),
('Masculino'),
('No binario'),
('Femenino'),
('Masculino');

INSERT INTO Actividad (nombre) VALUES
  ('Clases de yoga'),
  ('Reparto de alimentos'),
  ('Visitas a asilos'),
  ('Limpieza de parques'),
  ('Recogida de basura en la playa'),
  ('Apoyo escolar'),
  ('Organización de eventos comunitarios'),
  ('Mentoría de jóvenes'),
  ('Ayuda en refugios de animales'),
  ('Recogida de donaciones');


INSERT INTO Cronograma (hora_inicio, hora_fin, dia, voluntario, actividad) VALUES
  ('10:00:00', '12:00:00', '2023-04-01', 1, 3),
  ('09:00:00', '11:00:00', '2023-04-02', 1, 2),
  ('14:00:00', '16:00:00', '2023-04-03', 5, 3),
  ('13:00:00', '15:00:00', '2023-04-04', 6, 4),
  ('11:00:00', '13:00:00', '2023-04-05', 9, 5),
  ('10:00:00', '12:00:00', '2023-04-06', 2, 6),
  ('09:00:00', '11:00:00', '2023-04-07', 7, 10),
  ('14:00:00', '16:00:00', '2023-04-08', 2, 10),
  ('13:00:00', '15:00:00', '2023-04-09', 9, 1),
  ('11:00:00', '13:00:00', '2023-04-10', 7, 9);


INSERT INTO Evento (nombre) VALUES 
('Campaña de adopción'),
('Jornada de vacunación'),
('Talleres de entrenamiento canino'),
('Charlas sobre tenencia responsable'),
('Caminata con perros para fomentar la actividad física'),
('Recogida de donaciones para perros callejeros'),
('Día de spa para perros rescatados'),
('Desfile de moda canino'),
('Concurso de habilidades caninas'),
('Jornada de esterilización');

INSERT INTO Patreon (nombre_empresa, evento) VALUES 
('Acme Corp', 1),
('ABC Inc', 2),
('XYZ Company', 3),
('Smith Enterprises', 4),
('Johnson Industries', 1),
('Doe Corporation', 5),
('Jackson Corporation', 3),
('Anderson Corporation', 2),
('Brown Industries', 4),
('White Enterprises', 1);


iNSERT INTO Staff(voluntario, evento) VALUES
(1, 2),
(2, 4),
(3, 4),
(4, 1),
(5, 2),
(6, 1),
(7, 1),
(8, 2),
(9, 2),
(10, 3);