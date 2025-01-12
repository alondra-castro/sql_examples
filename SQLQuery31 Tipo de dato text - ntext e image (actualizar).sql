/*Un maestro almacena los datos de sus alumnos en una tabla denominada "alumnos", incluye el 
documento, el nombre, la nota y un comentario acerca del comportamiento de cada uno de ellos.
1- Elimine la tabla si existe:*/
 if object_id('alumnos') is not null
  drop table alumnos;

--2- Créela con la siguiente estructura:
 create table alumnos (
  documento char(8),
  nombre varchar(30),
  nota decimal(4,2),
  concepto text,
  constraint PK_alumnos
  primary key(documento)
 );

--3- Ingrese algunos registros:
 insert into alumnos values ('22222222','Ana Acosta',3,'Participativo. Generoso');
 insert into alumnos values ('23333333','Carlos Caseres',7,'Poco participativo');
 insert into alumnos values ('24444444','Diego Duarte',8,'Buen compañero');
 insert into alumnos values ('25555555','Fabiola Fuentes',2,null);

--4- Recupere todos los registros:
 select *from alumnos;

/*5- Inserte en el concepto del alumno con documento "23333333" el texto "comunicativo", en la 
posición 5, borrando todos los caracteres siguientes. Verifique que el puntero sea válido, en caso 
de no serlo, muestre un mensaje de error.*/
declare @puntero binary(16)
 select @puntero = textptr (concepto)
  from alumnos
  where documento='23333333'
  if (textvalid('alumnos.concepto',@puntero)=1)
   updatetext alumnos.concepto @puntero 5 null 'comunicativo'
  else
   select 'Puntero inválido';
--6- Lea el campo "concepto" actualizado anteriormente para verificar que se actualizó.
 declare @puntero binary(16)
 select @puntero = textptr (concepto)
  from alumnos
  where documento='23333333'
 
 readtext alumnos.concepto @puntero 0 0;

/*7- Intente actualizar el concepto del alumno con documento "25555555" el texto "Muy comunicativo". 
Verifique que el puntero sea válido, en caso de no serlo, muestre un mensaje de error.
Puntero inválido.*/
declare @puntero binary(16)
 select @puntero = textptr (concepto)
  from alumnos
  where documento='25555555'
  if (textvalid('alumnos.concepto',@puntero)=1)
   updatetext alumnos.concepto @puntero 0 0 'Muy comunicativo'
  else
   select 'Puntero inválido';

/*8- Intente agregar texto al campo "concepto" del alumno con documento "24444444" en la posición 20.
Mensaje de error porque el texto tiene una longitud menor.*/

 declare @puntero binary(16)
 select @puntero = textptr (concepto)
  from alumnos
  where documento='24444444'
 updatetext alumnos.concepto @puntero 20 0 ' y estudioso';


/*9- Inserte en el concepto del alumno con documento "24444444" el texto "alumno y", en la posición 5, 
sin borrar ningún caracter. Verifique que el puntero sea válido antes de pasar el puntero a la 
función "updatetext".*/
declare @puntero binary(16)
 select @puntero = textptr (concepto)
  from alumnos
  where documento='24444444'
  if (textvalid('alumnos.concepto',@puntero)=1)
   updatetext alumnos.concepto @puntero 5 0 'alumno y '
  else  select 'Puntero inválido';

--10- Lea el campo "concepto" actualizado anteriormente para verificar que se actualizó.
declare @puntero binary(16)
 select @puntero = textptr (concepto)
  from alumnos
  where documento='24444444'
 
 readtext alumnos.concepto @puntero 0 0;

--11- Elimine la tabla "reprobados" si existe:
 if object_id('reprobados') is not null
  drop table reprobados;

--12- Cree la tabla "reprobados" que contenga 2 campos: documento y concepto:
 create table reprobados(
  documento char(8) not null,
  concepto text
 );

--13- Ingrese los siguientes registros en "reprobados" (en el campo "concepto" ingresamos cadenas 
--vacías para que se creen punteros válidos):
 insert into reprobados values('22222222','');
 insert into reprobados values('25555555','');

--14- Actualice el "concepto" del alumno "22222222" de la tabla "reprobados" con el concepto de dicho 
--alumno de la tabla "alumnos". Verifique que los punteros sean válidos.
declare @puntero1 binary(16)
 select @puntero1 = textptr(concepto)
  from alumnos
  where documento='22222222'

 declare @puntero2 binary(16)
 select @puntero2 = textptr(concepto)
  from reprobados
  where documento='22222222'

  if (textvalid('alumnos.concepto',@puntero1)=1) 
    if (textvalid('reprobados.concepto',@puntero2)=1)
      updatetext reprobados.concepto @puntero2 0 null alumnos.concepto @puntero1
    else select 'Puntero a la tabla reprobados inválido'
  else select 'Puntero a la tabla alumnos inválido';

 

--15- Verifique la actualización.

declare @puntero binary(16)
 select @puntero = textptr(concepto)
  from reprobados
  where documento='22222222'
 readtext reprobados.concepto @puntero 0 0;

/*16- Intente actualizar el "concepto" del alumno "25555555" de la tabla "reprobados" con el concepto 
de dicho alumno de la tabla "alumnos". Verifique que los punteros sean válidos.
Mensaje de error porque hay un puntero inválido, el de la tabla "alumnos", porque el registro 
consultado contiene "null" en "concepto".*/

 declare @puntero1 binary(16)
 select @puntero1 = textptr(concepto)
  from alumnos
  where documento='25555555'

 declare @puntero2 binary(16)
 select @puntero2 = textptr(concepto)
  from reprobados
  where documento='25555555'

  if (textvalid('alumnos.concepto',@puntero1)=1) 
    if (textvalid('reprobados.concepto',@puntero2)=1)
      updatetext reprobados.concepto @puntero2 0 null alumnos.concepto @puntero1
    else select 'Puntero de "reprobados" inválido'
  else select 'Puntero de "alumnos" inválido';

/*17- Intente actualizar el "concepto" del alumno "23333333" de la tabla "reprobados" con el concepto 
de dicho alumno de la tabla "alumnos". Verifique que los punteros sean válidos.
Mensaje de error porque hay un puntero inválido, el de "reprobados", no existe el registro 
consultado.*/
declare @puntero1 binary(16)
 select @puntero1 = textptr(concepto)
  from alumnos
  where documento='23333333'

 declare @puntero2 binary(16)
 select @puntero2 = textptr(concepto)
  from reprobados
  where documento='23333333'

  if (textvalid('alumnos.concepto',@puntero1)=1) 
    if (textvalid('reprobados.concepto',@puntero2)=1)
      updatetext reprobados.concepto @puntero2 0 null
      alumnos.concepto @puntero1
    else select 'Puntero de "reprobados" inválido'
  else select 'Puntero de "alumnos" inválido';