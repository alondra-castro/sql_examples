
/*

Las funciones definidas por el usuario pueden encriptarse, para evitar que sean leídas con "sp_helptext".

Para ello debemos agregar al crearlas la opción "with encryption" antes de "as".

En funciones escalares:

 create function NOMBREFUNCION
 (@PARAMETRO TIPO) 
  returns TIPO
  with encryption
  as 
  begin
   CUERPO
   return EXPRESION
  end
*/
create function f_libros
 (@autor varchar(30)='Borges')
 returns table
 with encryption
 as
 return (
  select titulo,editorial
  from libros
  where autor like '%'+@autor+'%'
 );