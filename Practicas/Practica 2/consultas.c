#include <stdio.h>
#include <stdlib.h>
#include <mysql/mysql.h>

MYSQL Asesores_Casos_Resueltos(MYSQL mysql);
MYSQL Asesores_Casos_Abiertos(MYSQL mysql);
MYSQL Historiales_Clientes(MYSQL mysql);

MYSQL Asesores_Casos_Resueltos(MYSQL mysql)
{
	int i;
	char *buffer = "SELECT idAsesor, nombreAsesor, aPaternoAsesor, aMaternoAsesor FROM HistorialAtencion LEFT JOIN Asesores USING(idAsesor) WHERE estado = 'Cerrado' GROUP BY idAsesor";
	MYSQL_RES *res;
	MYSQL_ROW row;	

	if(mysql_query(&mysql,buffer))
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
	// Desplegamos el resultset
	while((row = mysql_fetch_row(res)))
	{
		for(i=0;i<mysql_num_fields(res);i++)
		{
			if(row[i] != NULL)
				printf("%s, ",row[i]);
			else
				printf("---");
		}
		printf("\n");
	}
	mysql_free_result(res);
	printf("Presione enter para continuar...");
	__fpurge(stdin);
	getchar();
	return mysql;
}
MYSQL Asesores_Casos_Abiertos(MYSQL mysql)
{
	int i;
	char *buffer = "SELECT idAsesor, nombreAsesor, aPaternoAsesor, aMaternoAsesor FROM HistorialAtencion LEFT JOIN Asesores USING(idAsesor) WHERE estado = 'Abierto' GROUP BY idAsesor";
	MYSQL_RES *res;
	MYSQL_ROW row;	

	if(mysql_query(&mysql,buffer))
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
	// Desplegamos el resultset
	while((row = mysql_fetch_row(res)))
	{
		for(i=0;i<mysql_num_fields(res);i++)
		{
			if(row[i] != NULL)
				printf("%s, ",row[i]);
			else
				printf("---");
		}
		printf("\n");
	}
	mysql_free_result(res);
	printf("Presione enter para continuar...");
	__fpurge(stdin);
	getchar();
	return mysql;
}

MYSQL Historiales_Clientes(MYSQL mysql)
{
	int i, IDTemp;
	char buffer[1024];
	MYSQL_RES *res;
	MYSQL_ROW row;	

	printf("Ingrese el id del cliente\n");
	scanf (" %d",&IDTemp);
	sprintf(buffer,"SELECT * FROM HistorialAtencion WHERE idCliente = %d",IDTemp);
	
	if(mysql_query(&mysql,buffer))
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
	// Desplegamos el resultset
	while((row = mysql_fetch_row(res)))
	{
		for(i=0;i<mysql_num_fields(res);i++)
		{
			if(row[i] != NULL)
				printf("%s, ",row[i]);
			else
				printf("---");
		}
		printf("\n");
	}
	mysql_free_result(res);
	printf("Presione enter para continuar...");
	__fpurge(stdin);
	getchar();
	return mysql;
}