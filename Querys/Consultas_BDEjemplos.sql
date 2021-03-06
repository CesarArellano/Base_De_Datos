SET GLOBAL log_bin_trust_function_creators = 1; -- Poder agregar funciones o procedimientos.
SET sql_mode=''; -- Poder realizar consultas sin problemas.

-- Artistas con numero de discos. 
1.- SELECT d_artistas.nombre AS Artista, COUNT(isbn) AS No_Discos  FROM d_artistas LEFT JOIN d_discos USING(idArtista) GROUP BY idArtista;

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

