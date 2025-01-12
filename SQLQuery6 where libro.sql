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
 insert into libros (titulo,autor,editorial, precio, cantidad)values ('Martin Fierro','Jose Hernandez','Planeta', 10.20 ,100);
 insert into libros (titulo,autor,editorial, precio, cantidad)values ('Aprenda PHP','Mario Molina','Emece', 15.50, 25);
  insert into libros (titulo, autor, editorial, precio, cantidad)
  values ('Cervantes y el quijote','Borges','Emece',25,100);
 insert into libros (titulo, autor, editorial, precio,cantidad)
  values ('Matematica estas ahi','Paenza','Siglo XXI',15,120);

select * from libros where autor = 'Borges';

select titulo from libros where editorial = 'Emece';
select editorial from libros where titulo = 'Martin Fierro';



--4- Muestre todos los registros (5 registros):
 select * from libros;

--5- Modifique los registros cuyo autor sea igual  a "Paenza", por "Adrian Paenza" (1 registro 
--afectado)
 update libros set autor='Adrian Paenza'
  where autor='Paenza';

  select * from libros;
--6- Nuevamente, modifique los registros cuyo autor sea igual  a "Paenza", por "Adrian Paenza" (ningún registro afectado porque ninguno cumple la condición)
 update libros set autor='Adrian Paenza'
  where autor='Paenza';

  select * from libros;
--7- Actualice el precio del libro de "Mario Molina" a 27 pesos (1 registro afectado):
 update libros set precio=27
 where autor='Mario Molina';

 select * from libros;
--8- Actualice el valor del campo "editorial" por "Emece S.A.", para todos los registros cuya editorial sea igual a "Emece" (3 registros afectados):
 update libros set editorial='Emece S.A.'
  where editorial='Emece';

  select * from libros;
--9 - Luego de cada actualización ejecute un select que mustre todos los registros de la tabla