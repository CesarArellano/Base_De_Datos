#include <stdio.h>
#include <stdlib.h>
#include <time.h> //Declaramos time.h para poder obtener la hora del sistema.
#include <mysql/mysql.h>

MYSQL Insertar_Asesores(MYSQL mysql);
MYSQL Insertar_Compras(MYSQL mysql);
MYSQL Insertar_Casos(MYSQL mysql);
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
	printf("Ingresa el nombre del asesor\n");
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