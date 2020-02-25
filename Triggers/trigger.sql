# Los triggers sólo pueden ser creados por los administradores de las bases de datos
CREATE TABLE t(i INT, dt DATETIME);
delimiter $
CREATE TRIGGER t_ins BEFORE INSERT ON t
FOR EACH ROW BEGIN
    SET NEW.dt = CURRENT_TIMESTAMP;
    IF NEW.i < 0 THEN
        SET NEW.i =0;
    END IF;
END$
delimiter ;
INSERT INTO t(i) VALUES (-2),(0),(2);
SELECT * FROM t;
