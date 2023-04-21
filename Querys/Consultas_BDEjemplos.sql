-- Crear tabla d_pais
CREATE TABLE d_pais (
  idPais INT PRIMARY KEY,
  pais VARCHAR(50) NOT NULL
);

-- Agregar registros a d_pais
INSERT INTO d_pais (idPais, pais) VALUES
  (1, 'México'),
  (2, 'Estados Unidos'),
  (3, 'España'),
  (4, 'Argentina'),
  (5, 'Chile');

-- Crear tabla d_artistas
CREATE TABLE d_artistas (
  idArtista INT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  idPais INT,
  CONSTRAINT fk_pais FOREIGN KEY (idPais) REFERENCES d_pais(idPais)
);

-- Agregar registros a d_artistas
INSERT INTO d_artistas (idArtista, nombre, idPais) VALUES
  (1, 'Juan Gabriel', 1),
  (2, 'Michael Jackson', 2),
  (3, 'Luis Miguel', 1),
  (4, 'Shakira', 4),
  (5, 'Alejandro Sanz', 3)
  (6, 'Bandalos Chinos', 4);

-- Crear tabla d_disqueras
CREATE TABLE d_disqueras (
  idDisquera INT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  idPais INT,
  CONSTRAINT fk_pais FOREIGN KEY (idPais) REFERENCES d_pais(idPais)
);

-- Agregar registros a d_disqueras
INSERT INTO d_disqueras (idDisquera, nombre, idPais) VALUES
  (1, 'Sony Music', 2),
  (2, 'EMI', 2),
  (3, 'Universal Music', 1),
  (4, 'Warner Music', 3),
  (5, 'BMG', 4);

-- Crear tabla d_discos
CREATE TABLE d_discos (
  isbn VARCHAR(20) PRIMARY KEY,
  titulo VARCHAR(100) NOT NULL,
  idArtista INT,
  idDisquera INT,
  CONSTRAINT fk_artista FOREIGN KEY (idArtista) REFERENCES d_artistas(idArtista),
  CONSTRAINT fk_disquera FOREIGN KEY (idDisquera) REFERENCES d_disqueras(idDisquera)
);

-- Agregar registros a d_discos
INSERT INTO d_discos (isbn, titulo, idArtista, idDisquera) VALUES
  ('1234567890123', 'Recuerdos II', 1, 3),
  ('2345678901234', 'Thriller', 2, 1),
  ('3456789012345', 'Romances', 3, 3),
  ('4567890123456', 'Fijación oral vol. 1', 4, 1),
  ('5678901234567', 'Más', 5, 4),
  ('6789012345678', 'Dónde están los ladrones?', 4, 5),
  ('7890123456789', 'El alma al aire', 5, 2),
  ('8901234567890', 'Adentro', 5, 5),
  ('9012345678901', 'X', 4, 3),
  ('0123456789012', 'Cómplices', 5, 3),
  ('1234567890124', 'Mis boleros favoritos', 1, 3),
  ('2345678901235', 'El Big Blue', 6, 2);

CREATE TABLE d_pistas (
  idPista INT AUTO_INCREMENT PRIMARY KEY,
  isbn VARCHAR(13),
  numeroPista INT,
  nombre VARCHAR(100),
  duracion TIME,
  FOREIGN KEY (isbn) REFERENCES d_discos(isbn)
);

INSERT INTO d_pistas (idPista, numeroPista, nombre, duracion, isbn) VALUES 
  (1, 1, 'Canción 1', '3:45', '9012345678901'),
  (2, 2, 'Canción 2', '4:02', '9012345678901'),
  (3, 3, 'Canción 3', '3:56', '9012345678901'),
  (4, 1, 'Canción 1', '4:20', '1234567890124'),
  (5, 2, 'Canción 2', '3:32', '1234567890124'),
  (6, 1, 'Canción 1', '4:10', '2345678901235'),
  (7, 2, 'Canción 2', '3:55', '2345678901235'),
  (8, 3, 'Canción 3', '4:05', '2345678901235');


-- SET GLOBAL log_bin_trust_function_creators = 1; -- Poder agregar funciones o procedimientos.
-- SET sql_mode=''; -- Poder realizar consultas sin problemas.

-- Artistas con numero de discos. 
SELECT d_artistas.nombre AS Artista, COUNT(isbn) AS No_Discos  FROM d_artistas LEFT JOIN d_discos USING(idArtista) GROUP BY idArtista;

-- Paises con numero de artistas. 
2.- SELECT p.pais AS Pais, COUNT(idArtista) AS Cuantos FROM d_pais p LEFT JOIN d_artistas USING(idPais) GROUP BY idPais;

-- Paises con numero de disqueras. 
3.- SELECT p.pais AS Pais, COUNT(idDisquera) AS No_Disqueras FROM d_pais p LEFT JOIN d_disqueras USING(idPais) GROUP BY idPais;
-- Artistas con mas discos. 
4.- SELECT a.nombre AS Artista, COUNT(isbn) AS Discos FROM d_artistas a INNER JOIN  d_discos d USING(idArtista) GROUP BY idArtista HAVING Discos = (SELECT COUNT(isbn) AS No_Discos  FROM d_artistas INNER JOIN d_discos USING(idArtista) GROUP BY idArtista ORDER BY No_Discos DESC LIMIT 1) ORDER BY Artista;

-- Artistas con menos discos. 
5.- SELECT a.nombre AS Artista, COUNT(isbn) AS Discos FROM d_artistas a INNER JOIN  d_discos USING(idArtista) GROUP BY idArtista HAVING Discos = (SELECT COUNT(isbn) AS No_Discos  FROM d_artistas INNER JOIN d_discos USING(idArtista) GROUP BY idArtista ORDER BY No_Discos LIMIT 1) ORDER BY Artista;
-- Artistas con ningún disco. 
6.- SELECT a.nombre AS Artista, COUNT(isbn) AS Discos FROM d_artistas a LEFT  JOIN  d_discos USING(idArtista) WHERE isbn IS NULL;

-- TRUCAXOS:
-- NO REPITE VALORES 
SELECT DISTINCT idArtista FROM d_discos ORDER BY idArtista;
-- ARTISTAS CON DISCOS 
SELECT a.nombre AS Artista  FROM d_artistas a WHERE idArtista IN (SELECT DISTINCT idArtista FROM d_discos ORDER BY idArtista);
-- ARTISTAS SIN DISCOS 
SELECT a.nombre AS Artista FROM d_artistas a WHERE idArtista NOT IN (SELECT DISTINCT idArtista FROM d_discos ORDER BY idArtista);

-- Artistas con mas de dos discos. 
7.- SELECT a.nombre AS Artista, COUNT(isbn) AS Discos FROM d_artistas a LEFT  JOIN  d_discos USING(idArtista) GROUP BY idArtista HAVING Discos > 2;

-- Nombre artista, país artista, nombre disquera, país disquera. 
8.- SELECT a.nombre AS Artista, pa.pais AS PaisArtistas, d.nombre, pd.pais AS Disquera FROM d_artistas a LEFT JOIN d_pais pa USING(idPais) RIGHT JOIN d_discos USING(idArtista) LEFT JOIN d_disqueras d USING(idDisquera) LEFT JOIN d_pais pd ON d.idPais = pd.idPais GROUP BY idArtista ORDER BY Artista;

-- Nombre artista, nombre disquera, número de discos. 
9.- SELECT a.nombre AS Artista,d.nombre AS Disquera, COUNT(isbn) AS No_Discos FROM d_artistas a LEFT JOIN d_discos USING(idArtista) LEFT JOIN d_disqueras d USING(idDisquera) GROUP BY Artista ORDER BY idArtista;

-- Nombre artista, nombre disquera, número de discos, número de pistas. 
10.- SELECT a.nombre AS Artista,dis.nombre AS Disquera, COUNT(DISTINCT d.isbn) AS No_Discos, COUNT(idPista) AS No_Pistas FROM d_artistas a INNER JOIN d_discos d USING(idArtista) INNER JOIN d_disqueras dis USING(idDisquera) INNER JOIN d_pistas p USING(isbn) GROUP BY idArtista ORDER BY Artista;

