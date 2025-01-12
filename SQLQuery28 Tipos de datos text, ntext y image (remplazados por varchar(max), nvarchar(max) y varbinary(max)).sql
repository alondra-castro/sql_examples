/*En una página web se guardan los siguientes datos de las visitas: número de visita, nombre, mail, 
pais, fecha.
1- Elimine la tabla "visitas", si existe:*/
 if object_id('visitas') is not null
  drop table visitas;

--2- Créela con la siguiente estructura:
 create table visitas (
  numero int identity,
  nombre varchar(30),
  mail varchar(50),
  pais varchar (20),
  fecha datetime
  constraint DF_visitas_fecha default getdate(),
  comentarios text
  constraint DF_visitas_comentarios default 'Ninguno',
  constraint PK_visitas
  primary key(numero)
);

--3- Ingrese algunos registros:
 insert into visitas values ('Ana Maria Lopez','AnaMaria@hotmail.com','Argentina','2006-10-10 10:10',null);
 insert into visitas values ('Gustavo Gonzalez','GustavoGGonzalez@hotmail.com','Chile','2006-10-10 21:30',default);
 insert into visitas values ('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico',default,'Excelente página');
 insert into visitas values ('Mariano Perez','PerezM@hotmail.com','Argentina','2006-11-11 14:30','Muy buena y divertida');

--4- Recupere todos los registros:
 select * from visitas;

--5- Cuente la cantidad de visitas que tienen comentarios.Retorna 3.
select count(*)
  from visitas
  where comentarios is not null;

--6- Intente agregar una restricción "check" al campo de tipo "text":
 alter table visitas
  add constraint CK_comentarios
  check (comentarios not like '[0-9]%');
--No lo permite.

--7- Intente alterar el campo de tipo "text" para que no acepte valores nulos:
 alter table visitas
  alter column comentarios text not null;
--No lo permite.

--8- Elimine la regla llamada "RG_texto" (si existe):
 if object_id('RG_texto') is not null
  drop rule RG_texto;

--9- Cree la regla "RG_texto" que no permita que el primer caracter sea un dígito:
 create rule RG_texto
 as @valor not like '[0-9]%';

--10- Asóciela al campo "nombre":
 exec sp_bindrule RG_texto, 'visitas.nombre';

--11- Intente asociarla al campo "comentarios":
 exec sp_bindrule RG_texto, 'visitas.comentarios';
--No lo permite.

--12- Quite la restricción "default" del campo "comentarios":
 alter table visitas
  drop DF_visitas_comentarios;

--13- Ingrese un registro con valores por defecto y recupere todos los registros:
 insert into visitas default values;
 select * from visitas;

--14- Elimine el valor predeterminado llamado "VP_SinComentarios":
 if object_id('VP_Sincomentarios') is not null
  drop default VP_Sincomentarios;

--15- Cree un valor por defecto que almacene el valor "Sin comentarios":
 create default VP_Sincomentarios
  as 'Sin comentarios';

--16- Asócielo al campo "comentarios":
 exec sp_bindefault VP_Sincomentarios, 'visitas.comentarios';

--17- Ingrese un registro con valores por defecto y recupere todos los registros:
 insert into visitas default values;
 select * from visitas;

--18- Borre la tabla y creela nuevamente con el campo comentarios con tipo varchar(max)

 if object_id('visitas') is not null
  drop table visitas;

 create table visitas (
  numero int identity,
  nombre varchar(30),
  mail varchar(50),
  pais varchar (20),
  fecha datetime
  constraint DF_visitas_fecha default getdate(),
  comentarios varchar(max)
  constraint DF_visitas_comentarios default 'Ninguno',
  constraint PK_visitas
  primary key(numero)
);

 insert into visitas values ('Ana Maria Lopez','AnaMaria@hotmail.com','Argentina','2006-10-10 10:10',null);
 insert into visitas values ('Gustavo Gonzalez','GustavoGGonzalez@hotmail.com','Chile','2006-10-10 21:30',default);
 insert into visitas values ('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico',default,'Excelente página');
 insert into visitas values ('Mariano Perez','PerezM@hotmail.com','Argentina','2006-11-11 14:30','Muy buena y divertida');

 select * from visitas;