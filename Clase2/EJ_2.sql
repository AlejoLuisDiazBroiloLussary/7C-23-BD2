DROP DATABASE if exists imbd;

create DATABASE imbd;

use imbd

CREATE TABLE Film(
    film_id INT NOT NULL AUTO_INCREMENT,
    tittle VARCHAR(20) NOT NULL,
    description VARCHAR(100),
    release_year DATE,
    CONSTRAINT film_id PRIMARY KEY (film_id)
);

insert into Film (tittle, description, release_year) values(
    'The Voices',
    'Jerry, a factory worker, battles his good and evil talking pets as he tries to pursue a romance while covering up a string of murders.',
    '2015-01-23'
);

insert into Film (tittle, description, release_year) values(
    'The Prestige',
    'Rival magicians engage in a dangerous game of one-upmanship, with tragic consequences.',
    '2006-10-20'

);

insert into Film (tittle, description, release_year) values(
    'Inception',
    'A thief enters peoples dreams to steal their secrets.',
    '2010-07-16'
);

insert into Film (tittle, description, release_year) values (
    'The Dark Knight',
    'Batman raises the stakes in his war on crime',
    '2008-07-18'
);

insert into Film (tittle, description, release_year) values (
    'The Matrix',
    'A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.',
    '1999-03-31'
);

insert into Film (tittle, description, release_year) values (
    'Jurassic Park',
    'A pragmatic paleontologist visiting an almost complete theme park is tasked with protecting a couple of kids after a power failure causes the parks cloned dinosaurs to run loose.',
    '1993-06-11'
);

insert into Film (tittle, description, release_year) values (
    'The Shawshank Redemption',
    'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.',
    '1994-10-14'
);

insert into Film (tittle, description, release_year) values (
    'The Godfather',
    'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.',
    '1972-03-24'
);


ALTER TABLE Film
ADD COLUMN last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

CREATE TABLE Actor(
    actor_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(10) NOT NULL,
    last_name VARCHAR(10) NOT NULL,
    CONSTRAINT actor_id PRIMARY KEY (actor_id)
);

insert into Actor (first_name, last_name) values(
    'Ryan',
    'Reynolds'
);

insert into Actor (first_name, last_name) values(
    'Hugh',
    'Jackman'
);

insert into Actor (first_name, last_name) values(
    'Leonardo',
    'DiCaprio'
);

insert into Actor (first_name, last_name) values (
    'Christian',
    'Bale'
);

insert into Actor (first_name, last_name) values (
    'Keanu',
    'Reeves'
);

insert into Actor (first_name, last_name) values (
    'Sam',
    'Neill'
);

insert into Actor (first_name, last_name) values (
    'Tim',
    'Robbins'
);

insert into Actor (first_name, last_name) values (
    'Marlon',
    'Brando'
);


ALTER TABLE Actor
ADD COLUMN last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

CREATE TABLE FilmActor(
    FA_id INT NOT NULL AUTO_INCREMENT,
    id_actor int NOT NULL,
    id_film int NOT NULL,
    CONSTRAINT FA_id PRIMARY KEY (FA_id)
);

ALTER TABLE FilmActor 
ADD FOREIGN KEY (id_actor) REFERENCES Actor(actor_id),
ADD FOREIGN KEY (id_film) REFERENCES Film(film_id);

insert into FilmActor (id_actor, id_film) values (1, 1);
insert into FilmActor (id_actor, id_film) values (2, 1);
insert into FilmActor (id_actor, id_film) values (2, 2);
insert into FilmActor (id_actor, id_film) values (3, 3);