CREATE TABLE a_TipoExamen(
    TipoID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Tipo ENUM('S','M','F') NOT NULL          
);

CREATE TABLE a_Materias(
    MateriaID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL          
);

CREATE TABLE a_Alumnos(
    AlumnoID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    FechaNacimiento DATE,
    Genero ENUM('M','F')
);

CREATE TABLE a_Examenes(
    ExamenID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Fecha DATE NOT NULL,
    MateriaID INT REFERENCES Materias(MateriaID) ON DELETE CASCADE ON UPDATE CASCADE,
    TipoID INT REFERENCES TipoExamen(TipoID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE a_Calificaciones(
    AlumnoID INT REFERENCES Alumnos(AlumnoID) ON DELETE CASCADE ON UPDATE CASCADE,
    ExamenID INT REFERENCES Examenes(ExamenID) ON DELETE CASCADE ON UPDATE CASCADE,
    Calificacion DECIMAL(4,2) NOT NULL,
    PRIMARY KEY(AlumnoID,ExamenID)
);

CREATE TABLE a_Ausencias(
    AusenciaID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Fecha DATE,
    AlumnoID INT REFERENCES Alumnos(AlumnoID) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO a_Alumnos (Nombre,FechaNacimiento,Genero) VALUES('César Mauricio', '2000-02-15','M'),
                                                            ('Jaqueline Emilia','1999-09-23','F'),
                                                            ('Raúl','2000-06-16','M'),
                                                            ('Allan Jair','2000-07-12','M'),
                                                            ('Emanuel Zuriel','2000-01-05','M'),
                                                            ('Eduardo','2000-02-16','M'),
                                                            ('Gaby','2000-10-10','F'),
                                                            ('Jhoana','2000-01-31','F'),
                                                            ('Jorge Emilio','2000-12-21','M'),
                                                            ('Javier','2000-02-14','M');

INSERT INTO a_Materias (Nombre) VALUES('Cálculo'),
                                      ('Sistemas Analógicos'),
                                      ('Sistemas de Base de Datos'),
                                      ('Reflexion');

INSERT INTO a_TipoExamen (Tipo) VALUES('S'),
                                      ('M'),
                                      ('F');

INSERT INTO a_Examenes (Fecha,MateriaID,TipoID) VALUES('2020-02-14','3','2'),
                                                      ('2020-03-11','1','2'),
                                                      ('2020-02-20','2','1'),
                                                      ('2020-03-14','1','2'),
                                                      ('2020-02-27','4','1'),
                                                      ('2020-04-05','3','3'),
                                                      ('2020-02-25','4','2'),
                                                      ('2020-05-05','2','3');
