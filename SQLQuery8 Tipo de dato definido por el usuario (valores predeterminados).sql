/*Un comercio almacena los datos de sus empleados en una tabla denominada "empleados" y en otra 
llamada "clientes" los datos de sus clientes".
1- Elimine ambas tablas, si existen:*/
 if object_id ('empleados') is not null
  drop table empleados;
 if object_id ('clientes') is not null
  drop table clientes;

/*2- Defina un nuevo tipo de dato llamado "tipo_a�o". Primero debe eliminarlo, si existe, para volver 
a crearlo. Para ello emplee esta sentencia que explicaremos en el siguiente cap�tulo:*/
 if exists (select *from systypes
  where name = 'tipo_a�o')
   exec sp_droptype tipo_a�o;

/*3- Cree un tipo de dato definido por el usuario llamado "tipo_a�o" basado en el tipo "int" que 
permita valores nulos:*/
 exec sp_addtype tipo_a�o, 'int','null';

/*4- Ejecute el procedimiento almacenado "sp_help" junto al nombre del tipo de dato definido 
anteriormente para obtener informaci�n del mismo:*/
 exec sp_help tipo_a�o;

/*5- Cree la tabla "empleados" con 3 campos: documento (char de 8), nombre (30 caracteres) y 
a�oingreso (tipo_a�o):*/
 create table empleados(
  documento char(8),
  nombre varchar(30),
  a�oingreso tipo_a�o
 );

--6- Elimine el valor predeterminado "VP_a�oactual" si existe:
 if object_id ('VP_a�oactual') is not null
   drop default VP_a�oactual;

--7- Cree el valor predeterminado "VP_a�oactual" que almacene el a�o actual:
 create default VP_a�oactual
  as datepart(year,getdate());

/*8- Asocie el valor predeterminado al tipo de datos "tipo_a�o" especificando que solamente se aplique 
a los futuros campos de este tipo:*/
 exec sp_bindefault VP_a�oactual, 'tipo_a�o', 'futureonly';

--9- Vea si se aplic� a la tabla empleados:
 exec sp_helpconstraint empleados;
--No se aplic� porque especificamos la opci�n "futureonly":

/*10- Cree la tabla "clientes" con 3 campos: nombre (30 caracteres), a�oingreso (tipo_a�o) y domicilio 
(30 caracteres):*/
 create table clientes(
  documento char(8),
  nombre varchar(30),
  a�oingreso tipo_a�o
 );

--11- Vea si se aplic� la regla en la nueva tabla:
 exec sp_helpconstraint clientes;
--Si se aplic�.

/*12- Ingrese un registro con valores por defecto en la tabla "empleados" y vea qu� se almacen� en 
"a�oingreso":*/
 insert into empleados default values;
 select * from empleados;
--Se almacen� "null" porque en esta tabla no se aplica el valor predeterminado.

--13- Ingrese en la tabla "clientes" un registro con valores por defecto y recupere los registros:
 insert into clientes default values;
 select * from clientes;
--Se almacen� el valor predeterminado.

--14- Elimine el valor predeterminado llamado "VP_a�o2000", si existe:
 if object_id ('VP_a�o2000') is not null
   drop default Vp_a�o2000;

--15- Cree un valor predeterminado llamado "VP_a�o2000" con el valor 2000:
 create default VP_a�o2000
  as 2000;

--16- As�cielo al tipo de dato definido sin especificar "futureonly":
 exec sp_bindefault VP_a�o2000, 'tipo_a�o';

--17- Verifique que se asoci� a la tabla "empleados":
 exec sp_helpconstraint empleados;

--18- Verifique que reemplaz� al valor predeterminado anterior en la tabla "clientes":
 exec sp_helpconstraint clientes;

--18- Ingrese un registro en ambas tablas con valores por defecto y vea qu� se almacen� en el a�o de 
--ingreso:
 insert into empleados default values;
 select * from empleados;
 insert into clientes default values;
 select * from clientes;

---19- Vea la informaci�n del tipo de dato:
 exec sp_help tipo_a�o;
--La columna que hace referencia al valor predeterminado asociado muestra "VP_a�o2000".

--20- Intente agregar a la tabla "empleados" una restricci�n "default":
 alter table empleados
 add constraint DF_empleados_a�o
 default 1990
 for a�oingreso;
--No lo permite porque el tipo de dato del campo ya tiene un valor predeterminado asociado.

--21- Quite la asociaci�n del valor predeterminado al tipo de dato:
 exec sp_unbindefault 'tipo_a�o';

--22- Agregue a la tabla "empleados" una restricci�n "default":
 alter table empleados
 add constraint DF_empleados_a�o
 default 1990
 for a�oingreso;

--23- Asocie el valor predeterminado "VP_a�oactual" al tipo de dato "tipo_a�o":
 exec sp_bindefault VP_a�oactual, 'tipo_a�o';

--24- Verifique que el tipo de dato tiene asociado el valor predeterminado:
 exec sp_help tipo_a�o;

--25- Verifique que la tabla "clientes" tiene asociado el valor predeterminado:
 exec sp_helpconstraint clientes;
 /*
26- Verifique que la tabla "empleados" no tiene asociado el valor predeterminado "VP_a�oactual" 
asociado al tipo de dato y tiene la restricci�n "default":*/
 exec p_helpconstraint empleados;