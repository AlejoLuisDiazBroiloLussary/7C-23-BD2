drop database IF EXISTS GimnacioEjercicio;

CREATE DATABASE GimnacioEjercicio;

use GimnacioEjercicio;

CREATE Table Socio(
    id int(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(15),
    apellido VARCHAR(15),
    dni INT (8)
);

INSERT INTO Socio (nombre, apellido, dni) VALUES(
    "pepe",
    "mujica",
    11111111
);
INSERT INTO Socio (nombre, apellido, dni) VALUES(
    "teooooooo",
    "sheyna",
    11111112
);

CREATE Table Sede(
    id int(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(15)
);

INSERT INTO Sede (nombre) VALUES(
    "LAGIM"
);


CREATE Table TipoPlan(
    id int(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(15)
);

INSERT INTO TipoPlan (nombre) VALUES(
    "hipertrofia"
);

INSERT INTO TipoPlan (nombre) VALUES(
    "tonificación"
);

INSERT INTO TipoPlan (nombre) VALUES(
    "fuerza"
);

CREATE Table Reserva(
    id int(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    socio int,
    finalizado BOOLEAN,
    CONSTRAINT socio FOREIGN KEY (socio) REFERENCES Socio(id)
);
INSERT INTO Reserva (socio, finalizado) VALUES (
    1,
    FALSE
);
INSERT INTO Reserva (socio, finalizado) VALUES (
    2,
    TRUE
);

CREATE Table Clase(
    id int(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    capacidad INT,
    hora_inicio TIME,
    hora_fin TIME,
    fecha DATE,
    fecha_creacion DATE,
    nombre VARCHAR(15),
    reserva int,
    tipo_plan int,
    CONSTRAINT reserva FOREIGN KEY (reserva) REFERENCES Reserva(id),
    CONSTRAINT tipo_plan FOREIGN KEY (tipo_plan) REFERENCES TipoPlan(id)
);

