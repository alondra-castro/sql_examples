


if object_id('usuarios') is not null
	drop table usuarios;

create table usuarios(
nombre varchar(30),
clave varchar (10)
);

exec sp_tables @table_owner='dbo';

exec sp_columns usuarios;
drop table usuarios;

exec sp_tables @table_owner='dbo';