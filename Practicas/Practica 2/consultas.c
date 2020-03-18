#include <stdio.h>
#include <stdlib.h>
#include <mysql/mysql.h>

MYSQL Asesores_Casos_Resueltos(MYSQL mysql);
MYSQL Asesores_Casos_Abiertos(MYSQL mysql);
MYSQL Historiales_Clientes(MYSQL mysql);
MYSQL Productos_Categoria(MYSQL mysql);
MYSQL Ejecutar_Query_Consultas(MYSQL mysql, char buffer[]);

MYSQL Ejecutar_Query_Consultas(MYSQL mysql, char buffer[])
{
	int i;
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
		printf("\n\n");
	}
	mysql_free_result(res);
	printf("Presione enter para continuar...");
	__fpurge(stdin);
	getchar();
}

MYSQL Asesores_Casos_Resueltos(MYSQL mysql)
{
	char *buffer = "SELECT idAsesor, nombreAsesor, aPaternoAsesor, aMaternoAsesor FROM HistorialAtencion LEFT JOIN Asesores USING(idAsesor) WHERE estado = 'Cerrado' GROUP BY idAsesor";
	mysql = Ejecutar_Query_Consultas(mysql,buffer);
	return mysql;
}
MYSQL Asesores_Casos_Abiertos(MYSQL mysql)
{
	char *buffer = "SELECT idAsesor, nombreAsesor, aPaternoAsesor, aMaternoAsesor FROM HistorialAtencion LEFT JOIN Asesores USING(idAsesor) WHERE estado = 'Abierto' GROUP BY idAsesor";
	mysql = Ejecutar_Query_Consultas(mysql,buffer);
	return mysql;
}

MYSQL Historiales_Clientes(MYSQL mysql)
{
	int IDTemp;
	char buffer[1024];
	printf("Ingrese el id del cliente\n");
	scanf (" %d",&IDTemp);
	sprintf(buffer,"SELECT * FROM HistorialAtencion WHERE idCliente = %d",IDTemp);

	mysql = Ejecutar_Query_Consultas(mysql,buffer);
	return mysql;
}

MYSQL Productos_Categoria(MYSQL mysql)
{
	char buffer[1024], NombreCategoriaTemp[45];
	printf("Ingrese el nombre de la categoria del producto\n");
	scanf (" %[^\n]",NombreCategoriaTemp);
	sprintf(buffer,"SELECT nombre, descripcion, COUNT(idOpinion) AS Cuantos_Comentarios FROM CategoriaProductos RIGHT JOIN Productos USING(idCategoriaProducto) LEFT JOIN Opiniones USING(idProducto) WHERE nombreCategoriaProducto = '%s' GROUP BY idProducto",NombreCategoriaTemp);
	mysql = Ejecutar_Query_Consultas(mysql,buffer);
	return mysql;
}
