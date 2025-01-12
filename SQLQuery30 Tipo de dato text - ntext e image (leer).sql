/*En una p�gina web se guardan los siguientes datos de las visitas: n�mero de visita, nombre, mail, 
pais, fecha.
1- Elimine la tabla "visitas", si existe:*/
 if object_id('visitas') is not null
  drop table visitas;

--2- Cr�ela con la siguiente estructura:
 create table visitas (
  numero int identity,
  nombre varchar(30),
  mail varchar(50),
  pais varchar (20),
  fecha datetime
  constraint DF_visitas_fecha default getdate(),
  comentarios text,
  constraint PK_visitas
  primary key(numero)
);

--3- Ingrese algunos registros:
 insert into visitas values ('Ana Maria Lopez','AnaMaria@hotmail.com','Argentina','2006-10-10 10:10',null);
 insert into visitas values ('Gustavo Gonzalez','GustavoGGonzalez@hotmail.com','Chile','2006-10-10 21:30',default);
 insert into visitas values ('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico',default,'Excelente p�gina');
 insert into visitas values ('Mariano Perez','PerezM@hotmail.com','Argentina','2006-11-11 14:30','Muy buena y divertida');

--4- Leemos la informaci�n almacenada en el campo "comentarios" de "visitas" del registro n�mero 3, desde la posici�n 0, 10 caracteres.
declare @puntero varbinary(16)
 select @puntero=textptr(comentarios) 
  from visitas
  where numero=3
 readtext visitas.comentarios @puntero 0 10;


--5- Intente leer el campo "comentarios" del registro n�mero 1.Error, porque el puntero es inv�lido.
 declare @puntero varbinary(16)
 select @puntero=textptr(comentarios) 
  from visitas
  where numero=1
 readtext visitas.comentarios @puntero 0 10;


--6- Recupere el campo "comentarios" de la visita n�mero 1 (desde el comienzo al final), controlando que el puntero sea v�lido.

 declare @puntero varbinary(16)
 select @puntero=textptr(comentarios) 
  from visitas where numero=1
 if (textvalid('visitas.comentarios', @puntero)=1)
  readtext visitas.comentarios @puntero 0 0
 else select 'puntero invalido';