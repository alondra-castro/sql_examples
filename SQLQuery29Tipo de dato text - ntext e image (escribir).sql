/*n una p�gina web se guardan los siguientes datos de las visitas: n�mero de visita, nombre, mail, 
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

--4- Recupere todos los registros:
 select *from visitas;

--5- Reemplace el texto del campo "comentarios" del registro con n�mero 3.
 declare @puntero binary(16)
 select @puntero = textptr (comentarios)
  from visitas
  where numero=3
 
  writetext visitas.comentarios @puntero 'Esta p�gina es excelente, no hay otra mejor.';

--6- Lea el campo "comentarios" de la visita n�mero 3 para ver si se actualiz�.
declare @puntero binary(16)
 select @puntero = textptr (comentarios)
  from visitas
  where numero=3
 
 readtext visitas.comentarios @puntero 0 0;
--7- Intente actualizar el campo "text" de la visita n�mero 1.Error, puntero inv�lido.
declare @puntero varbinary(16)
 select @puntero=textptr(comentarios) 
  from visitas where numero=1

 writetext visitas.comentarios @puntero 'Es una muy buena p�gina, pero tiene algunos errores.';

--8- Vuelva a intentar la actualizaci�n del punto anterior pero controlando que el puntero sea v�lido.
 declare @puntero varbinary(16)
 select @puntero=textptr(comentarios) 
  from visitas where numero=1
 if (textvalid('visitas.comentarios', @puntero)=1)
  writetext visitas.comentarios @puntero 'Es una muy buena p�gina, pero tiene algunos errores.'
 else select 'puntero invalido, no se actualiz� el registro';

--9- Ingrese un nuevo registro con cadena vac�a para el campo "comentarios":
 insert into visitas values ('Salvador Quiroga','salvador@hotmail.com','Argentina','2006-09-09 18:25','');

--10- Actualice el campo "comentarios" del registro ingresado anteriormente.
declare @puntero varbinary(16)
 select @puntero=textptr(comentarios) 
  from visitas where nombre='Salvador Quiroga'
 if (textvalid('visitas.comentarios', @puntero)=1)
  writetext visitas.comentarios @puntero 'Es una p�gina m�s que interesante.';

--11- Verifique que se actualiz�.

declare @puntero binary(16)
 select @puntero = textptr (comentarios)
  from visitas
  where nombre='Salvador Quiroga'
 
  readtext visitas.comentarios @puntero 0 0;