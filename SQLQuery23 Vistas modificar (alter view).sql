/*Un club dicta cursos de distintos deportes. Almacena la información en varias tablas.
1- Elimine las tabla "inscriptos", "socios" y "cursos", si existen:*/
 if object_id('inscriptos') is not null  
  drop table inscriptos;
 if object_id('socios') is not null  
  drop table socios;
 if object_id('cursos') is not null  
  drop table cursos;

--2- Cree las tablas:
 create table socios(
  documento char(8) not null,
  nombre varchar(40),
  domicilio varchar(30),
  constraint PK_socios_documento
   primary key (documento)
 );

 create table cursos(
  numero tinyint identity,
  deporte varchar(20),
  dia varchar(15),
   constraint CK_inscriptos_dia check (dia in('lunes','martes','miercoles','jueves','viernes','sabado')),
  profesor varchar(20),
  constraint PK_cursos_numero
   primary key (numero),
 );

 create table inscriptos(
  documentosocio char(8) not null,
  numero tinyint not null,
  matricula char(1),
  constraint PK_inscriptos_documento_numero
   primary key (documentosocio,numero),
  constraint FK_inscriptos_documento
   foreign key (documentosocio)
   references socios(documento)
   on update cascade,
  constraint FK_inscriptos_numero
   foreign key (numero)
   references cursos(numero)
   on update cascade
  );

--3- Ingrese algunos registros para todas las tablas:
 insert into socios values('30000000','Fabian Fuentes','Caseros 987');
 insert into socios values('31111111','Gaston Garcia','Guemes 65');
 insert into socios values('32222222','Hector Huerta','Sucre 534');
 insert into socios values('33333333','Ines Irala','Bulnes 345');

 insert into cursos values('tenis','lunes','Ana Acosta');
 insert into cursos values('tenis','martes','Ana Acosta');
 insert into cursos values('natacion','miercoles','Ana Acosta');
 insert into cursos values('natacion','jueves','Carlos Caseres');
 insert into cursos values('futbol','sabado','Pedro Perez');
 insert into cursos values('futbol','lunes','Pedro Perez');
 insert into cursos values('basquet','viernes','Pedro Perez');

 insert into inscriptos values('30000000',1,'s');
 insert into inscriptos values('30000000',3,'s');
 insert into inscriptos values('30000000',6,null);
 insert into inscriptos values('31111111',1,'n');
 insert into inscriptos values('31111111',4,'s');
 insert into inscriptos values('32222222',1,'n');
 insert into inscriptos values('32222222',7,'n');

--4- Elimine la vista "vista_deudores" si existe:
 if object_id('vista_deudores') is not null
  drop view vista_deudores;

/*5- Cree la vista "vista_deudores" que muestre el documento y nombre del socio, el deporte, el día y 
la matrícula, de todas las inscripciones no pagas colocando "with check option".*/

 create view vista_deudores
 as
  select documento,nombre,c.deporte,c.dia,matricula
  from socios as s
  join inscriptos as i
  on documento=documentosocio
  join cursos as c
  on c.numero=i.numero
  where matricula='n'
  with check option;

--6- Consulte la vista:
 select * from vista_deudores;

--7- Veamos el texto de la vista.
 sp_helptext vista_deudores;

--8- Intente actualizar a "s" la matrícula de una inscripción desde la vista. No lo permite por la opción "with check option".
 update vista_deudores set matricula='s' where documento='31111111';

--9- Modifique el documento de un socio mediante la vista.
 update vista_deudores set documento='31111113' where documento='31111111';

--10- Vea si se alteraron las tablas referenciadas en la vista:
 select * from socios;
 select * from inscriptos;

--11- Modifique la vista para que muestre el domicilio, coloque la opción de encriptación y omita "with check option".
alter view vista_deudores
  with encryption
 as
  select documento,nombre,domicilio,c.deporte,c.dia,matricula
  from socios as s
  join inscriptos as i
  on documento=documentosocio
  join cursos as c
  on c.numero=i.numero
  where matricula='n';

--12- Consulte la vista para ver si se modificó:
 select * from vista_deudores;
--Aparece el nuevo campo.

--13- Vea el texto de la vista.No lo permite porque está encriptada.
 sp_helptext vista_deudores;

--14- Actualice la matrícula de un inscripto.Si se permite porque la opción "with check option" se quitó de la vista
 update vista_deudores set matricula='s' where documento='31111113';

--15- Consulte la vista:
 select * from vista_empleados;
--Note que el registro modificado ya no aparece porque la matrícula está paga.

--16- Elimine la vista "vista_socios" si existe:
 if object_id('vista_socios') is not null
  drop view vista_socios;

--17- Cree la vista "vista_socios" que muestre todos los campos de la tabla "socios".
create view vista_socios
 as
  select *from socios;
--18- Consulte la vista.
 select *from vista_socios;

--19- Agregue un campo a la tabla "socios".
 alter table socios
 add telefono char(10);
--20- Consulte la vista "vista_socios".El nuevo campo agregado a "socios" no aparece, pese a que la vista indica que muestre todos los campos de dicha tabla.
 select *from vista_socios;

--21- Altere la vista para que aparezcan todos los campos.
alter view vista_socios
 as
  select *from socios;
--22- Consulte la vista
 select *from vista_socios; 
