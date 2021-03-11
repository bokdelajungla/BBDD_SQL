/*Prueba para HR.emp_audit_tr*/
/*Comprobamos el contenido de EMP_AUDIT*/
SELECT * FROM HR.EMP_AUDIT;
/*Hacemos cambios en algunas filas para ver si el trigger se dispara*/
UPDATE HR.employees SET salary = salary*0.9
WHERE employee_id IN (100, 101, 102);
/*Volvemos a mostrar el contenido de EMP_AUDIT*/
SELECT * FROM HR.EMP_AUDIT;

/*Dejamos las tablas como estaban*/
ROLLBACK;