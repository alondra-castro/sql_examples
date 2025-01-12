/*Un profesor almacena el documento y nombre de sus alumnos en una tabla llamada "alumnos" y en otra 
tabla llamada "notas" almacena las notas de los mismos.
1- Elimine las tablas, si existen:*/
 if object_id('alumnos') is not null
  drop table alumnos;
 if object_id('notas') is not null
  drop table notas;

/*2- Cr�elas con los campos necesarios. Agregue una restricci�n "primary key" para el campo 
"documento" y una restricci�n "foreign key" para que en la tabla "notas" el documento del alumno 
haga referencia al documento de la tabla "alumnos":*/
 create table alumnos(
  documento char(8) not null
   constraint CK_alumnos_documento check (documento like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  nombre varchar(30),
  constraint PK_alumnos
  primary key(documento)
 );

 create table notas(
  documento char(8) not null,
  nota decimal(4,2)
   constraint CK_notas_nota check (nota between 0 and 10),
  constraint FK_notas_documento
  foreign key(documento)
  references alumnos(documento)
  on update cascade
 );

--3- Ingrese algunos registros:
 insert into alumnos values('30111111','Ana Algarbe');
 insert into alumnos values('30222222','Bernardo Bustamante');
 insert into alumnos values('30333333','Carolina Conte');
 insert into alumnos values('30444444','Diana Dominguez');
 insert into alumnos values('30555555','Fabian Fuentes');
 insert into alumnos values('30666666','Gaston Gonzalez');

 insert into notas values('30111111',5.1);
 insert into notas values('30222222',7.8);
 insert into notas values('30333333',4);
 insert into notas values('30444444',2.5);
 insert into notas values('30666666',9.9);
 insert into notas values('30111111',7.3);
 insert into notas values('30222222',8.9);
 insert into notas values('30444444',6);
 insert into notas values('30666666',8);

--4- Declare una variable llamada "@documento" de tipo "char(8)" y vea su contenido:
 declare @documento char(8)
 select @documento;

--5- Intente usar la variable "@documento" para almacenar el documento del alumno con la nota m�s alta:
 select @documento= documento from notas
  where nota=(select max(nota) from notas);
--No se puede porque la variable fue declarada en otro lote de sentencias y no es reconocida.

--6- Declare una variable llamada "@documento" de tipo "char(8)" y almacene en ella el documento del 
--alumno con la nota m�s alta, luego recupere el nombre del alumno:
 declare @documento char(8)
 select @documento= documento from notas
  where nota=(select max(nota) from notas)
 select nombre from alumnos where documento=@documento;