CREATE DATABASE Practica1;
USE `Practica1`;

-- -----------------------------------------------------
-- Tabla `Asesores`
-- -----------------------------------------------------
CREATE TABLE `Asesores` (
  `idAsesor` INT NOT NULL AUTO_INCREMENT,
  `nombreAsesor` VARCHAR(45) NOT NULL,
  `aPaternoAsesor` VARCHAR(45) NOT NULL,
  `aMaternoAsesor` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAsesor`));

-- -----------------------------------------------------
-- Registros `Asesores`
-- -----------------------------------------------------

INSERT INTO `Asesores` (`idAsesor`, `nombreAsesor`, `aPaternoAsesor`, `aMaternoAsesor`) VALUES
(1, 'Daniel', 'Gómez', 'Flores'),
(2, 'Carlos', 'Cruz', 'Ramírez'),
(3, 'Jorge', 'Sánchez', 'Rodríguez'),
(4, 'Josefina', 'Hernández', 'Hernández');


-- -----------------------------------------------------
-- Tabla `CategoriaClientes`
-- -----------------------------------------------------
CREATE TABLE `CategoriaClientes` (
  `idCategoriaCliente` INT NOT NULL AUTO_INCREMENT,
  `nombreCategoriaCliente` VARCHAR(45) NOT NULL,
  `porcentajeEnvio` decimal(6,2) NOT NULL
  PRIMARY KEY (`idCategoriaCliente`));

-- -----------------------------------------------------
-- Registros `CategoriaClientes`
-- -----------------------------------------------------
INSERT INTO `CategoriaClientes` (`idCategoriaCliente`, `nombreCategoriaCliente`, `porcentajeEnvio`) VALUES
(1, 'Novato', '0.20'),
(2, 'Principiante', '0.15'),
(3, 'Intermedio', '0.10'),
(4, 'Avanzado', '0.05'),
(5, 'Entusiasta', '0.02');

-- -----------------------------------------------------
-- Tabla `CategoriaProductos`
-- -----------------------------------------------------
CREATE TABLE `CategoriaProductos` (
  `idCategoriaProducto` INT NOT NULL AUTO_INCREMENT,
  `nombreCategoriaProducto` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategoriaProducto`));

-- -----------------------------------------------------
-- Registros `CategoriaProductos`
-- -----------------------------------------------------
INSERT INTO `CategoriaProductos` (`idCategoriaProducto`, `nombreCategoriaProducto`) VALUES
(1, 'Accesorios de electrónica'),
(2, 'Celulares'),
(3, 'Cocina'),
(4, 'Baño');

-- -----------------------------------------------------
-- Tabla `Clientes`
-- -----------------------------------------------------
CREATE TABLE `Clientes` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `idCategoriaCliente` INT NOT NULL,
  `usuario` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `nombreCliente` VARCHAR(45) NOT NULL,
  `aPaternoCliente` VARCHAR(45) NOT NULL,
  `aMaternoCliente` VARCHAR(45) NOT NULL,
  `rfc` VARCHAR(13) NOT NULL,
  `direccionEnvio` VARCHAR(150) NOT NULL,
  `direccionFacturacion` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `usuario_UNIQUE` (`usuario` ASC) VISIBLE,
  INDEX `ID Categoria Cliente_idx` (`idCategoriaCliente` ASC) VISIBLE,
  CONSTRAINT `ID Categoria Clientes`
    FOREIGN KEY (`idCategoriaCliente`)
    REFERENCES `CategoriaClientes` (`idCategoriaCliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- Registros `Clientes`
-- -----------------------------------------------------
INSERT INTO `Clientes` (`idCliente`, `idCategoriaCliente`, `usuario`, `password`, `nombreCliente`, `aPaternoCliente`, `aMaternoCliente`, `rfc`, `direccionEnvio`, `direccionFacturacion`) VALUES
(1, 1, 'sofiahg', '00000001', 'Sofía', 'Hernández', 'García', 'HEGS750809IS1', 'Calle Guillermo Gonzalez Camarena 450, Santa Fe, Zedec Sta Fé, Álvaro Obregón, 01219 Ciudad de México, CDMX ', 'Calle Guillermo Gonzalez Camarena 450, Santa Fe, Zedec Sta Fé, Álvaro Obregón, 01219 Ciudad de México, CDMX '),
(2, 2, 'joseml', '00000002', 'José', 'Martínez', 'López', 'MALJ900221NW9', 'Albert Einstein 104-81, Santa Fe, Paseo de las Lomas, Álvaro Obregón, 01330 Ciudad de México, CDMX', 'Albert Einstein 104-81, Santa Fe, Paseo de las Lomas, Álvaro Obregón, 01330 Ciudad de México, CDMX'),
(3, 3, 'camilagp', '00000003', 'Camila', 'González', 'Pérez', 'GOPC4203253C9', 'Vasco de Quiroga 2000, Santa Fe, Zedec Sta Fé, Álvaro Obregón, 01219 Ciudad de México, CDMX', 'Vasco de Quiroga 2000, Santa Fe, Zedec Sta Fé, Álvaro Obregón, 01219 Ciudad de México, CDMX'),
(4, 4, 'miguelrs', '00000004', 'Miguel', 'Rodríguez', 'Sánchez', 'ROSM961110RM7', 'Cda. Palo Alto MZ4 LT10, Granjas Palo Alto, Cuajimalpa de Morelos, 05110 Ciudad de México, CDMX', 'Cda. Palo Alto MZ4 LT10, Granjas Palo Alto, Cuajimalpa de Morelos, 05110 Ciudad de México, CDMX'),
(5, 5, 'valentinarc', '00000005', 'Valentina', 'Ramírez', 'Cruz', 'RACV600205I88', 'Cedro 20, El Olivo, 52789 Naucalpan de Juárez, Méx.', 'Cedro 20, El Olivo, 52789 Naucalpan de Juárez, Méx.');

-- -----------------------------------------------------
-- Table `Compras`
-- -----------------------------------------------------
CREATE TABLE `Compras` (
  `idCompra` INT NOT NULL AUTO_INCREMENT,
  `idCliente` INT NULL,
  `formaPago` ENUM('Tarjeta de crédito','Depósito bancario','Transferencia electrónica','Pago en tienda de conveniencia') NOT NULL,
  `fechaCompra` DATETIME NOT NULL,
  PRIMARY KEY (`idCompra`),
  INDEX `idCliente_idx` (`idCliente` ASC) VISIBLE,
  CONSTRAINT `idCliente Compras`
    FOREIGN KEY (`idCliente`)
    REFERENCES `Clientes` (`idCliente`)
    ON DELETE SET NULL
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- Registros `Compras`
-- -----------------------------------------------------
INSERT INTO `Compras` (`idCompra`, `idCliente`, `formaPago`, `fechaCompra`) VALUES
(1, 1, 'Tarjeta de crédito', '2019-11-03 10:21:39'),
(2, 2, 'Depósito bancario', '2019-05-25 05:46:21'),
(3, 3, 'Transferencia electrónica', '2019-02-16 19:48:59'),
(4, 1, 'Pago en tienda de conveniencia', '2019-02-19 13:19:00');

-- -----------------------------------------------------
-- Tabla `Departamentos`
-- -----------------------------------------------------
CREATE TABLE `Departamentos` (
  `idDepartamento` INT NOT NULL AUTO_INCREMENT,
  `nombreDepartamento` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idDepartamento`));

-- -----------------------------------------------------
-- Registros `Departamentos`
-- -----------------------------------------------------
INSERT INTO `Departamentos` (`idDepartamento`, `nombreDepartamento`) VALUES
(1, 'Electrónicos'),
(2, 'Hogar');

-- -----------------------------------------------------
-- Tabla `HistorialAtencion`
-- -----------------------------------------------------
CREATE TABLE `HistorialAtencion` (
  `idAtencion` INT NOT NULL AUTO_INCREMENT,
  `idAsesor` INT NOT NULL,
  `idCliente` INT NOT NULL,
  `estado` ENUM('Abierto', 'Cerrado') NOT NULL,
  `comentarios` VARCHAR(1000) NULL,
  PRIMARY KEY (`idAtencion`),
  INDEX `ID Cliente_idx` (`idCliente` ASC) VISIBLE,
  INDEX `ID Asesor HistorialAtencion_idx` (`idAsesor` ASC) VISIBLE,
  CONSTRAINT `ID Cliente HistorialAtencion`
    FOREIGN KEY (`idCliente`)
    REFERENCES `Clientes` (`idCliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ID Asesor HistorialAtencion`
    FOREIGN KEY (`idAsesor`)
    REFERENCES `Asesores` (`idAsesor`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- Registros `HistorialAtencion`
-- -----------------------------------------------------
INSERT INTO `HistorialAtencion` (`idAtencion`, `idAsesor`, `idCliente`, `estado`, `comentarios`) VALUES
(1, 1, 1, 'Abierto', 'Requiere cambiar su dirección.'),
(2, 2, 2, 'Cerrado', 'No podía ingresar al sistema, se restableció su contraseña.'),
(3, 3, 3, 'Abierto', 'No puede agregar una tarjeta.'),
(4, 4, 4, 'Cerrado', 'Su nombre estaba mal ingresado, se corrijió.'),
(5, 1, 5, 'Abierto', 'No le llegó un producto.'),
(8, 2, 1, 'Cerrado', 'No abría el sitio web en su dispositivo móvil, se restauró la configuración de red del terminal y se resolvió el problema.');

-- -----------------------------------------------------
-- Tabla `Productos`
-- -----------------------------------------------------
CREATE TABLE `Productos` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `idDepartamento` INT NOT NULL,
  `idCategoriaProducto` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `marca` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(1000) NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  `stock` INT NOT NULL,
  PRIMARY KEY (`idProducto`),
  INDEX `ID Departamento_idx` (`idDepartamento` ASC) VISIBLE,
  INDEX `ID Categoria Producto_idx` (`idCategoriaProducto` ASC) VISIBLE,
  CONSTRAINT `ID Departamento Productos`
    FOREIGN KEY (`idDepartamento`)
    REFERENCES `Departamentos` (`idDepartamento`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ID CategoriaProducto Productos`
    FOREIGN KEY (`idCategoriaProducto`)
    REFERENCES `CategoriaProductos` (`idCategoriaProducto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- Registros `Productos`
-- -----------------------------------------------------
INSERT INTO `Productos` (`idProducto`, `idDepartamento`, `idCategoriaProducto`, `nombre`, `marca`, `descripcion`, `precio`, `stock`) VALUES
(1, 1, 1, 'Redmi Airdots', 'Xiaomi', '- Compatibles con Bluetooth 5.0\r\n- Tecnología True Wireless, como en los Airdots Pro, para una conexión super rápida.\r\n- Estuche cargador con entrada microusb y batería de 300mAh, tus audífonos se cargan mientras están guardados en su estuche.\r\n- Hasta 4 horas de uso continuo, con batería de 40mAh.\r\n- Muy ligeros, con peso de 4g.\r\n', '447.00', 50),
(2, 1, 1, 'Tarjeta microSDXC con adaptador de 128GB', 'ADATA', '- Código de proveedor RAM-3040\r\n- UHS-I\r\n- Clase 10 A1\r\n- Velocidad de transferencia de 85Mb/s', '325.00', 50),
(3, 1, 2, 'Redmi Note 8', 'Xiaomi', '- Pantalla: Grande 6,3 pulgadas, 1080 x 2340 píxeles\r\n- Chipset: Qualcomm SDM665 Snapdragon 665, hasta 2.0Ghz\r\n- Sistema: Android 9.0 (Pie) Con MIUI 10\r\n- Cámara: 13MP cámara selfie, 48MP 8MP 2MP 2MP cámaras quad traseras\r\n- Batería: batería de gran capacidad 4000mAh, viene con cargador rápido de 18W', '3779.00', 50),
(4, 1, 2, 'P30 Lite', 'Huawuei', '- Tamaño de la pantalla: 6.15 pulgadas\r\n- MicroSD expandible a 256 GB\r\n- Parlantes stereo\r\n- Tipo de batería: Batería de polímero de litio\r\n- Sistema operativo: EMUI 9.0 (Basado en Android 9)', '4746.00', 50),
(5, 2, 3, 'Cafetera de 4 tazas', 'Oster', '- Luz indicadora de encendido y apagado permite saber si la cafetera está encendida o apagada, lo que ofrece un punto de seguridad importante.\r\n- Filtro permanente y la canasta removible facilita su llenado y limpieza.\r\n- La función de pausa para servir permite servir café durante el proceso de colado.\r\n- Las ventanillas dobles muestran la cantidad de agua que se encuentra en el tanque para llenarlo con precisión.\r\n- El espacio para almacenar el cable permite guardar el excedente de forma segura para mantener el mostrador organizado.', '165.00', 50),
(6, 2, 3, 'Termo de acero inoxidable de 473ml', 'Contigo', '- Botón AutoSeal negro, apto para lavado en rejilla superior de lavaplatos, cuerpo lavado a mano; libre de BPA.\r\n- Tecnología de aislamiento al vacío que mantiene el calor de tus bebidas por hasta 5 horas y el frío por hasta 12 horas.\r\n- Se ajusta debajo de la mayoría de las máquinas de café para servicio individual y en la mayoría de los portavasos de automóviles.\r\n- La tapa AutoSeal patentada se sella automáticamente entre sorbos para evitar derrames y goteo.', '321.00', 50),
(7, 2, 4, 'Toalla deportiva de microfibra de 80 x 160cm', 'Sharx', '- Las Mejores Toallas de Microfibra ahora en México.\r\n- Usa Sharx para: Natación, Gym, Correr, Box, Bici, CrossFit, Trekking, Hiking, Yoga, Tenis, Squash, Racquet, Golf, Kayak, Velero, Surf, Rafting, Motos, Coches, Volley, Beis, Fut, Basket, Patinaje, Excursiones, Días de Campo, Playa, Alberca o en tu Casa después de bañarte.\r\n- Sharx es el producto indispensable para todos los que practicamos un deporte ya sea a nivel profesional, amateur o simplemente como diversión.\r\n- Nuestra Toallas son: 3 veces más Ligeras que una Toalla de Algodón. 6 veces más compactas que una Toalla de Algodón. Absorben 3 veces su peso en Agua. Se secan 3 veces más rapido que una Toalla de Algodón. Mucho más atractivas que una Toalla de Algodón. 16 modelos diferentes. ', '369.00', 50),
(8, 2, 4, 'Organizador de maquillaje rotador', 'JSBelle', '- ORGANIZADOR DE ROTACIÓN DE 360 °: organiza y almacena perfectamente sus cosméticos; permite un fácil acceso a todos tus productos y maquillaje.\r\n- GRAN CAPACIDAD: Acomoda al menos 30 pinceles de maquillaje, 20 botellas de productos para el cuidado de la piel y otros accesorios de maquillaje.\r\n- 7 CAPAS AJUSTABLES: le permiten ajustar la altura de la bandeja para adaptarse a diferentes tipos de cosméticos y envases.\r\n- FÁCIL DE ENSAMBLAR Y LAVAR: monte y desarme rápidamente el organizador siguiendo la guía.\r\n- Paquete incluido: 1 x organizador de Cosméticos, guía de instalación', '499.00', 50);


-- -----------------------------------------------------
-- Tabla `ComprasProductos`
-- -----------------------------------------------------
CREATE TABLE `ComprasProductos` (
  `idCompra` INT NOT NULL,
  `idProducto` INT NOT NULL,
  `cantidadProducto` INT NOT NULL,
  PRIMARY KEY (`idCompra`, `idProducto`),
  INDEX `ID Producto_idx` (`idProducto` ASC) VISIBLE,
  CONSTRAINT `ID Compra ComprasProductos`
    FOREIGN KEY (`idCompra`)
    REFERENCES `Compras` (`idCompra`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ID Producto ComprasProductos`
    FOREIGN KEY (`idProducto`)
    REFERENCES `Productos` (`idProducto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
-- -----------------------------------------------------
-- Registros `ComprasProductos`
-- -----------------------------------------------------
INSERT INTO `ComprasProductos` (`idCompra`, `idProducto`, `cantidadProducto`) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 1),
(2, 4, 1),
(3, 5, 1),
(3, 6, 4),
(3, 7, 1),
(4, 4, 1);

-- -----------------------------------------------------
-- Tabla `DevolucionesCancelaciones`
-- -----------------------------------------------------
CREATE TABLE `DevolucionesCancelaciones` (
  `idCaso` INT NOT NULL AUTO_INCREMENT,
  `idProducto` INT NOT NULL,
  `idCompra` INT NOT NULL,
  `tipo` ENUM('Cancelación', 'Devolución') NOT NULL,
  `cantidadDC` INT NOT NULL,
  PRIMARY KEY (`idCaso`),
  INDEX `ID Producto_idx` (`idProducto` ASC) VISIBLE,
  INDEX `ID Compra_idx` (`idCompra` ASC) VISIBLE,
  CONSTRAINT `ID Producto DevolucionesCancelaciones`
    FOREIGN KEY (`idProducto`)
    REFERENCES `Productos` (`idProducto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ID Compra DevolucionesCancelaciones`
    FOREIGN KEY (`idCompra`)
    REFERENCES `Compras` (`idCompra`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
-- -----------------------------------------------------
-- Registros `DevolucionesCancelaciones`
-- -----------------------------------------------------
INSERT INTO `DevolucionesCancelaciones` (`idCaso`, `idProducto`, `idCompra`, `tipo`, `cantidadDC`) VALUES
(1, 4, 2, 'Devolución', 1),
(2, 7, 3, 'Devolución', 1),
(3, 4, 4, 'Cancelación', 1);

-- -----------------------------------------------------
-- Tabla `Opiniones`
-- -----------------------------------------------------
CREATE TABLE `Opiniones` (
  `idOpinion` INT NOT NULL AUTO_INCREMENT,
  `idCliente` INT NOT NULL,
  `idProducto` INT NOT NULL,
  `calificacion` INT NOT NULL,
  `comentario` VARCHAR(1000) NOT NULL,
  PRIMARY KEY (`idOpinion`),
  INDEX `ID Cliente_idx` (`idCliente` ASC) VISIBLE,
  INDEX `ID Producto_idx` (`idProducto` ASC) VISIBLE,
  CONSTRAINT `ID Cliente Opiniones`
    FOREIGN KEY (`idCliente`)
    REFERENCES `Clientes` (`idCliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ID Producto Opiniones`
    FOREIGN KEY (`idProducto`)
    REFERENCES `Productos` (`idProducto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- Registros `Opiniones`
-- -----------------------------------------------------
INSERT INTO `Opiniones` (`idOpinion`, `idCliente`, `idProducto`, `calificacion`, `comentario`) VALUES
(1, 2, 3, 9, 'Buena pantalla, rendimiento y cámaras. El Software podría estar mejor.'),
(2, 3, 5, 8, 'Tiene buen aspecto y materiales de construcción, pero calienta lento en comparación con otras cafeteras.');

-- -----------------------------------------------------
-- Tabla `TarjetasClientes`
-- -----------------------------------------------------
CREATE TABLE `TarjetasClientes` (
  `idTarjeta` INT NOT NULL AUTO_INCREMENT,
  `idCliente` INT NOT NULL,
  `numeroTarjeta` VARCHAR(16) NOT NULL,
  `tipoTarjeta` ENUM('Crédito', 'Débito') NOT NULL,
  `mesCaducidad` VARCHAR(2) NULL,
  `anioCaducidad` VARCHAR(4) NULL,
  `nombreTarjetaHabiente` VARCHAR(150) NOT NULL,
  `institucionFinanciera` ENUM('American Express','Mastercard','Visa') NOT NULL,
  PRIMARY KEY (`idTarjeta`),
  INDEX `ID Cliente_idx` (`idCliente` ASC) VISIBLE,
  CONSTRAINT `ID Cliente TarjetasClientes` 
    FOREIGN KEY (`idCliente`)
    REFERENCES `Clientes` (`idCliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- Registros `TarjetasClientes`
-- -----------------------------------------------------

INSERT INTO `TarjetasClientes` (`idTarjeta`, `idCliente`, `numeroTarjeta`, `tipoTarjeta`, `mesCaducidad`, `anioCaducidad`, `nombreTarjetaHabiente`, `institucionFinanciera`) VALUES
(1, 1, '1000200030004000', 'Crédito', '09', '2022', 'Sofía Hernández García', 'American Express'),
(2, 2, '5000600070008000', 'Débito', '03', '2022', 'José Martínez López', 'Mastercard');