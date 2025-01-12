
/*Una librería almacena los datos de los libros en una tabla denominada "libros" y en una tabla 
"ventas" las ventas de los mismos.
1- Elimine las tablas si existen y créelas:*/
 if (object_id('libros')) is not null
  drop table libros;
 if (object_id('ventas')) is not null
  drop table ventas;

 create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  precio decimal(6,2),
  cantidad int,
  primary key (codigo)
 );

 create table ventas(
  numero int identity,
  codigo int not null,
  preciounitario decimal(6,2),
  cantidad int, 
  constraint PK_ventas primary key (numero),
  constraint FK_ventas_codigolibro
   foreign key (codigo)
   references libros(codigo)
   on update cascade
 );

--2- Ingrese algunos registros para ambas:
 insert into libros values('Uno','Richard Bach','Planeta',15,100);
 insert into libros values('Ilusiones','Richard Bach','Planeta',18,150);
 insert into libros values('El aleph','Borges','Emece',25,200);
 insert into libros values('Matematica estas ahi','Paenza','Nuevo siglo',20,300);
 insert into libros values('Aprenda PHP','Mario Molina','Nuevo siglo',45,200);
 
 insert into ventas values(1,15,1);
 insert into ventas values(2,18,1);
 insert into ventas values(3,25,100);
 insert into ventas values(1,15,50);

--3- Elimine el procedimiento "pa_ventas", si existe:
 if (object_id('pa_ventas')) is not null
  drop proc pa_ventas;

/*4- Cree un procedimiento que muestre los datos de las ventas (número, título, autor y editorial del 
libro vendido, precio unitario, cantidad vendida, total por item)*/
create procedure pa_ventas
  as
   select v.numero,
   (l.titulo+'-'+l.autor+'-'+l.editorial) as libro,
   v.preciounitario,
   v.cantidad,
   (v.preciounitario*v.cantidad) as total
   from ventas as v
   join libros as l
   on v.codigo=l.codigo;

--5- Ejecute el procedimiento:
 exec  pa_ventas;

--6- Elimine el procedimiento "pa_vender", si existe:
 if (object_id('pa_vender')) is not null
  drop proc pa_vender;

/*7- Cree un procedimiento que permita ingresar una venta en "ventas" con los siguientes datos: código 
del libro y cantidad que se vende. El procedimiento debe controlar que haya libros disponibles (es 
decir, que la cantidad que se vende sea mayor o igual a la cantidad existente del libro) y luego 
restar la cantidad vendida de la tabla "libros":*/
 create procedure pa_vender
  @codigo int=null,
  @cantidad int=1
  as
   --verificamos que el código exista
   if not exists (select *from libros where codigo=@codigo) or (@codigo is null)
     select 'Ingrese un codigo de libro válido'
   else
   begin --verificamos que haya stock
     declare @disponibles int
     select @disponibles= cantidad from libros where codigo=@codigo
     if (@disponibles<@cantidad)
       select 'Solo hay '+cast(@disponibles as varchar(10))+' disponibles'
     else
     begin
       declare @precio decimal(6,2) 
       select @precio= precio from libros where codigo=@codigo
       insert into ventas values(@codigo,@precio,@cantidad)
       update libros set cantidad=cantidad-@cantidad where @codigo=codigo
     end
   end;

--Este procedimiento recibe parámetros, declara variables locales y modifica 2 tablas, en una de ellas realiza una inserción y en la otra una actualización.

--8- Ejecute el procedimiento "pa_vender".
exec pa_vender 1,20;

--9- Vea si las tablas se modificaron:
 select *from ventas;
 select *from libros;

--10- Envíe al procedimiento "pa_vender" un código de libro inexistente.
 exec pa_vender 9;

--11- Envíe una cantidad que supere el stock

 exec pa_vender 5,250;
