
 if object_id('medicamentos') is not null
  drop table medicamentos;


 create table medicamentos(
  codigo integer identity(10,1),
  nombre varchar(20) not null,
  laboratorio varchar(20),
  precio float,
  cantidad integer
 );


 insert into medicamentos (nombre, laboratorio,precio,cantidad)
   values('Sertal','Roche',5.2,100);
 insert into medicamentos (nombre, laboratorio,precio,cantidad)
  values('Buscapina','Roche',4.10,200);
 insert into medicamentos (nombre, laboratorio,precio,cantidad)
  values('Amoxidal 500','Bayer',15.60,100);


 select *from medicamentos;


set identity_insert medicamentos on;

--7- Ingrese un nuevo registro sin valor para el campo "codigo" (no lo permite):
 insert into medicamentos (nombre, laboratorio,precio,cantidad)
  values('Amoxilina 500','Bayer',15.60,100);

--8- Ingrese un nuevo registro con valor para el campo "codigo" repetido.

--9- Use la función "ident_seed()" para averiguar el valor de inicio del campo "identity" de la tabla 
--"medicamentos"
select ident_seed('medicamentos');


--10- Emplee la función "ident_incr()" para saber cuál es el valor de incremento del campo "identity" 
---de "medicamentos"


 select *from medicamentos
 insert into medicamentos (codigo, nombre, laboratorio,precio,cantidad)
  values(2,'Amoxilina 500','Bayer',15.60,100);
  select ident_incr('medicamentos');
 set identity_insert medicamentos off;

  select *from medicamentos