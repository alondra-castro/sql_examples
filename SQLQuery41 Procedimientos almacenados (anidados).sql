-- Eliminamos, si existen, los procedimientos almacenados siguientes:
if object_id('pa_multiplicar') is not null
  drop proc pa_multiplicar;
if object_id('pa_factorial') is not null
  drop proc pa_factorial;

go

-- Creamos un procedimiento almacenado que reciba 2 n�meros enteros
-- y nos retorne el producto de los mismos:
create procedure pa_multiplicar
  @numero1 int,
  @numero2 int,
  @producto int output
  as
   select @producto=@numero1*@numero2;

go

-- Probamos el procedimiento anterior:
declare @x int
exec pa_multiplicar 3,9, @x output
select @x as '3*9'
exec pa_multiplicar 50,8, @x output
select @x as '50*8';

go

-- Creamos un procedimiento que nos retorne el factorial de un n�mero,
-- tal procedimiento llamar� al procedimiento "pa_multiplicar":
create procedure pa_factorial
  @numero int
 as
  if @numero>=0 and @numero<=12
  begin
   declare @resultado int
   declare @num int
   set @resultado=1 
   set @num=@numero 
   while (@num>1)
   begin
     exec pa_multiplicar @resultado,@num, @resultado output
     set @num=@num-1
   end
   select rtrim(convert(char,@numero))+'!='+convert(char,@resultado)
  end
  else select 'Debe ingresar un n�mero entre 0 y 12';

go

-- Ejecutamos el procedimiento que nos retorna el factorial de un n�mero:
exec pa_factorial 5;
exec pa_factorial 10;

-- Veamos las dependencias del procedimiento "pa_multiplicar":
exec sp_depends pa_multiplicar;

-- Veamos las dependencias del procedimiento "pa_factorial":
exec sp_depends pa_factorial;