-- -----------------------------------------------------
-- Consultas y Procedimientos
-- ----------------------------------------------------

-- Clientes que más han comprado. --
1.- SELECT nombreCliente FROM Clientes INNER JOIN Compras USING(idCliente) INNER JOIN ComprasProductos USING(idCompra) GROUP BY idCliente HAVING SUM(cantidadProducto) = (SELECT SUM(cantidadProducto) AS Cantidad FROM Clientes INNER JOIN Compras USING(idCliente) INNER JOIN ComprasProductos USING(idCompra) GROUP BY idCliente ORDER BY Cantidad DESC LIMIT 1);
-- Posibilidad de calcular la facturación total de un cliente en particular en un mes en particular. --
2.- SELECT SUM(precio) FROM Clientes LEFT JOIN Compras USING(idCliente) LEFT JOIN ComprasProductos USING (idCompra) LEFT JOIN Productos USING (idProducto) WHERE idCliente = idCliente AND MONTHNAME (fechaCompra) = 'MES';
-- Procedimiento
CREATE DEFINER=`root`@`localhost` PROCEDURE `FacturacionDelMes`(idClienteFacturacion INT, mesFacturacion CHAR(50), OUT facturacion DECIMAL(8, 2))
BEGIN
    DECLARE cursorFacturacion CURSOR FOR
   	 SELECT SUM(precio) FROM Clientes LEFT JOIN Compras USING(idCliente) LEFT JOIN ComprasProductos USING (idCompra) LEFT JOIN Productos USING (idProducto) WHERE idCliente = idClienteFacturacion AND MONTHNAME (fechaCompra) = mesFacturacion;
    OPEN cursorFacturacion;
   	 FETCH cursorFacturacion INTO facturacion;
	CLOSE cursorFacturacion;
END
-- Lista de los clientes que no han comprado ningún producto. --
3.- SELECT nombreCliente FROM Clientes WHERE idCliente NOT IN (SELECT idCliente FROM Clientes INNER JOIN Compras USING(idCliente) INNER JOIN ComprasProductos USING(idCompra) GROUP BY idCliente);
-- Lista de todos los clientes que han comprado productos por más de $1,000.00 pesos. --
4.- SELECT nombreCliente FROM Clientes INNER JOIN Compras USING(idCliente) INNER JOIN ComprasProductos USING(idCompra) INNER JOIN Productos USING(idProducto) GROUP BY idCliente HAVING MAX(precio) > 1000;
-- Lista de cada compra, nombre del cliente, número de productos y descripción de cada uno de los productos. --
5.- SELECT idCompra, nombreCliente, aPaternoCliente, aMaternoCliente, nombre as producto, cantidadProducto, descripcion FROM Clientes RIGHT JOIN Compras USING(idCliente) LEFT JOIN ComprasProductos USING (idCompra) LEFT JOIN Productos USING (idProducto);
-- Lista de asesores que han resuelto los problemas satisfactoriamente. --
6.- SELECT idAsesor, nombreAsesor, aPaternoAsesor, aMaternoAsesor FROM HistorialAtencion LEFT JOIN Asesores USING(idAsesor) WHERE estado = 'Cerrado' GROUP BY idAsesor;
-- Lista de asesores que tienen todavía casos abiertos. --
7.- SELECT idAsesor, nombreAsesor, aPaternoAsesor, aMaternoAsesor FROM HistorialAtencion LEFT JOIN Asesores USING(idAsesor) WHERE estado = 'Abierto' GROUP BY idAsesor;
/* Lista de todos los productos de una categoría en particular, mostrando su nombre, descripción y comentarios
(en su caso) de clientes que hayan opinado acerca de dicho producto */
8.- SELECT nombre, descripcion, COUNT(idOpinion) AS Cuantos_Comentarios FROM CategoriaProductos RIGHT JOIN Productos USING(idCategoriaProducto) LEFT JOIN Opiniones USING(idProducto) WHERE nombreCategoriaProducto = categoria GROUP BY idProducto;
--Procedimiento:
CREATE DEFINER=`root`@`localhost` PROCEDURE `ProductosEnCategoria`(categoria CHAR(50))
BEGIN
    SELECT nombre, descripcion, COUNT(idOpinion) AS Cuantos_Comentarios FROM CategoriaProductos RIGHT JOIN Productos USING(idCategoriaProducto) LEFT JOIN Opiniones USING(idProducto) WHERE nombreCategoriaProducto = categoria GROUP BY idProducto;
END
-- Cuántas cancelaciones y devoluciones se han hecho y cuál es el producto más devuelto. --
9.- SELECT idProducto, nombre AS Producto, precio, SUM(cantidadDC) AS 'Veces cancelado/devuelto' FROM Productos RIGHT JOIN DevolucionesCancelaciones USING (idProducto) WHERE idProducto = (SELECT idProducto FROM Productos RIGHT JOIN DevolucionesCancelaciones USING (idProducto) GROUP BY idProducto ORDER BY SUM(cantidadDC) DESC LIMIT 1);
-- Lista de los clientes con su información completa para poder hacer una entrega. --
10.- SELECT idCompra, nombre AS nombreProducto, cantidadProducto, nombreCliente, aPaternoCliente,aMaternoCliente, direccionEnvio FROM Clientes INNER JOIN Compras USING(idCliente) INNER JOIN ComprasProductos USING(idCompra) INNER JOIN Productos USING(idProducto);
/* Realizar un procedimiento que reciba el id del producto, y la cantidad de productos a comprar y
que nos regrese el monto total de la venta, así como el monto que se debe pagar por envío, con
base en el número de productos que se van a comprar, considerando también la categoría del
cliente para el caso en donde no se cobra el envío de los productos comprados.*/
11.- CREATE DEFINER=`root`@`localhost` PROCEDURE `Monto_Total_y_Envio`(cliente INT, producto INT, numProductos INT, OUT montoTotal DECIMAL(10,2),OUT montoEnvio DECIMAL(10,2))
BEGIN
 DECLARE costoProducto DECIMAL(10,2);
 DECLARE categoriaCliente VARCHAR(50);
 DECLARE curPrecioProducto CURSOR FOR
  SELECT precio FROM Productos WHERE idProducto = producto;
DECLARE curCategoriaCliente CURSOR FOR
  SELECT nombreCategoriaCliente, porcentajeEnvio FROM Clientes LEFT JOIN CategoriaClientes USING(idCategoriaCliente) WHERE idCliente = cliente;
DECLARE EXIT HANDLER FOR NOT FOUND SET montoTotal = 0; SET montoEnvio = 0;
OPEN curPrecioProducto;
  FETCH curPrecioProducto INTO costoProducto;
CLOSE curPrecioProducto;

OPEN curCategoriaCliente;
  FETCH curCategoriaCliente INTO categoriaCliente, montoEnvio;
CLOSE curCategoriaCliente;
SET montoTotal = costoProducto * numProductos;
SET montoEnvio = montoTotal * montoEnvio;

END
