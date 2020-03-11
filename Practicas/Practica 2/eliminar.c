#include <stdio.h>
#include <stdlib.h>
#include <mysql/mysql.h>

MYSQL Borrar_Asesores(MYSQL mysql);

MYSQL Borrar_Asesores(MYSQL mysql)
{
	int IDTemp;
	char Letra, buffer[1024];
	printf("Ingrese el id del asesor a borrar\n");
	scanf (" %d",&IDTemp);

	sprintf(buffer,"DELETE FROM Asesores WHERE idAsesor = %d",IDTemp);

	if(mysql_query(&mysql,buffer))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
		exit(1);
	}
	printf("Se eliminó correctamente el asesor\n");
	printf("Ingrese una letra para continuar...\n");
	scanf(" %c",&Letra);
	return mysql;
}