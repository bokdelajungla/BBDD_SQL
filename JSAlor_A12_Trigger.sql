/*
Crea un trigger que inserte un registro en una tabla nueva llamada EMP_AUDIT 
cada vez que modificamos el salario de un empleado.
Sólo se realizará la operación si el salario que se va a modificar 
difiere del nuevo.

La tabla EMP_AUDIT tendrá los siguientes campos:
•	Identificador del empleado que se está actualizando.
•	El momento en que se hace la actualización.
•	Un mensaje que contenga el salario anterior y el nuevo.
*/
---------------------------
--Creamos la tabla
CREATE TABLE HR.EMP_AUDIT(
employee_id  NUMBER(6),
fecha_cambio TIMESTAMP,
reg_cambio VARCHAR2(50));
---------------------------
---------------------------------------------------------------------------
--Creamos el trigger
CREATE OR REPLACE TRIGGER HR.emp_audit_Tr
AFTER UPDATE OF salary 
ON HR.employees
FOR EACH ROW WHEN (new.salary <> old.salary) --Cuando el salario cambia
BEGIN
    --Acciones a llevar a cabo si se dispara:
    INSERT INTO HR.EMP_AUDIT
    VALUES (:old.employee_id, SYSTIMESTAMP, 'Salario Anterior: '
            || :old.salary || ' / Salario Actual: ' || :new.salary);     
END;
---------------------------------------------------------------------------