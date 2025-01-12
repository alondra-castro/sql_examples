/*

Hasta el momento hemos aprendido que un trigger se crea sobre una tabla (o vista), especificando el momento de ejecuci�n (after o instead of), para un evento (inserci�n, eliminaci�n o actualizaci�n).

Podemos encriptar los triggers para evitar que sean le�dos con "sp_helptext". Para ello debemos agregar al crearlos la opci�n "with encryption" luego del nombre de la tabla o vista:

 create triggre NOMBREDISPARADOR
  on NOMBRETABLAoVISTA
  with encryption
  MOMENTODEDISPARO--after o instead of
  ACCION-- insert, update, delete
  as 
    SENTENCIAS
El siguiente disparador se crea encriptado:

 create trigger DIS_empleados_insertar
  on empleados
  with encryption
  after insert
 as
  if (select seccion from inserted)='Gerencia'
  begin
    raiserror('No puede ingresar empleados en la secci�n "Gerencia".', 16, 1)
    rollback transaction
  end;
Si ejecutamos el procedimiento almacenado del sistema "sp_helptext" seguido del nombre del trigger creado anteriormente, SQL Server mostrar� un mensaje indicando que tal disparador ha sido encriptado.

Servidor de SQL Server instalado en forma local.
Ingresemos el siguiente lote de comandos en el SQL Server Management Studio:
*/

if object_id('empleados') is not null
  drop table empleados;

create table empleados(
  documento char(8) not null,
  nombre varchar(30) not null,
  domicilio varchar(30),
  seccion varchar(20),
  constraint PK_empleados primary key(documento),
);

go

-- Creamos el siguiente disparador encriptado:
create trigger DIS_empleados_insertar
  on empleados
  with encryption
  after insert
 as
  if (select seccion from inserted)='Gerencia'
  begin
    raiserror('No puede ingresar empleados en la secci�n "Gerencia".', 16, 1)
    rollback transaction
  end;

go

-- Ejecutamos el procedimiento almacenado del sistema "sp_helptext" 
-- seguido del nombre del trigger creado anteriormente 
--(SQL Server muestra un mensaje indicando que tal disparador ha sido encriptado):
exec sp_helptext dis_empleados_insertar;

go

-- Modificamos el disparador para quitar la encriptaci�n:
alter trigger dis_empleados_insertar
  on empleados
  after insert
 as
  if (select seccion from inserted)='Gerencia'
  begin
    raiserror('No puede ingresar empleados en la secci�n "Gerencia".', 16, 1)
    rollback transaction
  end;

-- Ejecutamos el procedimiento almacenado del sistema "sp_helptext"
-- seguido del nombre del trigger (SQL Server nos permite ver la
-- definici�n del trigger porque ya no est� encriptado.):
exec sp_helptext dis_empleados_insertar;