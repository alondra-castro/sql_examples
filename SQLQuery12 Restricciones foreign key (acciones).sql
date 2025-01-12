/*Una empresa tiene registrados sus clientes en una tabla llamada "clientes", tambi�n tiene una tabla 
"provincias" donde registra los nombres de las provincias.
1- Elimine las tablas "clientes" y "provincias", si existen:*/
 if object_id('clientes') is not null
  drop table clientes;
 if object_id('provincias') is not null
  drop table provincias;

--2- Cr�elas con las siguientes estructuras:
 create table clientes (
  codigo int identity,
  nombre varchar(30),
  domicilio varchar(30),
  ciudad varchar(20),
  codigoprovincia tinyint,
  primary key(codigo)
 );

 create table provincias(
  codigo tinyint,
  nombre varchar(20),
  primary key (codigo)
 );

--3- Ingrese algunos registros para ambas tablas:
 insert into provincias values(1,'Cordoba');
 insert into provincias values(2,'Santa Fe');
 insert into provincias values(3,'Misiones');
 insert into provincias values(4,'Rio Negro');

 insert into clientes values('Perez Juan','San Martin 123','Carlos Paz',1);
 insert into clientes values('Moreno Marcos','Colon 234','Rosario',2);
 insert into clientes values('Acosta Ana','Avellaneda 333','Posadas',3);

/*4- Establezca una restricci�n "foreign key" especificando la acci�n "en cascade" para 
actualizaciones y "no action" para eliminaciones.*/
alter table clientes
 add constraint FK_clientes_codigoprovincia
  foreign key (codigoprovincia)
  references provincias(codigo)
  on update cascade
  on delete no action;

/*5- Intente eliminar el registro con c�digo 3, de "provincias".
No se puede porque hay registros en "clientes" al cual hace referencia y la opci�n para 
eliminaciones se estableci� como "no action".*/
 delete from provincias where codigo=3;

--6- Modifique el registro con c�digo 3, de "provincias".
 update provincias set codigo=9 where codigo=3;


/*7- Verifique que el cambio se realiz� en cascada, es decir, que se modific� en la tabla "provincias" 
y en "clientes":*/
 select * from provincias;
 select * from clientes;

/*8- Intente modificar la restricci�n "foreign key" para que permita eliminaci�n en cascada.
Mensaje de error, no se pueden modificar las restricciones.*/
 alter table clientes
 add constraint FK_clientes_codigoprovincia
  foreign key (codigoprovincia)
  references provincias(codigo)
  on update cascade,
  on delete cascade;
/*9- Intente eliminar la tabla "provincias".
No se puede eliminar porque una restricci�n "foreign key" hace referencia a ella.*/

 drop table provincias;
