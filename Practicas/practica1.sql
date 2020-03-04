USE 'ic19cav';

-- -----------------------------------------------------
-- Tabla `CategoriaClientes`
-- -----------------------------------------------------
CREATE TABLE `CategoriaClientes` (
  `idCategoriaCliente` INT NOT NULL,
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
  CONSTRAINT `ID Categoria Cliente`
    FOREIGN KEY (`idCategoriaCliente`)
    REFERENCES `CategoriaClientes` (`idCategoriaCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


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
  `idCategoriaProducto` INT NOT NULL,
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
  `descripcion` VARCHAR(150) NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  `stock` INT NOT NULL,
  PRIMARY KEY (`idProducto`),
  INDEX `ID Departamento_idx` (`idDepartamento` ASC) VISIBLE,
  INDEX `ID Categoria Producto_idx` (`idCategoriaProducto` ASC) VISIBLE,
  CONSTRAINT `ID Departamento`
    FOREIGN KEY (`idDepartamento`)
    REFERENCES `Departamentos` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ID Categoria Producto`
    FOREIGN KEY (`idCategoriaProducto`)
    REFERENCES `CategoriaProductos` (`idCategoriaProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Tabla `Compras`
-- -----------------------------------------------------
CREATE TABLE I`Compras` (
  `idCompra` INT NOT NULL AUTO_INCREMENT,
  `idCliente` INT NOT NULL,
  `formaPago` VARCHAR(45) NOT NULL,
  `fechaCompra` DATETIME NOT NULL,
  PRIMARY KEY (`idCompra`),
  INDEX `idCliente_idx` (`idCliente` ASC) VISIBLE,
  CONSTRAINT `idCliente`
    FOREIGN KEY (`idCliente`)
    REFERENCES `Clientes` (`idCliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Tabla `HistorialAtencion`
-- -----------------------------------------------------
CREATE TABLE `HistorialAtencion` (
  `idAtencion` INT NOT NULL AUTO_INCREMENT,
  `idCliente` INT NOT NULL,
  `nombreAsesor` VARCHAR(45) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `comentarios` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAtencion`),
  INDEX `ID Cliente_idx` (`idCliente` ASC) VISIBLE,
  CONSTRAINT `ID Cliente`
    FOREIGN KEY (`idCliente`)
    REFERENCES `Clientes` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


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
  CONSTRAINT `ID Cliente`
    FOREIGN KEY (`idCliente`)
    REFERENCES `Clientes` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ID Producto`
    FOREIGN KEY (`idProducto`)
    REFERENCES `Productos` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Tabla `tarjetasClientes`
-- -----------------------------------------------------
CREATE TABLE `tarjetasClientes` (
  `idTarjeta` INT NOT NULL AUTO_INCREMENT,
  `idCliente` INT NOT NULL,
  `numeroTarjeta` INT(16) NOT NULL,
  `tipoTarjeta` ENUM('Credito', 'Debito') NOT NULL,
  `mesCaducidad` INT(2) NULL,
  `anioCaducidad` INT(4) NULL,
  `clave` INT(3) NULL,
  PRIMARY KEY (`idTarjeta`),
  INDEX `ID Cliente_idx` (`idCliente` ASC) VISIBLE,
  CONSTRAINT `ID Cliente`
    FOREIGN KEY (`idCliente`)
    REFERENCES `Clientes` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Tabla `ComprasProductos`
-- -----------------------------------------------------
CREATE TABLE `ComprasProductos` (
  `idCompra` INT NOT NULL,
  `idProducto` INT NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`idCompra`, `idProducto`),
  INDEX `ID Producto_idx` (`idProducto` ASC) VISIBLE,
  CONSTRAINT `ID Compra`
    FOREIGN KEY (`idCompra`)
    REFERENCES `Compras` (`idCompra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ID Producto`
    FOREIGN KEY (`idProducto`)
    REFERENCES `Productos` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Tabla `ComprasInconclusas`
-- -----------------------------------------------------
CREATE TABLE `ComprasInconclusas` (
  `idCaso` INT NOT NULL AUTO_INCREMENT,
  `idProducto` INT NOT NULL,
  `idCompra` INT NOT NULL,
  `tipo` ENUM('Cancelacion', 'Devolucion') NOT NULL,
  PRIMARY KEY (`idCaso`),
  INDEX `ID Producto_idx` (`idProducto` ASC) VISIBLE,
  INDEX `ID Compra_idx` (`idCompra` ASC) VISIBLE,
  CONSTRAINT `ID Producto`
    FOREIGN KEY (`idProducto`)
    REFERENCES `Productos` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ID Compra`
    FOREIGN KEY (`idCompra`)
    REFERENCES `Compras` (`idCompra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
