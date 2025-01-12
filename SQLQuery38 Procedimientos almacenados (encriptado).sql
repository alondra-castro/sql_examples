if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  precio decimal(5,2),
  primary key(codigo) 
);

go

-- Eliminamos el procedimiento llamado "pa_libros_autor", si existe:
if object_id('pa_libros_autor') is not null
  drop procedure pa_libros_autor;

go

-- Creamos el procedimiento almacenado "pa_libros_autor" con la opción de encriptado:
create procedure pa_libros_autor
  @autor varchar(30)=null
  with encryption
  as
   select *from libros
    where autor=@autor;

go

-- Ejecutamos el procedimiento almacenado del sistema "sp_helptext" para ver su contenido
-- (no aparece): 
exec sp_helptext pa_libros_autor;
