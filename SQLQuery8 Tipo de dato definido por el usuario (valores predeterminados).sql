/*Un comercio almacena los datos de sus empleados en una tabla denominada "empleados" y en otra 
llamada "clientes" los datos de sus clientes".
1- Elimine ambas tablas, si existen:*/
 if object_id ('empleados') is not null
  drop table empleados;
 if object_id ('clientes') is not null
  drop table clientes;

/*2- Defina un nuevo tipo de dato llamado "tipo_año". Primero debe eliminarlo, si existe, para volver 
a crearlo. Para ello emplee esta sentencia que explicaremos en el siguiente capítulo:*/
 if exists (select *from systypes
  where name = 'tipo_año')
   exec sp_droptype tipo_año;

/*3- Cree un tipo de dato definido por el usuario llamado "tipo_año" basado en el tipo "int" que 
permita valores nulos:*/
 exec sp_addtype tipo_año, 'int','null';

/*4- Ejecute el procedimiento almacenado "sp_help" junto al nombre del tipo de dato definido 
anteriormente para obtener información del mismo:*/
 exec sp_help tipo_año;

/*5- Cree la tabla "empleados" con 3 campos: documento (char de 8), nombre (30 caracteres) y 
añoingreso (tipo_año):*/
 create table empleados(
  documento char(8),
  nombre varchar(30),
  añoingreso tipo_año
 );

--6- Elimine el valor predeterminado "VP_añoactual" si existe:
 if object_id ('VP_añoactual') is not null
   drop default VP_añoactual;

--7- Cree el valor predeterminado "VP_añoactual" que almacene el año actual:
 create default VP_añoactual
  as datepart(year,getdate());

/*8- Asocie el valor predeterminado al tipo de datos "tipo_año" especificando que solamente se aplique 
a los futuros campos de este tipo:*/
 exec sp_bindefault VP_añoactual, 'tipo_año', 'futureonly';

--9- Vea si se aplicó a la tabla empleados:
 exec sp_helpconstraint empleados;
--No se aplicó porque especificamos la opción "futureonly":

/*10- Cree la tabla "clientes" con 3 campos: nombre (30 caracteres), añoingreso (tipo_año) y domicilio 
(30 caracteres):*/
 create table clientes(
  documento char(8),
  nombre varchar(30),
  añoingreso tipo_año
 );

--11- Vea si se aplicó la regla en la nueva tabla:
 exec sp_helpconstraint clientes;
--Si se aplicó.

/*12- Ingrese un registro con valores por defecto en la tabla "empleados" y vea qué se almacenó en 
"añoingreso":*/
 insert into empleados default values;
 select * from empleados;
--Se almacenó "null" porque en esta tabla no se aplica el valor predeterminado.

--13- Ingrese en la tabla "clientes" un registro con valores por defecto y recupere los registros:
 insert into clientes default values;
 select * from clientes;
--Se almacenó el valor predeterminado.

--14- Elimine el valor predeterminado llamado "VP_año2000", si existe:
 if object_id ('VP_año2000') is not null
   drop default Vp_año2000;

--15- Cree un valor predeterminado llamado "VP_año2000" con el valor 2000:
 create default VP_año2000
  as 2000;

--16- Asócielo al tipo de dato definido sin especificar "futureonly":
 exec sp_bindefault VP_año2000, 'tipo_año';

--17- Verifique que se asoció a la tabla "empleados":
 exec sp_helpconstraint empleados;

--18- Verifique que reemplazó al valor predeterminado anterior en la tabla "clientes":
 exec sp_helpconstraint clientes;

--18- Ingrese un registro en ambas tablas con valores por defecto y vea qué se almacenó en el año de 
--ingreso:
 insert into empleados default values;
 select * from empleados;
 insert into clientes default values;
 select * from clientes;

---19- Vea la información del tipo de dato:
 exec sp_help tipo_año;
--La columna que hace referencia al valor predeterminado asociado muestra "VP_año2000".

--20- Intente agregar a la tabla "empleados" una restricción "default":
 alter table empleados
 add constraint DF_empleados_año
 default 1990
 for añoingreso;
--No lo permite porque el tipo de dato del campo ya tiene un valor predeterminado asociado.

--21- Quite la asociación del valor predeterminado al tipo de dato:
 exec sp_unbindefault 'tipo_año';

--22- Agregue a la tabla "empleados" una restricción "default":
 alter table empleados
 add constraint DF_empleados_año
 default 1990
 for añoingreso;

--23- Asocie el valor predeterminado "VP_añoactual" al tipo de dato "tipo_año":
 exec sp_bindefault VP_añoactual, 'tipo_año';

--24- Verifique que el tipo de dato tiene asociado el valor predeterminado:
 exec sp_help tipo_año;

--25- Verifique que la tabla "clientes" tiene asociado el valor predeterminado:
 exec sp_helpconstraint clientes;
 /*
26- Verifique que la tabla "empleados" no tiene asociado el valor predeterminado "VP_añoactual" 
asociado al tipo de dato y tiene la restricción "default":*/
 exec p_helpconstraint empleados;