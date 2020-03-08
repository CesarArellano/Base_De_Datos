CREATE DATABASE test;
USE `test` ;

-- -----------------------------------------------------
-- Tabla `Asesores`
-- -----------------------------------------------------
CREATE TABLE `Asesores` (
  `idAsesor` INT NOT NULL AUTO_INCREMENT,
  `nombreAsesor` VARCHAR(45) NOT NULL,
  `aPaternoAsesor` VARCHAR(45) NULL,
  `aMaternoAsesor` VARCHAR(45) NULL,
  PRIMARY KEY (`idAsesor`));

-- -----------------------------------------------------
-- Tabla `CategoriaClientes`
-- -----------------------------------------------------
CREATE TABLE `CategoriaClientes` (
  `idCategoriaCliente` INT NOT NULL AUTO_INCREMENT,
  `nombreCategoriaCliente` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategoriaCliente`));



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
-- Tabla `Departamentos`
-- -----------------------------------------------------
CREATE TABLE `Departamentos` (
  `idDepartamento` INT NOT NULL AUTO_INCREMENT,
  `nombreDepartamento` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idDepartamento`));


-- -----------------------------------------------------
-- Tabla `CategoriaProductos`
-- -----------------------------------------------------
CREATE TABLE `CategoriaProductos` (
  `idCategoriaProducto` INT NOT NULL AUTO_INCREMENT,
  `nombreCategoriaProducto` VARCHAR(45) NULL,
  PRIMARY KEY (`idCategoriaProducto`));


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
-- Table `Compras`
-- -----------------------------------------------------
CREATE TABLE `Compras` (
  `idCompra` INT NOT NULL AUTO_INCREMENT,
  `idCliente` INT NULL,
  `formaPago` VARCHAR(45) NOT NULL,
  `fechaCompra` DATETIME NOT NULL,
  PRIMARY KEY (`idCompra`),
  INDEX `idCliente_idx` (`idCliente` ASC) VISIBLE,
  CONSTRAINT `idCliente Compras`
    FOREIGN KEY (`idCliente`)
    REFERENCES `Clientes` (`idCliente`)
    ON DELETE SET NULL
    ON UPDATE CASCADE);


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
-- Tabla `Opiniones`
-- -----------------------------------------------------
CREATE TABLE `Opiniones` (
  `idOpinion` INT NOT NULL AUTO_INCREMENT,
  `idCliente` INT NOT NULL,
  `idProducto` INT NOT NULL,
  `calificacion` DECIMAL(2,1) NOT NULL,
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
-- Tabla `TarjetasClientes`
-- -----------------------------------------------------
CREATE TABLE `TarjetasClientes` (
  `idTarjeta` INT NOT NULL AUTO_INCREMENT,
  `idCliente` INT NOT NULL,
  `numeroTarjeta` VARCHAR(16) NOT NULL,
  `tipoTarjeta` ENUM('Credito', 'Debito') NOT NULL,
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
-- Table `DevolucionesCancelaciones`
-- -----------------------------------------------------
CREATE TABLE `DevolucionesCancelaciones` (
  `idCaso` INT NOT NULL AUTO_INCREMENT,
  `idProducto` INT NOT NULL,
  `idCompra` INT NOT NULL,
  `tipo` ENUM('Cancelacion', 'Devolucion') NOT NULL,
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