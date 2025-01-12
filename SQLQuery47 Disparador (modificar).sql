
/*

Los triggers pueden modificarse y eliminarse.

Al modificar la definici�n de un disparador se reemplaza la definici�n existente del disparador por la nueva definici�n.

La sintaxis general es la siguiente:

 alter trigger NOMBREDISPARADOR
  NUEVADEFINICION;
Asumiendo que hemos creado un disparador llamado "dis_empleados_borrar" que no permit�a eliminar m�s de 1 registro de la tabla empleados; alteramos el disparador, para que cambia la cantidad de eliminaciones permitidas de 1 a 3:

 alter trigger dis_empleados_borrar
  on empleados
  for delete
  as 
   if (select count(*) from deleted)>3--antes era 1
   begin
    raiserror('No puede borrar mas de 3 empleados',16, 1)
    rollback transaction
   end;
Se puede cambiar el evento del disparador. Por ejemplo, si cre� un disparador para "insert" y luego se modifica el evento por "update", el disparador se ejecutar� cada vez que se actualice la tabla.

Servidor de SQL Server instalado en forma local.
Ingresemos el siguiente lote de comandos en el SQL Server Management Studio:

*/

if object_id('empleados') is not null
  drop table empleados;

create table empleados(
  documento char(8) not null,
  nombre varchar(30) not null,
  domicilio varchar(30),
  constraint PK_empleados primary key(documento),
);

go

insert into empleados values('22000000','Ana Acosta','Avellaneda 56');
insert into empleados values('23000000','Bernardo Bustos','Bulnes 188');
insert into empleados values('24000000','Carlos Caseres','Caseros 364');
insert into empleados values('25555555','Diana Duarte','Colon 1234');
insert into empleados values('26666666','Diana Duarte','Colon 897');
insert into empleados values('27777777','Matilda Morales','Colon 542');

go

-- Creamos un disparador para que no permita eliminar m�s de un registro a 
-- la vez de la tabla empleados:
create trigger dis_empleados_borrar
  on empleados
  for delete
 as
  if (select count(*) from deleted)>1
  begin
    raiserror('No puede eliminar m�s de un 1 empleado', 16, 1)
    rollback transaction
  end;

go

-- Eliminamos 1 empleado (El trigger se dispara y realiza la eliminaci�n):
delete from empleados where documento ='22000000';

-- Intentamos eliminar varios empleados
-- (El trigger se dispara, muestra un mensaje y deshace la transacci�n.): 
delete from empleados where documento like '2%';

select * from empleados;

go

-- Alteramos el disparador, para que cambia la cantidad de eliminaciones
-- permitidas de 1 a 3:
alter trigger dis_empleados_borrar
  on empleados
  for delete
  as 
   if (select count(*) from deleted)>3--antes era 1
   begin
    raiserror('No puede borrar m�s de 3 empleados',16, 1)
    rollback transaction
   end;

go

-- Intentamos eliminar 5 empleados (El trigger se dispara,
-- muestra el nuevo mensaje y deshace la transacci�n.):
delete from empleados where documento like '2%';

-- Eliminamos 3 empleados (El trigger se dispara y 
-- realiza las eliminaciones solicitadas):
delete from empleados where domicilio like 'Colon%';

select * from empleados;
