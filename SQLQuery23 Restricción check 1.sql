 if object_id('empleados') is not null
  drop table empleados;

 create table empleados (
  documento varchar(8),
  nombre varchar(30),
  fechanacimiento datetime,
  cantidadhijos tinyint,
  seccion varchar(20),
  sueldo decimal(6,2)
 );

 alter table empleados
   add constraint CK_empleados_sueldo_positivo
   check (sueldo>0);

 insert into empleados values ('22222222','Alberto Lopez','1965/10/05',1,'Sistemas',1000);
 insert into empleados values ('33333333','Beatriz Garcia','1972/08/15',2,'Administracion',3000);
 insert into empleados values ('34444444','Carlos Caseres','1980/10/05',0,'Contadur�a',6000);

 alter table empleados
   add constraint CK_empleados_sueldo_maximo
   check (sueldo<=5000);

 delete from empleados where sueldo=6000;

 alter table empleados
   add constraint CK_empleados_sueldo_maximo
   check (sueldo<=5000); 

 alter table empleados
   add constraint CK_fechanacimiento_actual
   check (fechanacimiento<getdate());

 alter table empleados
   add constraint CK_empleados_seccion_lista
   check (seccion in ('Sistemas','Administracion','Contaduria'));

 alter table empleados
   add constraint CK_cantidadhijos_valores
   check (cantidadhijos between 0 and 15);

 exec sp_helpconstraint empleados;

 insert into empleados
  values ('24444444','Carlos Fuentes','1980/02/05',2,'Administracion',-1500);

 insert into empleados
  values ('25555555','Daniel Garcia','2007/05/05',2,'Sistemas',1550);

 update empleados set cantidadhijos=21 where documento='22222222';

 update empleados set seccion='Recursos' where documento='22222222';

 alter table empleados
   add constraint CK_seccion_letrainicial
   check (seccion like '%B');
