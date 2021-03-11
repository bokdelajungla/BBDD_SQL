/*Actividad 9 BBDD. Sentencias SQL avanzadas*/
/*Jorge Sánchez-Alor Expósito*/

/*1*/
/*Muestre el salario más alto, más bajo, salario total y salario promedio 
por cada tipo de puesto que se tiene en la organización.*/
SELECT job_title AS PUESTO,
    MIN(salary) AS MAS_BAJO, MAX(salary) AS MAS_ALTO,
    AVG(salary) AS PROMEDIO, SUM(salary) AS TOTAL
FROM HR.jobs J JOIN HR.employees E on J.job_id = E.job_id
GROUP BY J.job_title;

/*2*/
/*Escriba una consulta que muestre la cantidad de personas que tienen 
el mismo puesto y a cuánto asciende la suma total de sus salarios. 
El resultado debe mostrarse en orden descendente por el puesto 
que tiene la mayor cantidad de empleados.*/
SELECT job_title AS PUESTO,
    COUNT (E.employee_id) AS PERSONAS, SUM(salary) AS SALARIOS
FROM HR.jobs J JOIN HR.employees E on J.job_id = E.job_id
GROUP BY J.job_title
ORDER BY PERSONAS DESC;

/*3*/
/*Escriba una consulta para mostrar la diferencia entre el salario más alto
y el salario más bajo. Etiquete la columna como «Diferencia Salarial». */
/*3a*//*Diferencia entre max y min cobrados actualmente*/
SELECT (MAX(salary)-MIN(salary)) AS DIFERENCIA_SALARIAL
FROM HR.employees;

/*3b*//*Diferencia entre max y min teórico*/
SELECT (MAX(max_salary)-MIN(min_salary)) AS DIFERENCIA_SALARIAL
FROM HR.jobs;

/*4*/
/*Escriba una consulta para mostrar el número de empleado y apellidos 
de todos los empleados que ganan por encima del salario promedio.*/
SELECT employee_id AS ID, last_name AS APELLIDO, salary AS SALARIO
FROM HR.employees E
WHERE (salary > (SELECT AVG(salary) FROM HR.employees));

/*5*/
/*Muestre los nombres y apellidos (es una sola columna), 
nombre del departamento y el nombre del puesto de todos los empleados 
cuyo código de ubicación de departamento (LOCATION_ID) es 1700. 
El resultado debe mostrarse en orden ascendente por el apellido del empleado.*/
SELECT CONCAT(CONCAT(first_name, ' '), last_name) AS NOMBRE, 
    department_name AS DEPARTAMENTO, job_title AS PUESTO
FROM HR.employees E 
JOIN HR.departments D ON E.department_id = D.department_id
JOIN HR.jobs J ON E.job_id = J.job_id
WHERE D.location_id = 1700
ORDER BY E.last_name ASC;

