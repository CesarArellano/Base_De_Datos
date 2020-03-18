#include <stdio.h>
#include <stdlib.h>
#include <time.h> //Declaramos time.h para poder obtener la hora del sistema.
#include <mysql/mysql.h>

MYSQL Insertar_Asesores(MYSQL mysql);
MYSQL Insertar_Compras(MYSQL mysql);
MYSQL Insertar_Casos(MYSQL mysql);
MYSQL Insertar_Clientes(MYSQL mysql);
MYSQL Insertar_Productos(MYSQL mysql);
void Timestamp(char Timestamp[]);

void Timestamp(char Timestamp[]) //Esta función obtiene la fecha y hora actual y las guarda en una cadena de salida
{
  time_t rawtime;
  struct tm *timeinfo;
  time(&rawtime);
  timeinfo = localtime(&rawtime);
  strftime(Timestamp,200, "%Y%m%d-%H:%M:%S", timeinfo);
}

MYSQL Insertar_Asesores(MYSQL mysql)
{
	char buffer[1024];
	char NombreTemp [45], APaternoTemp[45],AMaternoTemp[45];
	printf("Ingresa nombre(s) del asesor\n");
	scanf (" %[^\n]",NombreTemp);
	printf("Ingresa el apellido paterno del asesor\n");
	scanf (" %[^\n]",APaternoTemp);
	printf("Ingresa el apellido materno del asesor\n");
	scanf (" %[^\n]",AMaternoTemp);

	sprintf(buffer,"INSERT INTO Asesores(nombreAsesor,aPaternoAsesor,aMaternoAsesor) VALUES  ('%s','%s','%s')",NombreTemp,APaternoTemp,AMaternoTemp);

	if(mysql_query(&mysql,buffer))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
		exit(1);
	}
	printf("Se agregó correctamente el asesor\n");
	printf("Presione enter para continuar...");
	__fpurge(stdin);
	getchar();
	return mysql;
}

MYSQL Insertar_Compras(MYSQL mysql)
{
	MYSQL_RES *res;
	MYSQL_ROW row;
	int IDTemp,Opcion,ProductosBD,SolicitudProductos;
	char buffer[1024], *CuantosProductos;
	char HoraSistemaTemp[100], *PagoTemp;
	printf("Ingresa el ID del cliente\n");
	scanf (" %d",&IDTemp);
	CuantosProductos = "SELECT COUNT(idProducto) FROM Productos";
	
	//Ejecuta el query.
	if(mysql_query(&mysql,CuantosProductos))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
		exit(1);
	}
	// Obtenemos el result set.
	if(!(res = mysql_store_result(&mysql)))
	{
		printf("Error al obtener el query: %s\n", mysql_error(&mysql));
		exit(1);
	}

	row = mysql_fetch_row(res);
	ProductosBD = atoi(row[0]);
	printf("¿Cuántos productos quiere comprar?\n");
	scanf(" %d",&SolicitudProductos);
	if(SolicitudProductos <= ProductosBD)
	{
		printf("Muy bien\n");
	}
	else
	{
		printf("Error, no existen los productos ");
	}
	do
	{
		printf("Forma de pago:\n");
		printf("\t1.- Tarjeta de cŕedito.\n");
		printf("\t2.- Depósito bancario.\n");
		printf("\t3.- Transferencia electrónica.\n");
		printf("\t4.- Pago en tienda de conveniencia.\n");
		printf("Escoge una opción.\n");
		scanf(" %d",&Opcion);
		if (Opcion == 1)
			PagoTemp = "Tarjeta de cŕedito";
		if (Opcion == 2)
			PagoTemp = "Depósito bancario";
		if (Opcion == 3)
			PagoTemp = "Transferencia electrónica";
		if (Opcion == 4)
			PagoTemp = "Pago en tienda de conveniencia";
		else
		{
			printf("Opción incorrecta\n");
			Opcion = 0;
		}

	}while(Opcion == 0);

	Timestamp(HoraSistemaTemp);
	sprintf(buffer,"INSERT INTO Compras(idCliente,formaPago,fechaCompra) VALUES  ('%d','%s','%s')",IDTemp,PagoTemp,HoraSistemaTemp);

	if(mysql_query(&mysql,buffer))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
		exit(1);
	}

	printf("Se realizó con éxito la compra, gracias por su preferencia.\n");
	printf("Presione enter para continuar...");
	__fpurge(stdin);
	getchar();
	return mysql;
}

MYSQL Insertar_Casos(MYSQL mysql)
{
	int IDCliente, IDProductoTemp, IDCompraTemp, CantidadDCTemp,Opcion; 
	char buffer[1024], *TipoCasoTemp;
	printf("Ingresa el ID de la compra\n");
	scanf (" %d",&IDCompraTemp);
	printf("Ingresa el ID del producto a devolver o cancelar\n");
	scanf (" %d",&IDProductoTemp);
	do
	{
		system("clear");
		printf("¿Qué quiere hacer?\n");
		printf("1.- Devolución del producto\n");
		printf("2.- Cancelación del producto\n");
		printf("Escoja una opción\n");
		scanf(" %d",&Opcion);
		if(Opcion == 1)
			TipoCasoTemp = "Devolución";
		else if(Opcion == 2)
			TipoCasoTemp = "Cancelación";
		else
		{
			printf("Opción incorrecta, intente de nuevo...");
			Opcion = 0;
		}
		printf("Presione enter para continuar...");
		__fpurge(stdin);
		getchar();
	}while(Opcion == 0);
	printf("Ingrese la cantidad de productos para proceder con la %s\n",TipoCasoTemp);
	scanf(" %d",&CantidadDCTemp);

	sprintf(buffer,"INSERT INTO DevolucionesCancelaciones(idProducto,idCompra,tipo,cantidadDC) VALUES  (%d,%d,'%s',%d)",IDProductoTemp,IDCompraTemp,TipoCasoTemp,CantidadDCTemp);

	if(mysql_query(&mysql,buffer))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
		exit(1);
	}
	printf("Se agregó correctamente el asesor\n");
	printf("Presione enter para continuar...");
	__fpurge(stdin);
	getchar();
	return mysql;
}

MYSQL Insertar_Clientes(MYSQL mysql)
{
	char buffer[1024];
	char NombreTemp [45], APaternoTemp[45],AMaternoTemp[45], UsuarioTemp[45], PasswordTemp[45], RFCTemp[13],DireccionEnvioTemp[150],DireccionFacturacionTemp[150];
	printf("Ingresa nombre(s) del cliente\n");
	scanf (" %[^\n]",NombreTemp);
	printf("Ingresa el apellido paterno del cliente\n");
	scanf (" %[^\n]",APaternoTemp);
	printf("Ingresa el apellido materno del cliente\n");
	scanf (" %[^\n]",AMaternoTemp);
	printf("Ingresa tu usuario\n");
	scanf (" %[^\n]",UsuarioTemp);
	printf("Ingresa tu contraseña\n");
	scanf (" %[^\n]",PasswordTemp);
	printf("Ingresa tu RFC\n");
	scanf (" %[^\n]",RFCTemp);
	printf("Ingresa tu dirección de envío\n");
	scanf (" %[^\n]",DireccionEnvioTemp);
	printf("Ingresa tu dirección de facturación\n");
	scanf (" %[^\n]",DireccionFacturacionTemp);

	sprintf(buffer,"INSERT INTO Clientes(idCategoriaCliente,usuario,password,nombreCliente,aPaternoCliente,aMaternoCliente,rfc,direccionEnvio,direccionFacturacion) VALUES  (1,'%s','%s','%s','%s','%s','%s','%s','%s')",UsuarioTemp,PasswordTemp,NombreTemp,APaternoTemp,AMaternoTemp,RFCTemp,DireccionEnvioTemp,DireccionFacturacionTemp);

	if(mysql_query(&mysql,buffer))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
		exit(1);
	}
	system("clear");
	printf("¡Felicidades te registraste con éxito!\n");
	printf("Por ser cliente nuevo su categoria actual es 'Novato'\n");
	printf("Presione enter para continuar...");
	__fpurge(stdin);
	getchar();
	return mysql;
}

MYSQL Insertar_Productos(MYSQL mysql)
{
	int IDDepartamentoTemp, IDCategoriaProductoTemp, StockTemp;
	double PrecioTemp;
	char buffer[1500], NombreTemp [45], MarcaTemp[45],DescripcionTemp[1000];
	
	printf("Ingresa ID del departamento para el nuevo producto\n");
	scanf (" %d",&IDDepartamentoTemp);
	printf("Ingresa ID de la categoria para el nuevo producto\n");
	scanf (" %d",&IDCategoriaProductoTemp);
	printf("Ingresa nombre del producto\n");
	scanf (" %[^\n]",NombreTemp);
	printf("Ingresa marca del producto\n");
	scanf (" %[^\n]",MarcaTemp);
	printf("Ingresa la descripción del producto\n");
	scanf (" %[^\n]",DescripcionTemp);
	printf("Ingresa precio del producto\n");
	scanf (" %lf",&PrecioTemp);
	printf("Ingresa stock del producto\n");
	scanf (" %d",&StockTemp);

	sprintf(buffer,"INSERT INTO Productos(idDepartamento,idCategoriaProducto,nombre,marca,descripcion,precio,stock) VALUES  (%d,%d,'%s','%s','%s',%lf,%d)",IDDepartamentoTemp,IDCategoriaProductoTemp,NombreTemp,MarcaTemp,DescripcionTemp,PrecioTemp,StockTemp);

	if(mysql_query(&mysql,buffer))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
		exit(1);
	}
	system("clear");
	printf("Se registró correctamente el nuevo producto\n");
	printf("Presione enter para continuar...");
	__fpurge(stdin);
	getchar();
	return mysql;
}