/* Creación de la tabla de alumnos */
CREATE TABLE a_Alumnos (
  AlumnoID INT PRIMARY KEY,
  Nombre VARCHAR(50),
  Genero VARCHAR(10)
);

/* Inserción de algunos registros de ejemplo en la tabla de alumnos */
INSERT INTO a_Alumnos (AlumnoID, Nombre, Genero) VALUES
(1, 'Ana', 'Femenino'),
(2, 'Juan', 'Masculino'),
(3, 'María', 'Femenino'),
(4, 'Pedro', 'Masculino'),
(5, 'Sofía', 'Femenino'),
(6, 'Carlos', 'Masculino');

/* Creación de la tabla de examenes */
CREATE TABLE a_Examenes (
  ExamenID INT PRIMARY KEY,
  Nombre VARCHAR(50)
);

/* Inserción de algunos registros de ejemplo en la tabla de examenes */
INSERT INTO a_Examenes (ExamenID, Nombre) VALUES
(1, 'Matemáticas'),
(2, 'Física'),
(3, 'Historia');

/* Creación de la tabla de calificaciones */
CREATE TABLE a_Calificaciones (
  CalificacionID INT PRIMARY KEY,
  AlumnoID INT,
  ExamenID INT,
  Calificacion FLOAT,
  FOREIGN KEY (AlumnoID) REFERENCES a_Alumnos(AlumnoID),
  FOREIGN KEY (ExamenID) REFERENCES a_Examenes(ExamenID)
);

/* Inserción de algunos registros de ejemplo en la tabla de calificaciones */
INSERT INTO a_Calificaciones (CalificacionID, AlumnoID, ExamenID, Calificacion) VALUES
(1, 1, 1, 8),
(2, 1, 2, 7),
(3, 2, 1, 9),
(4, 2, 2, 6),
(5, 3, 1, 7),
(6, 3, 2, 8),
(7, 4, 1, 6),
(8, 4, 2, 5),
(9, 5, 1, 10),
(10, 5, 2, 9),
(11, 6, 1, 8),
(12, 6, 2, 7);

/* Creación de la tabla de ausencias */
CREATE TABLE a_Ausencias (
  AusenciaID INT PRIMARY KEY,
  AlumnoID INT,
  Fecha DATE,
  FOREIGN KEY (AlumnoID) REFERENCES a_Alumnos(AlumnoID)
);

/* Inserción de algunos registros de ejemplo en la tabla de ausencias */
INSERT INTO a_Ausencias (AusenciaID, AlumnoID, Fecha) VALUES
(1, 1, '2022-01-05'),
(2, 1, '2022-01-10'),
(3, 2, '2022-01-02'),
(4, 3, '2022-01-07'),
(5, 4, '2022-01-10');

/* CONSULTAS */

/* 1.- Nombre de los alumnos que tengan más de 7.5 de promedio en los exámenes */
SELECT a.Nombre, AVG(c.Calificacion) AS Promedio FROM a_Alumnos a INNER JOIN a_Calificaciones c USING(AlumnoID) GROUP BY AlumnoID HAVING Promedio > 7.5 ORDER BY Promedio;
SELECT a.Nombre FROM a_Alumnos a INNER JOIN a_Calificaciones c USING(AlumnoID) GROUP BY AlumnoID HAVING AVG(c.Calificacion) > 7.5 ORDER BY AVG(c.Calificacion);

/* 2.- Nombre de los almnos que tengan faltas */
SELECT a.Nombre FROM a_Alumnos a INNER JOIN a_Ausencias USING(AlumnoID) GROUP BY AlumnoID;

/* 3.- Nombre de los alumnos que no hayan faltado */
SELECT a.nombre AS Alumnos_Sin_Faltas FROM a_Alumnos a WHERE AlumnoID NOT IN (SELECT DISTINCT AlumnoID FROM a_Ausencias ORDER BY AlumnoID);

/* 4.- Cuántos alumnos no han faltado */
SELECT COUNT(a.nombre) AS Cuantos_Sin_Faltas FROM a_Alumnos a WHERE AlumnoID NOT IN (SELECT DISTINCT AlumnoID FROM a_Ausencias ORDER BY AlumnoID);

/* 5.- Cuántos alumnos tienen más de una falta */
SELECT a.Nombre FROM a_Alumnos a INNER JOIN a_Ausencias USING(AlumnoID) GROUP BY AlumnoID HAVING COUNT(AlumnoID) > 1;

/* 6.- Número de alumnos por género */
SELECT COUNT(a.Genero) AS Cuantos,Genero FROM a_Alumnos a GROUP BY Genero;

/* 7.- Nombre, género y promedio de exámenes */
SELECT a.Nombre, a.Genero, AVG(c.Calificacion) FROM a_Alumnos a LEFT JOIN a_Calificaciones c USING(AlumnoID) GROUP BY AlumnoID;  

/* 8.- Promedio de exámenes por género*/
SELECT AVG(c.Calificacion) FROM a_Alumnos a LEFT JOIN a_Calificaciones c USING(AlumnoID) GROUP BY Genero; 

/* 9.- Calificación máxima, mínima, promedio y número de alumnos que presentaron cada examen */
SELECT MAX(c.Calificacion), MIN(c.Calificacion), AVG(c.Calificacion), COUNT(AlumnoID) FROM a_Examenes INNER JOIN a_Calificaciones c USING(ExamenID) GROUP BY ExamenID;

/* 10.- Lista de los alumnos que tienen el promedio más alto */
SELECT a.Nombre, ROUND(AVG(c.Calificacion),2) AS Promedio FROM a_Alumnos a INNER JOIN a_Calificaciones c USING(AlumnoID) GROUP BY AlumnoID HAVING Promedio = (SELECT ROUND(AVG(c.Calificacion),2) AS Promedio FROM a_Alumnos a INNER JOIN a_Calificaciones c USING(AlumnoID) GROUP BY AlumnoID ORDER BY Promedio DESC LIMIT 1);