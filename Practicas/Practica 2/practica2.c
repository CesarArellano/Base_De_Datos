#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql/mysql.h>

extern MYSQL Conectar(MYSQL mysql);
extern void Desconectar(MYSQL mysql); 
extern MYSQL Insertar_Asesores(MYSQL mysql);
extern MYSQL Actualizar_Asesores(MYSQL mysql);
extern MYSQL Borrar_Asesores(MYSQL mysql);
extern MYSQL Ver_Asesores(MYSQL mysql);
extern MYSQL Asesores_Casos_Resueltos(MYSQL mysql);
extern MYSQL Asesores_Casos_Abiertos(MYSQL mysql);
extern MYSQL Insertar_Compras(MYSQL mysql, int idCliente);
extern MYSQL Insertar_Casos(MYSQL mysql);
extern MYSQL Insertar_Clientes(MYSQL mysql);
extern MYSQL Actualizar_Historiales(MYSQL mysql);
extern MYSQL Borrar_Historiales(MYSQL mysql);
extern MYSQL Ver_Historiales(MYSQL mysql);
extern MYSQL Historiales_Clientes(MYSQL mysql);
int Iniciar_Sesion(int TipoUsuario, int *IDUsuario, char NombreUsuario[50]);
void Menu_Admin(int IDUsuario, char NombreUsuario[50]);
void Menu_Cliente(int IDUsuario, char NombreUsuario[50]);

int main(int argc, char *argv[])
{
	MYSQL mysql;
	int Opcion = 0;
	int IDUsuario;
	char NombreUsuario[50];
	do
	{
		system("clear");
		printf("Menú principal\n");
		printf("\t1.- Administrador.\n");
		printf("\t2.- Cliente.\n");
		printf("\t3.- Registarme (cliente)\n");
		printf("\t4.- Salir del sistema\n");
		printf("Escoja su tipo de usuario\n");
		scanf(" %d",&Opcion);
		system("clear");
		if (Opcion == 1)
		{
			if(Iniciar_Sesion(Opcion,&IDUsuario,NombreUsuario))
				Menu_Admin(IDUsuario,NombreUsuario);
		}
		else if (Opcion == 2)
		{
			if(Iniciar_Sesion(Opcion,&IDUsuario,NombreUsuario))
				Menu_Cliente(IDUsuario,NombreUsuario);
		}
		else if (Opcion == 3)
		{
			mysql = Conectar(mysql);
			Insertar_Clientes(mysql);
			Desconectar(mysql);
		}
		else if (Opcion == 4)
			printf("Saliendo del sistema...\n");
		else
		{
			printf("Opción incorrecta, intente de nuevo...\n");
			printf("Presione enter para continuar...");
			__fpurge(stdin);
		  	getchar();
		}

	}while(Opcion != 4);	
}

int Iniciar_Sesion(int TipoUsuario, int *IDUsuario, char NombreUsuario[50])
{
	MYSQL mysql;
	MYSQL_RES *res;
	MYSQL_ROW row;
	char Usuario[50], Password[50], buffer[1024];
	int i,Flag = 0;

	printf("Ingresa tu usuario:\n");
	scanf (" %[^\n]",Usuario);
	printf("Ingresa tu contraseña:\n");
	scanf (" %[^\n]",Password);

	mysql = Conectar(mysql);

	if(TipoUsuario == 1)
		sprintf(buffer,"SELECT idAdministrador, nombreAdministrador FROM Administradores WHERE usuario = '%s' AND password = '%s'",Usuario,Password);
	else
		sprintf(buffer,"SELECT idCliente, nombreCliente FROM Clientes WHERE usuario = '%s' AND password = '%s'",Usuario,Password);

	if(mysql_query(&mysql,buffer))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
		Desconectar(mysql);
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
	{	
		Flag = 0;
		printf("Error, usuario y/o contraseña incorrecto(s)\n");
	}
	else
	{
		*IDUsuario = atoi(row[0]);
		strcpy(NombreUsuario, row[1]);
		Flag = 1;
		printf("Inicio de sesión éxitoso\n");
	}

	mysql_free_result(res);
	Desconectar(mysql);
	printf("Presione enter para continuar...");
	__fpurge(stdin);
	getchar();
	return Flag;
}


void Menu_Admin(int IDUsuario, char NombreUsuario[50])
{
	MYSQL mysql;
	int Opcion = 0, Opcion2 = 0;
	do
	{
		system("clear");
		printf("Bienvenido %s\n",NombreUsuario);
		printf("Menú Administradores:\n");
		printf("\t1.- Asesores.\n"); // César
		printf("\t2.- Clientes.\n");  // Raúl
		printf("\t3.- Compras.\n"); // César
		printf("\t4.- Devoluciones y cancelaciones.\n"); // César
		printf("\t5.- Atención a clientes.\n"); // César
		printf("\t6.- Productos.\n"); // Raúl
		printf("\t7.- Regresar al menú principal.\n");
		printf("Escoja una opción\n");
		scanf(" %d",&Opcion);		

		if (Opcion == 1)
		{
			do
			{
				system("clear");
				mysql = Conectar(mysql);
				printf("Menú Asesores:\n");
				printf("\t1.- Registrar asesor.\n");
				printf("\t2.- Actualizar información del asesor.\n");
				printf("\t3.- Borrar un asesor.\n");
				printf("\t4.- Lista de todos los asesores.\n");
				printf("\t5.- Lista de asesores que han resuelto problemas.\n");
				printf("\t6.- Lista de asesores con casos abiertos.\n");
				printf("\t7.- Regresar al menú administradores.\n");
				printf("Escoja una opción\n");
				scanf(" %d",&Opcion2);
				system("clear");
				if (Opcion2 == 1)
					Insertar_Asesores(mysql);
				else if (Opcion2 == 2)					
					Actualizar_Asesores(mysql);
				else if (Opcion2 == 3)	
					Borrar_Asesores(mysql);
				else if (Opcion2 == 4)
					Ver_Asesores(mysql);
				else if (Opcion2 == 5)
					Asesores_Casos_Resueltos(mysql);
				else if (Opcion2 == 6)
					Asesores_Casos_Abiertos(mysql);
				else if (Opcion2 == 7)
					printf("...\n");
				else
				{
					printf("Opción incorrecta, intente de nuevo...\n");
					printf("Presione enter para continuar...");
					__fpurge(stdin);
					getchar();
				}				
				Desconectar(mysql);
			}while(Opcion2 != 7);				
		}
		/*
		else if (Opcion == 2)
		{
			do
			{
				system("clear");
				mysql = Conectar(mysql);
				printf("Menú Clientes:\n");
				printf("\t1.- Registrar cliente.\n");
				printf("\t1.- Actualizar información del cliente.\n");
				printf("\t3.- Borrar un cliente.\n");
				printf("\t4.- Lista de todos los clientes.\n");
				printf("\t5.- Lista de clientes que más han comprado.\n");
				printf("\t6.- Calcular facturación total de un cliente en particular.\n");
				printf("\t7.- Lista de clientes que no han comprado ningún producto.\n");
				printf("\t8.- Lista de todos los clientes que han comprado productos por más de una cantidad específica.\n");
				printf("\t9.- Lista de los clientes con su información completa para poder hacer una entrega.\n");
				printf("\t10.- Regresar al menú administradores\n");
				printf("Escoja una opción\n");
				scanf(" %d",&Opcion2);
				system("clear");
				if (Opcion2 == 1)
					Insertar_Clientes(mysql);
				else if (Opcion2 == 2)					
					Actualizar_Clientes(mysql);
				else if (Opcion2 == 3)	
					Borrar_Clientes(mysql);
				else if (Opcion2 == 4)
					Ver_Asesores(mysql);
				else if (Opcion2 == 5)
					Clientes_Mas_Compras(mysql);
				else if (Opcion2 == 6)
					Clientes_Facturacion(mysql);
				else if (Opcion2 == 7)
					Clientes_Ningun_Producto(mysql);
				else if (Opcion2 == 8)
					Clientes_Cantidad(mysql);
				else if (Opcion2 == 9)
					Clientes_Entrega(mysql);
				else if (Opcion2 == 10)
					printf("...\n");
				else
				{
					printf("Opción incorrecta, intente de nuevo...\n");
					printf("Presione enter para continuar...");
					__fpurge(stdin);
					getchar();
				}				
				Desconectar(mysql);
			}while(Opcion2 != 10);			
		}
		else if (Opcion == 3)
		{
			do
			{
				system("clear");
				mysql = Conectar(mysql);
				printf("Menú Compras:\n");
				printf("\t1.- Borrar una compra.\n");
				printf("\t2.- Lista de todas las compras.\n");
				printf("\t3.- Lista de cada compra, nombre del cliente, número de productos y descripción de cada uno de los productos.\n");
				printf("\t4.- Estimar monto final y de envío de un producto.\n");
				printf("\t5.- Regresar al menú administradores\n");
				printf("Escoja una opción\n");
				scanf(" %d",&Opcion2);
				system("clear");
				if (Opcion2 == 1)
					Borrar_Compras(mysql);
				else if (Opcion2 == 2)
					Ver_Compras(mysql);					
				else if (Opcion2 == 3)
					Ver_Compras_Productos(mysql);
				else if (Opcion2 == 4)
					Ver_Monto(mysql);
				else if (Opcion2 == 5)
					printf("...\n");
				else
				{
					printf("Opción incorrecta, intente de nuevo...\n");
					printf("Presione enter para continuar...");
					__fpurge(stdin);
					getchar();
				}			
				Desconectar(mysql);
			}while(Opcion2 != 5);
		}
		else if (Opcion == 4)
		{
			do
			{
				system("clear");
				mysql = Conectar(mysql);
				printf("Menú Devoluciones y cancelaciones.:\n");
				printf("\t1.- Borrar una devolución o cancelación.\n");
				printf("\t2.- Lista de todas las devoluciones o cancelaciones.\n");
				printf("\t3.- Cuántas cancelaciones y devoluciones se han hecho y cuál es el producto más devuelto.\n");
				printf("\t4.- Regresar al menú administradores\n");
				printf("Escoja una opción\n");
				scanf(" %d",&Opcion2);
				system("clear");
				if (Opcion2 == 1)
					Borrar_Casos(mysql);
				else if (Opcion2 == 2)	
					Ver_Casos(mysql);
				else if (Opcion2 == 3)
					Casos_Producto_Mas_Devuelto(mysql);
				else if (Opcion2 == 4)
					printf("...\n");
				else
				{
					printf("Opción incorrecta, intente de nuevo...\n");
					printf("Presione enter para continuar...");
					__fpurge(stdin);
					getchar();
				}				
				
				Desconectar(mysql);
			}while(Opcion2 != 4);
		}
		*/
		else if (Opcion == 5)
		{
			do
			{
				system("clear");
				mysql = Conectar(mysql);
				printf("Menú Atención a clientes:\n");
				printf("\t1.- Cambiar status de un historial.\n");
				printf("\t2.- Borrar un historial de atención.\n");
				printf("\t3.- Ver todos los historiales de atención.\n");
				printf("\t4.- Ver historial(es) de atención de un cliente en particular.\n");
				printf("\t5.- Regresar al menú administradores\n");
				printf("Escoja una opción\n");
				scanf(" %d",&Opcion2);
				system("clear");
				if (Opcion2 == 1)
					Actualizar_Historiales(mysql);
				else if (Opcion2 == 2)
					Borrar_Historiales(mysql);
				else if (Opcion2 == 3)	
					Ver_Historiales(mysql);
				else if (Opcion2 == 4)
					Historiales_Clientes(mysql);
				else if (Opcion2 == 5)
					printf("...\n");
				else
				{
					printf("Opción incorrecta, intente de nuevo...\n");
					printf("Presione enter para continuar...");
					__fpurge(stdin);
					getchar();
				}				
				
				Desconectar(mysql);
			}while(Opcion2 != 5);
		}
		/*
		else if (Opcion == 6)
		{
			do
			{
				system("clear");
				mysql = Conectar(mysql);
				printf("Menú Productos:\n");
				printf("\t1.- Agregar un producto.\n");
				printf("\t2.- Actualizar información de un producto.\n");
				printf("\t3.- Borrar un producto.\n");
				printf("\t4.- Lista de todos los productos.\n");
				printf("\t5.- Lista de todos los productos de una categoría en particular, mostrando su nombre, descripción\ny comentarios (en su caso) de clientes que hayan opinado acerca de dicho producto.\n");
				printf("\t6.- Regresar al menú administradores\n");
				printf("Escoja una opción\n");
				scanf(" %d",&Opcion2);
				system("clear");
				if (Opcion2 == 1)
					Insertar_Productos(mysql);
				else if (Opcion2 == 2)	
					Actualizar_Productos(mysql);
				else if (Opcion2 == 3)
					Borrar_Productos(mysql);
				else if (Opcion2 == 4)
					Ver_Productos(mysql);
				else if (Opcion2 == 5)
					Productos_Categoria(mysql);
				else if (Opcion2 == 6)
					printf("...\n");
				else
				{
					printf("Opción incorrecta, intente de nuevo...\n");
					printf("Presione enter para continuar...");
					__fpurge(stdin);
					getchar();
				}				
				
				Desconectar(mysql);
			}while(Opcion2 != 6);
		}
		*/
		else if (Opcion == 7)
			printf("Saliendo del menú de administradores\n");
		else
		{
			printf("Opción incorrecta, intente de nuevo...\n");
			printf("Presione enter para continuar...");
			__fpurge(stdin);
			getchar();
		}
	}while(Opcion !=7);
}
void Menu_Cliente(int IDUsuario, char NombreUsuario[50])
{
	MYSQL mysql;
	int Opcion = 0, Opcion2 = 0;
	do
	{
		system("clear");
		mysql = Conectar(mysql);
		printf("Bienvenido %s\n",NombreUsuario);
		printf("Menú Clientes:\n");
		printf("\t1.- Actualizar mi información.\n");
		printf("\t2.- Realizar una compra.\n");
		printf("\t3.- Ver Productos\n");
		printf("\t4.- Agregar comentario de un producto.\n");
		printf("\t5.- Agregar una queja o aclaración.\n");
		printf("\t6.- Regresar al menú principal\n");
		printf("Escoja una opción\n");
		scanf(" %d",&Opcion);
		/*
		if(Opcion == 1)
			Actualizar_Clientes(mysql,IDUsuario);
		else if (Opcion == 2)
			Insertar_Compras(mysql,IDUsuario);
		else if (Opcion == 3)
			Ver_Productos(mysql);			
		else if (Opcion == 4)
			Insertar_Comentarios_Productos(mysql,IDUsuario);
		else if (Opcion == 5)
			Insertar_Quejas_Aclaraciones(mysql,IDUsuario);
		*/
		if (Opcion == 6)
			printf("Saliendo del menú de clientes\n");
		else
		{
			printf("Opción incorrecta, intente de nuevo...\n");
			printf("Presione enter para continuar...");
			__fpurge(stdin);
			getchar();
		}
		Desconectar(mysql);
	}while(Opcion != 6);
}