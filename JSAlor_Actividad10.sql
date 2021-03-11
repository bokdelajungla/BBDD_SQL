/*Actividad 10 BBDD. Elementos base de datos*/
/*Jorge Sánchez-Alor Expósito*/

/*1*//*Cambiar nombre tabla DEPARTMENTS por dept*/
ALTER TABLE HR.departments RENAME TO dept;

/*2*//*Añadir una nueva columna a la tabla HR.JOBS que sea Skills,
        para saber qué habilidades tiene el empleado y será de tipo cadena.*/
ALTER TABLE HR.jobs ADD (Skills VARCHAR(20));

/*3*//*Cambiar el tamaño del campo country_id de 
        HRLOCATIONS por un tamaño de 50.*/
ALTER TABLE HR.locations ADD(Country_id2 CHAR(50));
UPDATE HR.locations SET Country_id2 = Country_id;
--
ALTER TABLE HR.countries MODIFY(country_id CHAR(50));

/*4*//*Añadir la restricción de no permitir salario menor de 0 
        en la tabla HR.EMPLOYEES en el campo salary.*/
ALTER TABLE HR.employees
ADD CONSTRAINT check_salary CHECK (salary >= 0);

/*5*//*Añadir la restricción de NOT NULL en campo department_name 
        de la tabla HR_DEPARTAMENTS.*/
/*Ya está esta restricción así que la quitamos y la volvemos a poner*/
ALTER TABLE HR.departments
MODIFY department_name VARCHAR2(30 BYTE) NULL;
ALTER TABLE HR.departments
MODIFY department_name VARCHAR2(30 BYTE) NOT NULL;

/*6*//*Crear otra vista llamada sueldos_suma que muestre los nombres de los 
        departamentos y la suma de los sueldos de los empleados masculinos 
        agrupados por departamentos.*/
        /*[Se ha considerado que los empleados masculinos son los que tienen 
        un id de empleado PAR]*/
--Creamos una columna de sexo: CHAR(1) M o F
ALTER TABLE HR.employees ADD(Sex CHAR(1));
ALTER TABLE HR.employees ADD CONSTRAINT check_sex CHECK (Sex IN('M','F'));
UPDATE HR.employees SET sex ='M' WHERE( MOD(employee_id,2) = 0);
UPDATE HR.employees SET sex ='F' WHERE( MOD(employee_id,2) <> 0);

--Creamos la vista
CREATE VIEW sueldos_suma (DEPARTAMENTO, SALARIOS_MASCULINOS) AS
(SELECT department_name, sum(salary)
FROM HR.departments D 
JOIN HR.employees E  
ON E.department_id = D.department_id
WHERE (sex = 'M')
GROUP BY department_name);

SELECT * FROM sueldos_suma;

/*7*//*Inserta un nuevo departamento, deshaciendo la entrada del nuevo 
        departamento después, usando transacciones.*/
INSERT INTO HR.departments 
(DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) 
values ('1000','Tester','200','1700');
ROLLBACK;

/*Deshacer los cambios*/
/*
ALTER TABLE HR.dept RENAME TO departments;
ALTER TABLE HR.jobs DROP COLUMN Skills;
ALTER TABLE HR.locations DROP COLUMN Country_id2;
ALTER TABLE HR.employees DROP CONSTRAINT check_salary;
ALTER TABLE HR.departments
ADD CONSTRAINT "DEPT_NAME_NN" CHECK (department_name <> NULL);
DROP VIEW sueldos_suma;
*/