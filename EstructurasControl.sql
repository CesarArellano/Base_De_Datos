DELIMITER $$
CREATE FUNCTION factorial (numero INT) RETURNS INT
BEGIN
	DECLARE resultado, contador INT;
	SET resultado = 1;
	SET contador = 1;
	REPEAT 
		SET resultado = resultado * contador;
		SET contador = contador + 1;
	UNTIL contador > numero
	END REPEAT;
	RETURN resultado;
END $$
DELIMITER ;


DELIMITER $$
DROP FUNCTION IF EXISTS 'presidentes'.'potencia2' $$
CREATE FUNCTION 'presidentes'.'potencia2' (base INT, exponente INT) RETURNS INT
BEGIN
	DECLARE resultado, contador INT;
	SET resultado = 1;
	SET contador = 1;
	potencia: LOOP 
		SET resultado = resultado * base;
		SET contador = contador + 1;
		IF contador > exponente THEN
			LEAVE potencia;
		END IF
	END LOOP potencia;
	RETURN resultado;
END $$
DELIMITER ;