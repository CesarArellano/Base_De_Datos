CREATE VIEW vestudiantes AS SELECT Nombre, Calificacion FROM a_Alumnos LEFT JOIN a_Calificaciones USING (AlumnoID);

CREATE DEFINER=`ic19cav`@`localhost` PROCEDURE `MejorPromedio`(OUT Mejor_Promedio DECIMAL(5,2), OUT Mejor_Alumno CHAR(40))
BEGIN
	DECLARE Salida,Calif,Contador INT;
    DECLARE NomAlumno CHAR(40);
    DECLARE Promedio, CalTotal DECIMAL(5,2);
    DECLARE CurCalif CURSOR FOR
		SELECT Calificacion FROM vestudiantes WHERE Nombre = NomAlumno;
	DECLARE CurAlumnos CURSOR FOR
		SELECT Nombre FROM a_Alumnos;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET Salida = 1;
	SET Promedio = 0;
	SET CalTotal = 0;
	SET Contador = 0;
    SET Salida = 0;
    OPEN CurAlumnos;
    Cur_Al: REPEAT
        FETCH CurAlumnos INTO NomAlumno;
        IF Salida = 1  THEN
            LEAVE Cur_Al;
        END IF;
        OPEN CurCalif;
        Cur_Cal: REPEAT
            FETCH CurCalif INTO Calif;
            IF Salida = 1 THEN
                LEAVE Cur_Cal;
            END IF;
            SET CalTotal = CalTotal + Calif;
            SET Contador = Contador + 1;
            UNTIL Salida = 1
        END REPEAT Cur_Cal;
        CLOSE CurCalif;
        SET Salida = 0;
        IF Contador > 0 THEN
            SET CalTotal = CalTotal /Contador;
        END IF;
        IF Promedio < CalTotal THEN
            SET Mejor_Alumno =  NomAlumno;
            SET Promedio = CalTotal;
        END IF;
        SET CalTotal = 0;
        SET Contador = 0;
        UNTIL Salida = 1
    END REPEAT Cur_al;
    CLOSE CurAlumnos;
    SET Mejor_Promedio = Promedio;
END

CALL MejorPromedio(@Promedio,@Nombre);
SELECT @Promedio, @Nombre;
