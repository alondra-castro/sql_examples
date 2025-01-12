/*Un profesor almacena el documento, nombre y la nota final de cada alumno de su clase en una tabla 
llamada "alumnos".
1- Elimine la tabla, si existe:*/
 if object_id('alumnos') is not null
  drop table alumnos;

/*2- Créela con los campos necesarios. Agregue una restricción "primary key" para el campo "documento" 
y una "check" para validar que el campo "nota" se encuentre entre los valores 0 y 10:*/
 create table alumnos(
  documento char(8),
  nombre varchar(30),
  nota decimal(4,2),
  primary key(documento),
  constraint CK_alumnos_nota_valores check (nota>=0 and nota <=10),
 );

--3-Ingrese algunos registros:
 insert into alumnos values('30111111','Ana Algarbe',5.1);
 insert into alumnos values('30222222','Bernardo Bustamante',3.2);
 insert into alumnos values('30333333','Carolina Conte',4.5);
 insert into alumnos values('30444444','Diana Dominguez',9.7);
 insert into alumnos values('30555555','Fabian Fuentes',8.5);
 insert into alumnos values('30666666','Gaston Gonzalez',9.70);

/*4- Obtenga todos los datos de los alumnos con la nota más alta, empleando subconsulta.
2 registros.*/
select alumnos.*
  from alumnos
  where nota=
   (select max(nota) from alumnos);


/*5- Realice la misma consulta anterior pero intente que la consulta interna retorne, además del 
máximo valor de nota, el nombre. 
Mensaje de error, porque la lista de selección de una subconsulta que va luego de un operador de 
comparación puede incluir sólo un campo o expresión (excepto si se emplea "exists" o "in").*/
 select documento ,nombre, nota
  from alumnos
  where nota=
   (select nombre,max(nota) from alumnos);

 
/*6- Muestre los alumnos que tienen una nota menor al promedio, su nota, y la diferencia con el 
promedio.
3 registros.*/
select alumnos.*,
 (select avg(nota) from alumnos)-nota as diferencia
  from alumnos
  where nota<
   (select avg(nota) from alumnos);


/*7- Cambie la nota del alumno que tiene la menor nota por 4.
1 registro modificado.*/
 update alumnos set nota=4
  where nota=
   (select min(nota) from alumnos);

/*8- Elimine los alumnos cuya nota es menor al promedio.
3 registros eliminados.*/
 delete from alumnos
 where nota<
   (select avg(nota) from alumnos);