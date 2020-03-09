-- Con loop:
CREATE DEFINER=`root`@`localhost` FUNCTION `potencia_loop`(base INT, exponente INT) RETURNS int(11)
BEGIN
DECLARE resultado, contador INT;
  SET resultado = 1;
  SET contador = 1;
  potencia: LOOP
	SET resultado = resultado * base;
	SET contador = contador + 1;
	IF contador > exponente THEN
  	LEAVE potencia;
	END IF;
  END LOOP potencia;
RETURN resultado;
END

--Con repeat:
CREATE DEFINER=`root`@`localhost` FUNCTION `potencia_repeat`(base INT, exponente INT) RETURNS int(11)
BEGIN
    DECLARE resultado, contador INT;
	SET resultado = 1;
	SET contador = 1;
	potencia: REPEAT
   	 SET resultado = resultado * base;
    	SET contador = contador + 1;
    UNTIL contador > exponente
	END REPEAT potencia;
RETURN resultado;
END

--Con while:
CREATE DEFINER=`root`@`localhost` FUNCTION `potencia_while`(base INT, exponente INT) RETURNS int(11)
BEGIN
    DECLARE resultado, contador INT;
	SET resultado = 1;
	SET contador = 1;
	potencia: WHILE
	contador <= exponente DO
   	 SET resultado = resultado * base;
    	SET contador = contador + 1;
    END WHILE potencia;
RETURN resultado;
END
