/*Una empresa registra los datos de sus clientes en una tabla llamada "clientes". Dicha tabla contiene 
un campo que hace referencia al cliente que lo recomend� denominado "referenciadopor". Si un cliente 
no ha sido referenciado por ning�n otro cliente, tal campo almacena "null".
1- Elimine la tabla si existe y cr�ela:*/
 if object_id('clientes') is not null
  drop table clientes;
 create table clientes(
  codigo int not null,
  nombre varchar(30),
  domicilio varchar(30),
  ciudad varchar(20),
  referenciadopor int,
  primary key(codigo)
 );

--2- Ingresamos algunos registros:
 insert into clientes values (50,'Juan Perez','Sucre 123','Cordoba',null);
 insert into clientes values(90,'Marta Juarez','Colon 345','Carlos Paz',null);
 insert into clientes values(110,'Fabian Torres','San Martin 987','Cordoba',50);
 insert into clientes values(125,'Susana Garcia','Colon 122','Carlos Paz',90);
 insert into clientes values(140,'Ana Herrero','Colon 890','Carlos Paz',9);

/*3- Intente agregar una restricci�n "foreign key" para evitar que en el campo "referenciadopor" se 
ingrese un valor de c�digo de cliente que no exista.
No se permite porque existe un registro que no cumple con la restricci�n que se intenta establecer.*/

alter table clientes
  add constraint FK_clientes_referenciadopor
  foreign key (referenciadopor)
  references clientes (codigo);



/*4- Cambie el valor inv�lido de "referenciadopor" del registro que viola la restricci�n por uno 
v�lido.*/

update clientes set referenciadopor=90 where referenciadopor=9;

--5- Agregue la restricci�n "foreign key" que intent� agregar en el punto 3.



 alter table clientes
  add constraint FK_clientes_referenciadopor
  foreign key (referenciadopor)
  references clientes (codigo);
--6- Vea la informaci�n referente a las restricciones de la tabla "clientes".


 exec sp_helpconstraint clientes;

--7- Intente agregar un registro que infrinja la restricci�n.No lo permite.


 insert into clientes values(150,'Karina Gomez','Caseros 444','Cruz del Eje',8);

--8- Intente modificar el c�digo de un cliente que est� referenciado en "referenciadopor".No se puede.


 update clientes set codigo=180 where codigo=90;

--9- Intente eliminar un cliente que sea referenciado por otro en "referenciadopor".No se puede.

 

 delete from clientes where nombre='Marta Juarez';

--10- Cambie el valor de c�digo de un cliente que no referenci� a nadie.


 update clientes set codigo=180 where codigo=125;

--11- Elimine un cliente que no haya referenciado a otros.



 delete from clientes where codigo=110;