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
 insert into inscriptos values('30000000',3,'n');
 insert into inscriptos values('30000000',6,null);
 insert into inscriptos values('31111111',1,'s');
 insert into inscriptos values('31111111',4,'s');
 insert into inscriptos values('32222222',1,'s');
 insert into inscriptos values('32222222',7,'s');

--4- Realice un join para mostrar todos los datos de todas las tablas, sin repetirlos:
 select documento,nombre,domicilio,c.numero,deporte,dia, profesor,matricula
  from socios as s
  join inscriptos as i
  on s.documento=documentosocio
  join cursos as c
  on c.numero=i.numero;

--5- Elimine, si existe, la vista "vista_cursos":
 if object_id('vista_cursos') is not null
  drop view vista_cursos;

--6- Cree la vista "vista_cursos" que muestre el número, deporte y día de todos los cursos.
 create view vista_cursos
  as
  select numero,deporte,dia
   from cursos;
--7- Consulte la vista ordenada por deporte.
 select *from vista_cursos order by deporte;

--8- Ingrese un registro en la vista "vista_cursos" y vea si afectó a "cursos".Puede realizarse el ingreso porque solamente afecta a una tabla base.
insert into vista_cursos values('futbol','martes');
 select * from cursos;

--9- Actualice un registro sobre la vista y vea si afectó a la tabla "cursos". Puede realizarse la actualización porque solamente afecta a una tabla base.
update vista_cursos set dia='miercoles' where numero=8;
 select *from cursos;

--10- Elimine un registro de la vista para el cual no haya inscriptos y vea si afectó a "cursos".Puede realizarse la eliminación porque solamente afecta a una tabla base.
delete from vista_cursos where numero=8;
 select * from cursos;
--11- Intente eliminar un registro de la vista para el cual haya inscriptos.No lo permite por la restricción "foreign key".
 delete from vista_cursos where numero=1;

--12- Elimine la vista "vista_inscriptos" si existe y créela para que muestre el documento y nombre del socio, el numero de curso, el deporte y día de los cursos en los cuales está inscripto.
if object_id('vista_inscriptos') is not null
  drop view vista_inscriptos;
 create view vista_inscriptos
  as
  select i.documentosocio,s.nombre,i.numero,c.deporte,dia
  from inscriptos as i
  join socios as s
  on s.documento=documentosocio
  join cursos as c
  on c.numero=i.numero;
--13- Intente ingresar un registro en la vista.No lo permite porque la modificación afecta a más de una tabla base. 
 insert into vista_inscriptos values('32222222','Hector Huerta',6,'futbol','lunes');

--14- Actualice un registro de la vista.Lo permite porque la modificación afecta a una sola tabla base.
 update vista_inscriptos set nombre='Fabio Fuentes' where nombre='Fabian Fuentes';

--15- Vea si afectó a la tabla "socios":
 select * from socios;

--16- Intente actualizar el documento de un socio.No lo permite por la restricción.
 update vista_inscriptos set documentosocio='30000111' where documentosocio='30000000';

--17- Intente eliminar un registro de la vista.No lo permite porque la vista incluye varias tablas.

 delete from vista_inscriptos where documentosocio='30000111' and deporte='tenis';
