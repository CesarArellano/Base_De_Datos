create table pruebaTransacciones(
  nombre char(20),
  unique(nombre)
) engine = InnoDB;

/*Transacción común*/

start transaction;
insert into pruebaTransacciones values('Hugo');
insert into pruebaTransacciones values('Paco');
commit;

/*Transacción con error y rollback*/

start transaction;
insert into pruebaTransacciones values('Ana');
insert into pruebaTransacciones values ('Maria');
insert into pruebaTransacciones values ('Luis');
insert into pruebaTransacciones values ('Paco');
rollback;
