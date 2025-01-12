 if object_id('alumnos') is not null
  drop table alumnos;

create table alumnos(
  legajo varchar(4) not null,
  documento varchar(8) primary key(documento),
  nombre varchar(30),
  domicilio varchar(30)
  
  
 );
 exec sp_columns alumnos;

  insert into alumnos (legajo,documento,nombre,domicilio)
  values('A233','22345345','Perez Mariana','Colon 234');
 insert into alumnos (legajo,documento,nombre,domicilio)
  values('A567','23545345','Morales Marcos','Avellaneda 348');

  select *from alumnos;