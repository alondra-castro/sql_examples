if object_id ('peliculas') is not null
drop table peliculas;

create table peliculas(
	titulo varchar(20),
  actor varchar(20),
  duracion integer,
  cantidad integer
);

exec sp_columns peliculas;

insert into peliculas (titulo, actor, duracion, cantidad)
  values ('Mision imposible','Tom Cruise',120,3);
 insert into peliculas (titulo, actor, duracion, cantidad)
  values ('Mision imposible 2','Tom Cruise',180,4);
 insert into peliculas (titulo, actor, duracion, cantidad)
  values ('Mujer bonita','Julia R.',90,1);
 insert into peliculas (titulo, actor, duracion, cantidad)
  values ('Elsa y Fred','China Zorrilla',80,2);


  select * from peliculas;
  select titulo, actor from peliculas;
    select titulo, duracion from peliculas;
	  select titulo, cantidad from peliculas;

	  select * from peliculas where duracion < = 90;
	  select titulo from peliculas where actor <> 'Tom Cruise';
	   select titulo, actor,  cantidad from peliculas where cantidad > 2 ;

