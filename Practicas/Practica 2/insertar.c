#include <stdio.h>
#include <stdlib.h>
#include <mysql/mysql.h>

MYSQL Insertar_Asesores(MYSQL mysql);

MYSQL Insertar_Asesores(MYSQL mysql)
{
	char Letra, buffer[1024];
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
	printf("Ingrese una letra para continuar...\n");
	scanf(" %c",&Letra);
	return mysql;
}