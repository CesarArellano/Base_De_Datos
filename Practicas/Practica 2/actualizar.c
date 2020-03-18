#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql/mysql.h>

MYSQL Actualizar_Asesores(MYSQL mysql);
MYSQL Actualizar_Historiales(MYSQL mysql);

MYSQL Actualizar_Asesores(MYSQL mysql)
{
	int IDTemp;
	char buffer[1024];
	char NombreTemp [45], APaternoTemp[45],AMaternoTemp[45];
	printf("Ingrese el id del asesor\n");
	scanf (" %d",&IDTemp);
	printf("Ingresa el nuevo nombre del asesor\n");
	scanf (" %[^\n]",NombreTemp);
	printf("Ingresa el nuevo apellido paterno del asesor\n");
	scanf (" %[^\n]",APaternoTemp);
	printf("Ingresa el nuevo apellido materno del asesor\n");
	scanf (" %[^\n]",AMaternoTemp);

	sprintf(buffer,"UPDATE Asesores SET nombreAsesor = '%s', aPaternoAsesor = '%s',  aMaternoAsesor = '%s' WHERE idAsesor = %d",NombreTemp,APaternoTemp,AMaternoTemp,IDTemp);

	if(mysql_query(&mysql,buffer))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
		exit(1);
	}
	printf("Se actualizó correctamente el asesor\n");
	printf("Presione enter para continuar...");
	__fpurge(stdin);
	getchar();
	return mysql;
}

MYSQL Actualizar_Historiales(MYSQL mysql)
{
	MYSQL_RES *res;
	MYSQL_ROW row;	 
	int IDTemp;
	char buffer[1024], *EstadoTemp;
	printf("Ingrese el id del historial\n");
	scanf (" %d",&IDTemp);
	sprintf(buffer,"SELECT estado FROM HistorialAtencion WHERE idAtencion = %d",IDTemp);
	//Ejecuta el query.
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
	row = mysql_fetch_row(res);
	if(row == NULL)
		printf("Error, no existe historial de atención\n");
	else
	{
		if(strcmp(row[0],"Abierto") == 0)
			EstadoTemp = "Cerrado";
		else
			EstadoTemp = "Abierto";

		sprintf(buffer,"UPDATE HistorialAtencion SET estado = '%s' WHERE idAtencion = %d",EstadoTemp, IDTemp);

		if(mysql_query(&mysql,buffer))
		{
			printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
			exit(1);
		}
		printf("El estado del historial se cambió con éxito\n");
	}

	mysql_free_result(res);

	printf("Presione enter para continuar...");
	__fpurge(stdin);
	getchar();
	return mysql;
}