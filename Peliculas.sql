--crear base de datos
CREATE DATABASE peliculas;

-- nos conectamos a las peliculas

\c peliculas

CREATE TABLE movies(
    id SERIAL,
    nombre VARCHAR(255),
    Año_estreno SMALLINT,
    Director VARCHAR (100),
    PRIMARY KEY (id)
);

CREATE TABLE reparto(
    id_movie SERIAL,
    nombre_actor VARCHAR(255),
    FOREIGN KEY (id_movie) REFERENCES movies (id)
);

\copy movies FROM 'Escritorio/peliculas/peliculas.csv' csv header;

\copy reparto FROM 'Escritorio/peliculas/reparto.csv'csv;
 
--Titanic
SELECT nombre_actor,nombre,Año_estreno,Director 
FROM reparto,movies
WHERE nombre = 'Titanic' and id_movie=id;

--Harrison Ford

SELECT nombre
FROM movies
INNER JOIN
(SELECT id_movie
FROM reparto
WHERE nombre_actor = 'Harrison Ford') AS t1 ON id = id_movie

--10 directores mas populares

SELECT Director, COUNT(Director) AS Times
From movies
GROUP BY Director
ORDER BY Times DESC
Limit 10

-- Actores Distintos
SELECT COUNT(nombre_actor)
FROM 
(SELECT DISTINCT nombre_actor
FROM reparto) AS t1

--Peliculas entre 1990 y 1999

SELECT nombre
FROM movies
WHERE Año_estreno >= 1990 AND Año_estreno <= 1999
ORDER BY nombre ASC;

--Peliculas Lanzadas el 2001

SELECT nombre_actor
FROM movies,reparto
WHERE Año_estreno = 2001 and id= id_movie;

--Actores Pelicula mas nueva

SELECT nombre_actor
From reparto
WHERE id_movie IN
(SELECT id
FROM movies
ORDER BY Año_estreno DESC 
LIMIT 1);