/*Trabaje con una tabla llamada "empleados".
1- Elimine la tabla, si existe y créela:*/
 if object_id('empleados') is not null
  drop table empleados;

 create table empleados(
  documento char(8) not null,
  nombre varchar(10),
  domicilio varchar(30),
  ciudad varchar(20) default 'Buenos Aires'
 );

--2- Agregue el campo "legajo" de tipo int identity y una restricción "primary key":
 alter table empleados
  add legajo int identity
  constraint PK_empleados_legajo primary key;

--3- Vea si la estructura cambió y si se agregó la restricción:
 exec sp_columns empleados;
 exec sp_helpconstraint empleados;

/*4- Agregue el campo "hijos" de tipo tinyint y en la misma sentencia una restricción "check" que no 
permita valores superiores a 30:*/
 alter table empleados
  add hijos tinyint
  constraint CK_empleados_hijos check (hijos<=30);

--5- Ingrese algunos registros:
 insert into empleados values('22222222','Juan Lopez','Colon 123','Cordoba',2);
 insert into empleados values('23333333','Ana Garcia','Sucre 435','Cordoba',3);
 /*
6- Intente agregar el campo "sueldo" de tipo decimal(6,2) no nulo y una restricción "check" que no 
permita valores negativos para dicho campo:*/
 alter table empleados
  add sueldo decimal(6,2) not null
  constraint CK_empleados_sueldo check (sueldo>=0);
--No lo permite porque no damos un valor por defecto para dicho campo no nulo y los registros 
--existentes necesitan cargar un valor.

--7- Agregue el campo "sueldo" de tipo decimal(6,2) no nulo, una restricción "check" que no permita 
--valores negativos para dicho campo y una restricción "default" que almacene el valor "0":
 alter table empleados
  add sueldo decimal(6,2) not null
  constraint CK_empleados_sueldo check (sueldo>=0)
  constraint DF_empleados_sueldo default 0;

--8- Recupere los registros:
 select * from empleados;

--9- Vea la nueva estructura de la tabla:
 exec sp_columns empleados;

--10- Vea las restricciones:
 exec sp_helpconstraint empleados;