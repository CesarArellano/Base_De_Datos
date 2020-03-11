#include <stdio.h>
#include <stdlib.h>
#include <mysql/mysql.h>

extern MYSQL Conectar(MYSQL mysql);
extern void Desconectar(MYSQL mysql); 
extern MYSQL Insertar_Asesores(MYSQL mysql);
extern MYSQL Actualizar_Asesores(MYSQL mysql);
extern MYSQL Borrar_Asesores(MYSQL mysql);
extern MYSQL Ver_Asesores(MYSQL mysql);

int main(int argc, char *argv[])
{
	int Opcion = 0, Opcion2 = 0;
	MYSQL mysql;
	do
	{
		system("clear");
		printf("Menú principal:\n");
		printf("\t1.- Asesores.\n"); // César
		printf("\t2.- Clientes.\n");  // Raúl
		printf("\t3.- Compras.\n"); // César
		printf("\t4.- Devoluciones y cancelaciones.\n"); // César
		printf("\t5.- Atención a clientes.\n"); // César
		printf("\t6.- Productos.\n"); // Raúl
		printf("\t7.- Salir del programa.\n");
		printf("Escoja una opción\n");
		scanf(" %d",&Opcion);		

		if (Opcion == 1)
		{
			do
			{
				system("clear");
				mysql = Conectar(mysql);
				printf("Menú Asesores:\n");
				printf("1.- Registrar asesor.\n");
				printf("2.- Actualizar información del asesor.\n");
				printf("3.- Borrar un asesor.\n");
				printf("4.- Lista de todos los asesores.\n");
				printf("5.- Lista de asesores que han resuelto problemas.\n");
				printf("6.- Lista de asesores con casos abiertos.\n");
				printf("7.- Regresar al menú principal\n");
				printf("Escoja una opción\n");
				scanf(" %d",&Opcion2);
				system("clear");
				if (Opcion2 == 1)
					Insertar_Asesores(mysql);
				if (Opcion2 == 2)					
					Actualizar_Asesores(mysql);
				if (Opcion2 == 3)	
					Borrar_Asesores(mysql);
				if (Opcion2 == 4)
					Ver_Asesores(mysql);

				Desconectar(mysql);
			}while(Opcion2 != 7);				
		}
	}while(Opcion !=7);
	
}	