/*Una empresa almacena los datos de sus empleados en una tabla denominada "empleados" y en otra tabla 
llamada "secciones", el c�digo de la secci�n y el sueldo m�ximo de cada una de ellas.
1- Elimine las tablas si existen:*/
 if object_id('empleados') is not null
  drop table empleados;
 if object_id('secciones') is not null
  drop table secciones;

--2- Cree las tablas, con las siguientes estructuras:
 create table secciones(
  codigo int identity,
  nombre varchar(30),
  sueldomaximo decimal(8,2), 
  constraint PK_secciones primary key(codigo)
 );

 create table empleados(
  documento char(8) not null,
  nombre varchar(30) not null,
  domicilio varchar(30),
  codigoseccion int not null,
  sueldo decimal(8,2),
  constraint PK_empleados primary key(documento),
  constraint FK_empelados_seccion
   foreign key (codigoseccion) references secciones(codigo)
 );

--3- Ingrese algunos registros en ambas tablas:
 insert into secciones values('Administracion',1500);
 insert into secciones values('Sistemas',2000);
 insert into secciones values('Secretaria',1000);

 insert into empleados values('22222222','Ana Acosta','Avellaneda 88',1,1100);
 insert into empleados values('23333333','Bernardo Bustos','Bulnes 345',1,1200);
 insert into empleados values('24444444','Carlos Caseres','Colon 674',2,1800);
 insert into empleados values('25555555','Diana Duarte','Colon 873',3,1000);

/*4- Cree un disparador para que se ejecute cada vez que una instrucci�n "insert" ingrese datos en 
"empleados"; el mismo debe verificar que el sueldo del empleado no sea mayor al sueldo m�ximo 
establecido para la secci�n, si lo es, debe mostrar un mensaje indicando tal situaci�n y deshacer la 
transacci�n.*/

 create trigger dis_empleados_insertar
  on empleados
  for insert
 as
  declare @maximo decimal(8,2)
  set @maximo=(select sueldomaximo from secciones
              join inserted
              on inserted.codigoseccion=secciones.codigo)
  if (@maximo<(select sueldo from inserted))
  begin
    declare @mensaje varchar(40)
    set @mensaje='El sueldo debe ser menor a '+cast(@maximo as char(8))
    raiserror(@mensaje, 16, 1)
    rollback transaction
  end;

/*5- Ingrese un nuevo registro en "empleados" cuyo sueldo sea menor o igual al establecido para la 
secci�n.*/
 insert into empleados values('26666666','Federico Fuentes','Francia 938',2,1000);

---6- Verifique que el disparador se ejecut� consultando la tabla "empleados":
 select *from empleados;

/*7- Intente ingresar un nuevo registro en "empleados" cuyo sueldo sea mayor al establecido para la 
secci�n.
El disparador se ejecut� mostrando un mensaje y la transacci�n se deshizo.*/
 insert into empleados values('27777777','Gaston Garcia','Guemes 366',3,1200);

--8- Verifique que el registro no se agreg� en "empleados":
 select *from empleados;

/*9- Intente ingresar un empleado con c�digo de secci�n inexistente.
Aparece un mensaje de error porque se viola la restricci�n "foreign key"; el trigger no lleg� a 
ejecutarse.*/

 insert into empleados values('27777777','Gaston Garcia','Guemes 366',9,1200);
