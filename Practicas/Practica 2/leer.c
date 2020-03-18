#include <stdio.h>
#include <stdlib.h>
#include <mysql/mysql.h>

MYSQL Ver_Asesores(MYSQL mysql);
MYSQL Ver_Historiales(MYSQL mysql);

MYSQL Ver_Asesores(MYSQL mysql)
{
	int i;
	char *buffer = "SELECT * FROM Asesores";
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

MYSQL Ver_Historiales(MYSQL mysql)
{
	int i;
	char *buffer = "SELECT * FROM HistorialAtencion";
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