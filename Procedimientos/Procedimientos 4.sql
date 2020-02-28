CREATE VIEW verestudiantes AS SELECT Nombre, Calificacion FROM a_Alumnos LEFT JOIN a_Calificaciones USING (AlumnoID);

CREATE DEFINER=`ic19cav`@`localhost` PROCEDURE `MejorPromedio2`(OUT Mejor_Promedio DECIMAL(5,2), OUT Mejor_Alumno CHAR(40))
BEGIN
	DECLARE Salida INT;
    DECLARE NomAlumno CHAR(40);
    DECLARE Promedio, TempProm DECIMAL(5,2);
    DECLARE CurCalif CURSOR FOR
		SELECT Nombre,AVG(Calificacion) FROM verestudiantes GROUP BY Nombre;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET Salida = 1;
	SET Promedio = 0;
	SET Salida = 0;
	OPEN CurCalif;
	Cur_Calif: REPEAT
		FETCH CurCalif INTO NomAlumno,TempProm;
		IF Salida = 1  THEN
			LEAVE Cur_Calif;
		END IF;
		IF TempProm > Promedio THEN
			SET Mejor_Alumno = NomAlumno;
			SET Promedio = TempProm;
		END IF;
	UNTIL Salida = 1
	END REPEAT Cur_Calif;
	CLOSE CurCalif;
	SET Mejor_Promedio = Promedio;
END

CALL MejorPromedio2(@Promedio,@Nombre);
SELECT @Promedio, @Nombre;

CREATE DEFINER=`ic19cav`@`localhost` PROCEDURE `MejorPromedio3`(OUT Mejor_Promedio DECIMAL(5,2), OUT Mejor_Alumno CHAR(40))
BEGIN
	DECLARE CurCalif CURSOR FOR SELECT Nombre,AVG(Calificacion) AS Promedio FROM verestudiantes GROUP BY Nombre ORDER BY Promedio DESC LIMIT 1;
	OPEN CurCalif;
		FETCH CurCalif INTO Mejor_Alumno, Mejor_Promedio;
	CLOSE CurCalif;
END
