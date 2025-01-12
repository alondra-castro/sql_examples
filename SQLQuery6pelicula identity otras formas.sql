if object_id('peliculas') is not null
  drop table peliculas;

 create table peliculas(
  codigo int identity (50,3),
  titulo varchar(40),
  actor varchar(20),
  duracion int
 );

 insert into peliculas (titulo,actor,duracion)
  values('Mision imposible','Tom Cruise',120);
 insert into peliculas (titulo,actor,duracion)
  values('Harry Potter y la piedra filosofal','Daniel R.',180);
 insert into peliculas (titulo,actor,duracion)
  values('Harry Potter y la camara secreta','Daniel R.',190);

 select * from peliculas;

 set identity_insert peliculas on;

 insert into peliculas (codigo,titulo,actor,duracion)
  values(20,'Mision imposible 2','Tom Cruise',120);

 insert into peliculas (codigo, titulo,actor,duracion)
  values(80,'La vida es bella','zzz',220);

 select ident_seed('peliculas');

 select ident_incr('peliculas');

 insert into peliculas (titulo,actor,duracion)
  values('Elsa y Fred','China Zorrilla',90);

 set identity_insert peliculas off; 

 insert into peliculas (titulo,actor,duracion)
  values('Elsa y Fred','China Zorrilla',90);
 select * from peliculas;