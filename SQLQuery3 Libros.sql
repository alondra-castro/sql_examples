if object_id ('libros') is not null
drop table libros;

create table libros(
	titulo varchar(80),
	autor varchar(40),
	editorial varchar (30),
	precio float,
	cantidad integer
);

exec sp_columns libros;

 insert into libros (titulo,autor,editorial, precio, cantidad)values ('El aleph','Borges','Planeta', 25.50, 100);
 insert into libros (titulo,autor,editorial, precio, cantidad)values ('Martin Fierro','Jose Hernandez','Emece', 10.20 ,100);
 insert into libros (titulo,autor,editorial, precio, cantidad)values ('Aprenda PHP','Mario Molina','Emece', 15.50, 25);
select * from libros;