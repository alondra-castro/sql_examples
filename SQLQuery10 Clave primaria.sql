 if object_id('libros') is not null
  drop table libros;

   create table libros(
  codigo int not null,
  titulo varchar(40) not null,
  autor varchar(20),
  editorial varchar(15),
  primary key(codigo)
 );
insert into libros (codigo,titulo,autor,editorial)
  values (1,'El aleph','Borges','Emece');
 insert into libros (codigo,titulo,autor,editorial)
  values (2,'Martin Fierro','Jose Hernandez','Planeta');
 insert into libros (codigo,titulo,autor,editorial)
  values (3,'Aprenda PHP','Mario Molina','Nuevo Siglo');

   insert into libros (codigo,titulo,autor,editorial)
  values (3,'Aprenda PHP','Mario Molina','Nuevo Siglo');
   insert into libros (codigo,titulo,autor,editorial)
  values (null,'Aprenda PHP','Mario Molina','Nuevo Siglo');

  select *from libros

  update  libros set codigo = 1
  where titulo ='Martin Fierro';

  create table 