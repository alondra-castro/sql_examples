/*Una empresa almacena los datos de sus empleados en una tabla llamada "empleados".
1- Eliminamos la tabla, si existe y la creamos:*/
 if object_id('empleados') is not null
  drop table empleados;

 create table empleados(
  documento char(8),
  nombre varchar(20),
  apellido varchar(20),
  cantidadhijos tinyint,
  seccion varchar(20),
  primary key(documento)
 );

--2- Ingrese algunos registros:
 insert into empleados values('22222222','Juan','Perez',2,'Contaduria');
 insert into empleados values('22333333','Luis','Lopez',0,'Contaduria');
 insert into empleados values ('22444444','Marta','Perez',NULL,'Sistemas');
 insert into empleados values('22555555','Susana','Garcia',2,'Secretaria');
 insert into empleados values('22666666','Jose Maria','Morales',1,'Secretaria');
 insert into empleados values('22777777','Andres','Perez',3,'Sistemas');
 insert into empleados values('22888888','Laura','Garcia',3,'Secretaria');

--3- Elimine el procedimiento llamado "pa_empleados_seccion", si existe:
 if object_id('pa_empleados_seccion') is not null
  drop procedure pa_empleados_seccion;

/*4- Cree un procedimiento que muestre todos los empleados de una sección determinada que se ingresa 
como parámetro. Si no se ingresa un valor, o se ingresa "null", se muestra un mensaje y se sale del 
procedimiento.*/
create procedure pa_empleados_seccion
  @seccion varchar(20)=null
 as 
 if @seccion is null
 begin 
  select 'Debe indicar una seccion'
  return
 end
 select nombre from empleados where seccion=@seccion;

--5- Ejecute el procedimiento enviándole un valor para el parámetro.
 exec pa_empleados_seccion 'Secretaria';

--6- Ejecute el procedimiento sin parámetro.
 exec pa_empleados_seccion;

--7- Elimine el procedimiento "pa_actualizarhijos", si existe:
 if object_id('pa_actualizarhijos') is not null
  drop procedure pa_actualizarhijos;

/*8- Cree un procedimiento almacenado que permita modificar la cantidad de hijos ingresando el 
documento de un empleado y la cantidad de hijos nueva. Ambos parámetros DEBEN ingresarse con un 
valor distinto de "null". El procedimiento retorna "1" si la actualización se realiza (si se 
ingresan valores para ambos parámetros) y "0", en caso que uno o ambos parámetros no se ingresen o 
sean nulos.*/

create procedure pa_actualizarhijos
  @documento char(8)=null,
  @hijos tinyint=null
 as 
 if (@documento is null) or (@hijos is null)
  return 0
 else 
 begin
  update empleados set cantidadhijos=@hijos where documento=@documento
  return 1
 end;


/*9- Declare una variable en la cual se almacenará el valor devuelto por el procedimiento, ejecute el 
procedimiento enviando los dos parámetros y vea el contenido de la variable.
El procedimiento retorna "1", con lo cual indica que fue actualizado.*/
declare @retorno int
 exec @retorno=pa_actualizarhijos '22222222',3
 select 'Registro actualizado=1' = @retorno;

--10- Verifique la actualización consultando la tabla:
 select *from empleados;

/*11- Ejecute los mismos pasos, pero esta vez envíe solamente un valor para el parámetro "documento".
Retorna "0", lo que indica que el registro no fue actualizado.*/
declare @retorno int
 exec @retorno=pa_actualizarhijos '22333333'
 select 'Registro actualizado=1' = @retorno;
--12- Verifique que el registro no se actualizó consultando la tabla:
 select *from empleados;

--13- Emplee un "if" para controlar el valor de la variable de retorno. Enviando al procedimiento valores para los parámetros.Retorna 1.
 declare @retorno int
 exec @retorno=pa_actualizarhijos '22333333',2
 if @retorno=1 select 'Registro actualizado'
 else select 'Registro no actualizado, se necesita un documento y la cantidad de hijos';

--14- Verifique la actualización consultando la tabla:
 select *from empleados;

--15- Emplee nuevamente un "if" y envíe solamente valor para el parámetro "hijos".Retorna 0.

declare @retorno int
 exec @retorno=pa_actualizarhijos @hijos=4
 if @retorno=1 select 'Registro actualizado'
 else select 'Registro no actualizado, se necesita un documento y la cantidad de hijos';
