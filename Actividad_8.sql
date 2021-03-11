use EMPRESA;

/*1*/
/*Todos los datos de todas las tablas*/
select * from Departamentos, Proyectos, Empleados, Asignacion;
/*Todos los datos de una tabla*/
select * from Departamentos;
select * from Proyectos;
select * from Empleados;
select * from Asignacion;

/*2*/
/*Lista Proyectos a partir de Marzo*/
select Fecha_ini as "Fecha de inicio del proyecto", Nombre
from Proyectos
where Fecha_ini >= '2018-03-01';

/*3*/
/*Lista todos Empleados con López como uno de los apellidos*/
select *
from Empleados
where Apellidos like '%López%';

/*4*/
/*Nombre de Proyecto asignado al empleado con id 10480*/
/*Dos Pasos*/
-- IdProy para el empleado con IdEmp = 10480
select IdProy 
from Asignacion
where IdEmp = 10480;
-- Obtenemos IdProy = 3
-- Nombre Proyecto con IdProy = 3
select Nombre
from Proyectos
where IdProy = 3;

/*Directamente*/
select Nombre
from Proyectos
where IdProy = (
	-- IdProy para el empleado con IdEmp = 10480
	select IdProy
	from Asignacion
	where IdEmp = 10480
    );

/*5*/
/*Listado Empleados de Madrid y Córdoba*/
/*Usando or*/
select * from Empleados
where Municipio = 'Madrid' or Municipio = 'Córdoba';
/*Usando in*/
select * from Empleados
where Municipio in ('Madrid', 'Córdoba');

/*6*/
/*Empleados con sueldo entre 1300 y 1550*/
select * from Empleados
where Sueldo between 1300 and 1550;

/*7*/
/*Empleados con fecha nac posterior a 1976 ordenados de forma descendente*/
select * from Empleados
where year(Fecha_nac) > 1976
order by Fecha_nac desc;

/*8*/
/*Actualizar el campo presupuesto para Marketing*/
-- Comprobamos el valor actual*/
select * from Departamentos
where Nombre = 'Marketing';
-- Sumamos 5000 al presupuesto de Marketing
update Departamentos
set Presupuesto = Presupuesto + 5000
where Nombre = 'Marketing';
-- Comprobamos el nuevo valor
select * from Departamentos
where Nombre = 'Marketing';

/*9*/
/*Cambiar a Alberto Pérez López al proyecto RUNTA*/
-- Comprobar el valor inicial
select * from Asignacion;
-- Modificación
update Asignacion
set IdProy = (
	-- IdProy cuyo nombre es RUNTA
	select IdProy
    from Proyectos
    where Nombre = 'RUNTA'
    )
where IdEmp = (
	-- IdEmp llamado Alberto Pérez López
	select IdEmp
    from Empleados
    where Nombre = 'Alberto' and Apellidos = 'Pérez López'
    );
-- Comprobar el cambio
select * from Asignacion;

/*10*/
/*Eliminar a Antonio García Montero del proyecto asignado*/
-- Comprobación anterior
select * from Asignacion;
-- Eliminamos la asignación de Antonio
delete from Asignacion
where IdEmp = (
	-- IdEmp llamdao Antonio García Montero
	select IdEmp
    from Empleados
    where Nombre = 'Antonio' and Apellidos = 'García Montero'
    );
-- Comprobación posterior
select * from Asignacion;

/*11*/
/*Empleados del departamento de Diseño con sueldo mayor de 1500*/
select * from Empleados
where IdDpto = (
	select IdDpto from Departamentos
    where Nombre = 'Diseño'
    )
    and Sueldo >= 1500;
    
/*12*/
/*Incrementar Sueldo 5% para los empleados de I+D con sueldo inferior a 1400*/
-- Comprobamos el valor inicial
select IdEmp, Sueldo, IdDpto from Empleados;
-- Hacemos la modificacion
update Empleados
set Sueldo = Sueldo * 1.05
where Sueldo < 1400 
	and IdDpto = (
		-- IdDpto con Nombre 'I+D'
		select IdDpto from Departamentos
		where Nombre = 'I+D'
        );
-- Comprobamos los cambios
select IdEmp, Sueldo, IdDpto from Empleados;
