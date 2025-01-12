/*Una empresa tiene registrados sus clientes en una tabla llamada "clientes", tambi�n tiene una tabla 
"provincias" donde registra los nombres de las provincias.
1- Elimine las tablas "clientes" y "provincias", si existen y cr�elas:*/
 if object_id('clientes') is not null
  drop table clientes;
 if object_id('provincias') is not null
  drop table provincias;

 create table clientes (
  codigo int identity,
  nombre varchar(30),
  domicilio varchar(30),
  ciudad varchar(20),
  codigoprovincia tinyint
 );

 create table provincias(
  codigo tinyint not null,
  nombre varchar(20)
 );

/*En este ejemplo, el campo "codigoprovincia" de "clientes" es una clave for�nea, se emplea para 
enlazar la tabla "clientes" con "provincias".

2- Intente agregar una restricci�n "foreign key" a la tabla "clientes" que haga referencia al campo 
"codigo" de "provincias":*/
 alter table clientes
 add constraint FK_clientes_codigoprovincia
  foreign key (codigoprovincia)
  references provincias(codigo);
/*No se puede porque "provincias" no tiene restricci�n "primary key" ni "unique".

3- Establezca una restricci�n "primary key" al campo "codigo" de "provincias":*/
 alter table provincias
 add constraint PK_provincias_codigo
  primary key (codigo);

--4- Ingrese algunos registros para ambas tablas:
 insert into provincias values(1,'Cordoba');
 insert into provincias values(2,'Santa Fe');
 insert into provincias values(3,'Misiones');
 insert into provincias values(4,'Rio Negro');

 insert into clientes values('Perez Juan','San Martin 123','Carlos Paz',1);
 insert into clientes values('Moreno Marcos','Colon 234','Rosario',2);
 insert into clientes values('Acosta Ana','Avellaneda 333','Posadas',3);
 insert into clientes values('Luisa Lopez','Juarez 555','La Plata',6);

--5- Intente agregar la restricci�n "foreign key" del punto 2 a la tabla "clientes":
 alter table clientes
 add constraint FK_clientes_codigoprovincia
  foreign key (codigoprovincia)
  references provincias(codigo);
/*No se puede porque hay un registro en "clientes" cuyo valor de "codigoprovincia" no existe en 
"provincias".

6- Elimine el registro de "clientes" que no cumple con la restricci�n y establezca la restricci�n 
nuevamente:*/
 delete from clientes where codigoprovincia=6;
 alter table clientes
 add constraint FK_clientes_codigoprovincia
  foreign key (codigoprovincia)
  references provincias(codigo);

--7- Intente agregar un cliente con un c�digo de provincia inexistente en "provincias".No se puede.
 insert into clientes values('Garcia Marcos','Colon 877','Lules',9);

--8- Intente eliminar el registro con c�digo 3, de "provincias".No se puede porque hay registros en "clientes" al cual hace referencia.
delete from provincias where codigo=3;

--9- Elimine el registro con c�digo "4" de "provincias". Se permite porque en "clientes" ning�n registro hace referencia a �l.
 delete from provincias where codigo=4;

--10- Intente modificar el registro con c�digo 1, de "provincias". No se puede porque hay registros en "clientes" al cual hace referencia.
 update provincias set codigo=7 where codigo=1;

--11- Vea las restricciones de "clientes". aparece la restricci�n "foreign key".
 exec sp_helpconstraint clientes;

/*12- Vea las restricciones de "provincias".
aparece la restricci�n "primary key" y nos informa que la tabla es rerenciada por una "foreign key" 
de la tabla "clientes" llamada "FK_clientes_codigoprovincia".*/

 exec sp_helpconstraint provincias;
