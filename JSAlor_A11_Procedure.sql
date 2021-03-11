/*Procedimiento que reciba un número de empleado y una cadena 
correspondiente a su nuevo oficio (job_id) como parámetros.
El procedimiento deberá localizar el empleado, modificar su oficio por el nuevo
y visualizar los cambios realizados.*/
CREATE OR REPLACE
PROCEDURE cambiar_job
(id_emp HR.employees.employee_id%type, new_job HR.jobs.job_id%type) AS
    existe BOOLEAN;
    job_row HR.jobs%ROWTYPE;
    nombre HR.employees.first_name%type;
    puesto HR.employees.job_id%type;
    
BEGIN
    /*Comprobar que el puesto existe*/
    existe := existe_puesto(new_job, job_row); 
    IF existe THEN
        /*Mostramos el trabajo actual*/
        SELECT first_name, job_id
        into nombre, puesto
        FROM hr.employees
        WHERE employee_id = id_emp;
        DBMS_OUTPUT.PUT_LINE(nombre || ' tenía el puesto de ' || puesto);
        
        /*Realizamos el cambio*/
        UPDATE HR.employees
        SET job_id = new_job
        WHERE employee_id = id_emp;
        
        /*Comporbamos que se ha cambiado*/
        SELECT first_name, job_id
        into nombre, puesto
        FROM HR.employees
        WHERE employee_id = id_emp;
        DBMS_OUTPUT.PUT_LINE(nombre || ' ha cambiado de puesto a ' || puesto);
    ELSE
        DBMS_OUTPUT.PUT_LINE('El puesto indicado no existe');
    END IF;
    
    EXCEPTION WHEN NO_DATA_FOUND 
    THEN DBMS_OUTPUT.PUT_LINE('El empleado indicado no existe'); 

END cambiar_job;
