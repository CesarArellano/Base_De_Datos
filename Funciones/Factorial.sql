-- Con loop:
CREATE DEFINER=`root`@`localhost` FUNCTION `factorial_loop`(numero INT) RETURNS int(11)
BEGIN
DECLARE resultado, contador INT;
SET resultado = 1;
SET contador = 1;
factorial: LOOP
    SET resultado = resultado * contador;
	SET contador = contador + 1;
	IF (contador > numero) THEN
   	 LEAVE factorial;
	END IF;
END LOOP factorial;
RETURN resultado;
END

-- Con repeat:
CREATE DEFINER=`root`@`localhost` FUNCTION `factorial_repeat`(numero INT) RETURNS int(11)
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
END

-- Con while:
CREATE DEFINER=`root`@`localhost` FUNCTION `factorial_while`(numero INT) RETURNS int(11)
BEGIN
DECLARE resultado, contador INT;
SET resultado = 1;
SET contador = 1;
factorial: WHILE
	contador <= numero DO
   	 SET resultado = resultado * contador;
   	 SET contador = contador + 1;
    END WHILE factorial;
RETURN resultado;
END
