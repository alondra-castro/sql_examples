--Una empresa almacena la información de sus clientes en dos tablas llamadas "clientes" y "ciudades".
--1- Elimine las tablas, si existen:
 if object_id('clientes') is not null
  drop table clientes;
 if object_id('ciudades') is not null
  drop table ciudades;

--2- Cree las tablas:
 create table ciudades(
  codigo tinyint identity,
  nombre varchar(20),
  constraint PK_ciudades
   primary key (codigo)
 );

 create table clientes(
  nombre varchar(20),
  apellido varchar(20),
  documento char(8),
  domicilio varchar(30),
  codigociudad tinyint
   constraint FK_clientes_ciudad
    foreign key (codigociudad)
   references ciudades(codigo)
   on update cascade
 );

--3- Ingrese algunos registros:
 insert into ciudades values('Cordoba');
 insert into ciudades values('Carlos Paz');
 insert into ciudades values('Cruz del Eje');
 insert into ciudades values('La Falda');

 insert into clientes values('Juan','Perez','22222222','Colon 1123',1);
 insert into clientes values('Karina','Lopez','23333333','San Martin 254',2);
 insert into clientes values('Luis','Garcia','24444444','Caseros 345',1);
 insert into clientes values('Marcos','Gonzalez','25555555','Sucre 458',3);
 insert into clientes values('Nora','Torres','26666666','Bulnes 567',1);
 insert into clientes values('Oscar','Luque','27777777','San Martin 786',4);

--4- Elimine la vista "vista_clientes" si existe:
 if object_id('vista_clientes') is not null
  drop view vista_clientes;

/*5- Cree la vista "vista_clientes" para que recupere el nombre, apellido, documento, domicilio, el 
código y nombre de la ciudad a la cual pertenece, de la ciudad de "Cordoba" empleando "with check 
option".*/

 create view vista_clientes
 as
  select apellido, cl.nombre, documento, domicilio, cl.codigociudad,ci.nombre as ciudad
  from clientes as cl
  join ciudades as ci
  on codigociudad=codigo
  where ci.nombre='Cordoba'
  with check option;

--6- Consulte la vista:
 select * from vista_clientes;

--7- Actualice el apellido de un cliente a través de la vista.
 update vista_clientes set apellido='Pereyra' where documento='22222222';

--8- Verifique que la modificación se realizó en la tabla:
 select * from clientes;

/*9- Intente cambiar la ciudad de algún registro.
Mensaje de error.*/
update vista_clientes set codigociudad=2 where documento='22222222';