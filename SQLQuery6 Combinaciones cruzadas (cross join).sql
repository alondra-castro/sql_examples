/*Una agencia matrimonial almacena la información de sus clientes de sexo femenino en una tabla 
llamada "mujeres" y en otra la de sus clientes de sexo masculino llamada "varones".
1- Elimine las tablas si existen y créelas:*/
 if object_id('mujeres') is not null
  drop table mujeres;
 if object_id('varones') is not null
  drop table varones;
 create table mujeres(
  nombre varchar(30),
  domicilio varchar(30),
  edad int
 );
 create table varones(
  nombre varchar(30),
  domicilio varchar(30),
  edad int
 );

--2- Ingrese los siguientes registros:
 insert into mujeres values('Maria Lopez','Colon 123',45);
 insert into mujeres values('Liliana Garcia','Sucre 456',35);
 insert into mujeres values('Susana Lopez','Avellaneda 98',41);

 insert into varones values('Juan Torres','Sarmiento 755',44);
 insert into varones values('Marcelo Oliva','San Martin 874',56);
 insert into varones values('Federico Pereyra','Colon 234',38);
 insert into varones values('Juan Garcia','Peru 333',50);

/*3- La agencia necesita la combinación de todas las personas de sexo femenino con las de sexo 
masculino. Use un "cross join" (12 registros)*/

 select m.nombre,m.edad,v.nombre,v.edad
  from mujeres as m
  cross join varones as v;

/*4- Realice la misma combinación pero considerando solamente las personas mayores de 40 años (6 
registros)*/
select m.nombre,m.edad,v.nombre,v.edad
  from mujeres as m
  cross join varones as v
  where m.edad>40 and
  v.edad>40;


/*5- Forme las parejas pero teniendo en cuenta que no tengan una diferencia superior a 10 años (8 
registros)*/
 select m.nombre,m.edad,v.nombre,v.edad
  from mujeres as m
  cross join varones as v
  where m.edad-v.edad between -10 and 10;


/*  Una empresa de seguridad almacena los datos de sus guardias de seguridad en una tabla llamada 
"guardias". también almacena los distintos sitios que solicitaron sus servicios en una tabla llamada 
"tareas".
1- Elimine las tablas "guardias" y "tareas" si existen:*/
 if object_id('guardias') is not null
  drop table guardias;
 if object_id('tareas') is not null
  drop table tareas;

--2- Cree las tablas:
 create table guardias(
  documento char(8),
  nombre varchar(30),
  sexo char(1), /* 'f' o 'm' */
  domicilio varchar(30),
  primary key (documento)
 );

 create table tareas(
  codigo tinyint identity,
  domicilio varchar(30),
  descripcion varchar(30),
  horario char(2), /* 'AM' o 'PM'*/
  primary key (codigo)
 );

--3- Ingrese los siguientes registros:
 insert into guardias values('22333444','Juan Perez','m','Colon 123');
 insert into guardias values('24333444','Alberto Torres','m','San Martin 567');
 insert into guardias values('25333444','Luis Ferreyra','m','Chacabuco 235');
 insert into guardias values('23333444','Lorena Viale','f','Sarmiento 988');
 insert into guardias values('26333444','Irma Gonzalez','f','Mariano Moreno 111');

 insert into tareas values('Colon 1111','vigilancia exterior','AM');
 insert into tareas values('Urquiza 234','vigilancia exterior','PM');
 insert into tareas values('Peru 345','vigilancia interior','AM');
 insert into tareas values('Avellaneda 890','vigilancia interior','PM');

/*4- La empresa quiere que todos sus empleados realicen todas las tareas. Realice una "cross join" (20 
registros)*/


 select nombre,t.domicilio,descripcion
  from guardias
  cross join tareas as t;

/*5- En este caso, la empresa quiere que todos los guardias de sexo femenino realicen las tareas de 
"vigilancia interior" y los de sexo masculino de "vigilancia exterior". Realice una "cross join" con 
un "where" que controle tal requisito (10 registros)*/

 select nombre,t.domicilio,descripcion
  from guardias as g
  cross join tareas as t
  where (g.sexo='f' and t.descripcion='vigilancia interior') or
  (g.sexo='m' and t.descripcion='vigilancia exterior');