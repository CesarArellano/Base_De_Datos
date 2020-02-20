DROP FUNCTION edad
delimiter $
CREATE FUNCTION edad(date1 DATE, date2 DATE) RETURNS INT
BEGIN
DECLARE age INT;
SET age = (YEAR(date2)-YEAR(date1))-IF(RIGHT(date2,5) < RIGHT(date1,5),1,0);
RETURN age;
END$
delimiter ;