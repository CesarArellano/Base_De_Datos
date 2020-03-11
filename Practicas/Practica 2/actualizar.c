#include <stdio.h>
#include <stdlib.h>
#include <mysql/mysql.h>

MYSQL Actualizar_Asesores(MYSQL mysql);

MYSQL Actualizar_Asesores(MYSQL mysql)
{
	int IDTemp;
	char Letra, buffer[1024];
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
	printf("Ingrese una letra para continuar...\n");
	scanf(" %c",&Letra);
	return mysql;
}