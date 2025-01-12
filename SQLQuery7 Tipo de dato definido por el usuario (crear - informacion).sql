/*Un comercio almacena los datos de sus empleados en una tabla denominada "empleados".
1- Elimine la tabla si existe:*/
 if object_id ('empleados') is not null
  drop table empleados;

/*2- Defina un nuevo tipo de dato llamado "tipo_legajo". Primero debe eliminarlo (si existe) para 
volver a crearlo. Para ello emplee esta sentencia que explicaremos en el siguiente cap�tulo:*/
 if exists (select name from systypes
  where name = 'tipo_legajo')
  exec sp_droptype tipo_legajo;

/*3- Cree un tipo de dato definido por el usuario llamado "tipo_legajo" basado en el tipo "char" de 4 
caracteres que no permita valores nulos.*/
 exec sp_addtype tipo_legajo, 'char(4)','not null';

/*4- Ejecute el procedimiento almacenado "sp_help" junto al nombre del tipo de dato definido 
anteriormente para obtener informaci�n del mismo.*/
 exec sp_help tipo_legajo;

/*5- Cree la tabla "empleados" con 3 campos: legajo (tipo_legajo), documento (char de 8) y nombre (30 
caracteres):*/
 create table empleados(
  legajo tipo_legajo,
  documento char(8),
  nombre varchar(30)
 );

--6- Intente ingresar un registro con valores por defecto:
 insert into empleados default values;
/*No se puede porque el campo "tipo_legajo" no admite valores nulos y no tiene definido un valor por 
defecto.*/

--7- Ingrese un registro con valores v�lidos.
 insert into empleados values('A111','22222222','Juan Perez');
