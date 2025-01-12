/*Un club dicta clases de distintos deportes a sus socios. El club tiene una tabla llamada "deportes" 
en la cual almacena el nombre del deporte, el nombre del profesor que lo dicta, el día de la semana 
que se dicta y el costo de la cuota mensual.
1- Elimine la tabla si existe:*/
 if object_id('deportes') is not null
  drop table deportes;

--2- Cree la tabla:
 create table deportes(
  nombre varchar(15),
  profesor varchar(30),
  dia varchar(10),
  cuota decimal(5,2),
 );
 
--3- Ingrese algunos registros. Incluya profesores que dicten más de un curso:
 insert into deportes values('tenis','Ana Lopez','lunes',20);
 insert into deportes values('natacion','Ana Lopez','martes',15);
 insert into deportes values('futbol','Carlos Fuentes','miercoles',10);
 insert into deportes values('basquet','Gaston Garcia','jueves',15);
 insert into deportes values('padle','Juan Huerta','lunes',15);
 insert into deportes values('handball','Juan Huerta','martes',10);

--4- Muestre los nombres de los profesores que dictan más de un deporte empleando subconsulta.
  select distinct d1.profesor
  from deportes as d1
  where d1.profesor in
  (select d2.profesor
    from deportes as d2 
    where d1.nombre <> d2.nombre);

 select distinct d1.profesor
  from deportes as d1
  join deportes as d2
  on d1.profesor=d2.profesor
  where d1.nombre<>d2.nombre;
/*6- Buscamos todos los deportes que se dictan el mismo día que un determinado deporte (natacion) 
empleando subconsulta.*/
select nombre
  from deportes
  where nombre<>'natacion' and
  dia =
   (select dia
     from deportes
     where nombre='natacion');

--7- Obtenga la misma salida empleando "join".

 select d1.nombre
  from deportes as d1
  join deportes as d2
  on d1.dia=d2.dia
  where d2.nombre='natacion' and
  d1.nombre<>d2.nombre;