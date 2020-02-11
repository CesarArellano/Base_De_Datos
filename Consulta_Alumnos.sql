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