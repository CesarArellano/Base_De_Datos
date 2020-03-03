#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql/mysql.h>

int main(int argc, char *argv[])
{
	int i = 0;
	char *server = "localhost";
	char *user = "root";
	char *password = "admin";
	char *db = "ic19cav";
	char anio[10], query[100];
	MYSQL mysql;
	MYSQL_RES *res;
	MYSQL_ROW row;

	printf("Escriba el año de nacimiento\n");
	scanf (" %[^\n]",anio);
	mysql_init(&mysql);

	// Se conecta al servidor.
	if(!mysql_real_connect(&mysql,server,user,password,db,0,NULL,0))
	{
		printf("Error al conectarse: %s\n", mysql_error(&mysql));
		exit(1);
	}
	// Se conecta a la base de datos.
	if(mysql_select_db(&mysql,db))
	{
		printf("Error al selecionar la base de datos: %s\n", mysql_error(&mysql));
		exit(1);
	}
	/*strcpy(query,"SELECT * FROM presidentes WHERE YEAR(nacimiento) = ");
	strcat(query,anio); */
	sprintf(query,"SELECT * FROM presidentes WHERE YEAR(nacimiento) = '%s'",anio);
	if(mysql_query(&mysql,query))
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
	mysql_close(&mysql);
}	