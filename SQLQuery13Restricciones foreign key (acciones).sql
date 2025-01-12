/*Un club dicta clases de distintos deportes. En una tabla llamada "deportes" guarda la información de 
los distintos deportes que se enseñan; en una tabla "socios", los datos de los socios y en una tabla 
"inscripciones" almacena la información necesaria para las inscripciones de los distintos socios a 
los distintos deportes.
1- Elimine las tablas si existen:*/
 if object_id('inscripciones') is not null
  drop table inscripciones;
 if object_id('deportes') is not null
  drop table deportes;
 if object_id('socios') is not null
  drop table socios;

--2- Cree las tablas:
 create table deportes(
  codigo tinyint,
  nombre varchar(20),
  primary key(codigo)
 );

 create table socios(
  documento char(8),
  nombre varchar(30),
  primary key(documento)
 );

 create table inscripciones(
  documento char(8), 
  codigodeporte tinyint,
  matricula char(1),-- 's' si está paga, 'n' si no está paga
  primary key(documento,codigodeporte)
 );

/*3- Establezca una restricción "foreign key" para "inscripciones" que haga referencia al campo 
"codigo" de "deportes" que permita la actualización en cascada:*/
  alter table inscripciones
  add constraint FK_inscripciones_codigodeporte
  foreign key (codigodeporte)
  references deportes(codigo)
  on update cascade;

/*4- Establezca una restricción "foreign key" para "inscripciones" que haga referencia al campo 
"documento" de "socios" que permita la eliminación en cascada (Recuerde que se pueden establecer 
varias retricciones "foreign key" a una tabla):*/
  alter table inscripciones
  add constraint FK_inscripciones_documento
  foreign key (documento)
  references socios(documento)
  on delete cascade;

--5- Ingrese algunos registros en las tablas:
 insert into deportes values(1,'basquet');
 insert into deportes values(2,'futbol');
 insert into deportes values(3,'natacion');
 insert into deportes values(4,'tenis');

 insert into socios values('30000111','Juan Lopez');
 insert into socios values('31111222','Ana Garcia');
 insert into socios values('32222333','Mario Molina');
 insert into socios values('33333444','Julieta Herrero');

 insert into inscripciones values ('30000111',1,'s');
 insert into inscripciones values ('30000111',2,'s');
 insert into inscripciones values ('31111222',1,'s');
 insert into inscripciones values ('32222333',3,'n');

--6- Intente ingresar una inscripción con un código de deporte inexistente:
 insert into inscripciones values('30000111',6,'s');
--Mensaje de error.

--7- Intente ingresar una inscripción con un documento inexistente en "socios":
 insert into inscripciones values('40111222',1,'s');
--Mensaje de error.

--8- Elimine un registro de "deportes" que no tenga inscriptos:
 delete from deportes where nombre='tenis';
--Se elimina porque no hay inscriptos en dicho deporte.

--9- Intente eliminar un deporte para los cuales haya inscriptos:
 delete from deportes where nombre='natacion';
--No se puede porque al no especificarse acción para eliminaciones, por defecto es "no action" y hay 
--inscriptos en dicho deporte.

--10- Modifique el código de un deporte para los cuales haya inscriptos.
--La opción para actualizaciones se estableció en cascada, se modifica el código en "deportes" y en 
--"inscripciones".
 update deportes set codigo=5 where nombre='natacion';

---11- Verifique los cambios:
 select * from deportes;
 select * from inscripciones;

--12- Elimine el socio que esté inscripto en algún deporte.
--Se elimina dicho socio de "socios" y la acción se extiende a la tabla "inscripciones".
 delete from socios where documento='32222333'; 

--13- Verifique que el socio eliminado ya no aparece en "inscripciones":
 select * from socios;
 select * from inscripciones;

/*14- Modifique el documento de un socio que esté inscripto.
No se puede porque la acción es "no action" para actualizaciones.*/
 update socios set documento='35555555' where documento='30000111';

--15- Intente eliminar la tabla "deportes":
 drop table deportes;
--No se puede porque una restricción "foreign key" hace referencia a ella.

--16- Vea las restricciones de la tabla "socios":
 exec sp_helpconstraint socios;
--Muestra la restricción "primary key" y la referencia de una "foreign key" de la tabla 
--"inscripciones".

--17- Vea las restricciones de la tabla "deportes":
 exec sp_helpconstraint deportes;
--Muestra la restricción "primary key" y la referencia de una "foreign key" de la tabla 
--"inscripciones".

--18- Vea las restricciones de la tabla "inscripciones":
 exec sp_helpconstraint inscripciones;
/*Muestra 3 restricciones. Una "primary key" y dos "foreign key", una para el campo "codigodeporte" 
que especifica "no action" en la columna "delete_action" y "cascade" en la columna "update_action"; 
la otra, para el campo "documento" especifica "cascade" en la columna "delete_action" y "no action" 
en "update_action".*/
