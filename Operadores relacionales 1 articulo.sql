if object_id ('articulos') is not null
drop table articulos;


 create table articulos(
  codigo integer,
  nombre varchar(20),
  descripcion varchar(30),
  precio float,
  cantidad integer
 );

exec sp_columns articulos;

insert into articulos (codigo, nombre, descripcion, precio,cantidad)
  values (1,'impresora','Epson Stylus C45',400.80,20);
 insert into articulos (codigo, nombre, descripcion, precio,cantidad)
  values (2,'impresora','Epson Stylus C85',500,30);
 insert into articulos (codigo, nombre, descripcion, precio,cantidad)
  values (3,'monitor','Samsung 14',800,10);
 insert into articulos (codigo, nombre, descripcion, precio,cantidad)
  values (4,'teclado','ingles Biswal',100,50);
 insert into articulos (codigo, nombre, descripcion, precio,cantidad)
  values (5,'teclado','espa�ol Biswal',90,50);

  select * from articulos
  select * from articulos where nombre = 'impresora'; 
    select * from articulos where precio  >= 400 ;
	select codigo, nombre  from articulos where cantidad  < 30 ;
	/* ambas sentencia son not */
	select  nombre, descripcion  from articulos where precio  != 100; 
	select  nombre, descripcion  from articulos where precio  <> 100; 
	
	/* ambas sentencia son not */

	delete from articulos
	where precio >=500;

	delete from articulos
  where nombre='impresora';
  
  delete from articulos
  where codigo <> 4; 
  
  select * from articulos

	