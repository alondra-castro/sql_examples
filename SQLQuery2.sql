if object_id ('usuarios') is not null
drop table usuarios;

create table usuarios(
	nombre varchar(30),
	clave varchar(10)
);

insert into usuarios(nombre, clave) values ('Maria','123abc');

select * from usuarios;

insert into usuarios(nombre, clave) values ('Ane','hola12');

select * from usuarios;

