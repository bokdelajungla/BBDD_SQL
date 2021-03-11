/*
1.	Crea un procedimiento que reciba un número de empleado y una cadena 
correspondiente a su nuevo oficio (job_id) como parámetros. El procedimiento 
deberá localizar el empleado, modificar su oficio por el nuevo y visualizar los 
cambios realizados. Pero antes se deberán hacer las siguientes comprobaciones:
*/
--GRANT EXECUTE ON NOMBRE_PROCEDIMEINTO TO USUARIO;
--GRANT SELECT,INSERT,UPDATE ON ? TO ?;
CREATE OR REPLACE
PROCEDURE cambiar_job(id_emp in hr.employees.employee_id%type, 
                        new_job in hr.jobs.job_id%type) AS
    existe BOOLEAN;
    nombre hr.employees.first_name%type;
    puesto hr.employees.job_id%type;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE(id_emp || ' ' || new_job);
    /*Comprobar que el empleado existe*/
    existe := existe_empleado(id_emp, nombre); 
    IF existe THEN
        /*Mostramos el trabajo actual*/
        SELECT first_name, job_id
        into nombre, puesto
        FROM hr.employees
        WHERE employee_id = id_emp;
        DBMS_OUTPUT.PUT_LINE(nombre || 'tenía el puesto de ' || puesto);
        
        /*Realizamos el cambio*/
        UPDATE hr.employees SET job_id = new_job
        WHERE employee_id = id_emp;
        
        /*Comporbamos que se ha cambiado*/
        SELECT first_name, job_id
        into nombre, puesto
        FROM hr.employees
        WHERE employee_id = id_emp;
        DBMS_OUTPUT.PUT_LINE(nombre || 'ha cambiado de puesto a ' || puesto);
    ELSE
        DBMS_OUTPUT.PUT_LINE('El empleado no existe');
    END IF;
END cambiar_job;

/*Funcion que devuelve T o F dependiendo de que exista el empleado*/
CREATE OR REPLACE
FUNCTION existe_empleado(id_emp IN hr.employees.employee_id%type, 
                            nombre OUT hr.employees.first_name%type) 
RETURN BOOLEAN AS
BEGIN
    SELECT first_name INTO nombre
    FROM hr.employees 
    WHERE employee_id = id_emp; 
    RETURN TRUE; 
    
    EXCEPTION WHEN NO_DATA_FOUND THEN RETURN FALSE; 

END existe_empleado;

/*Bloque Anónimo que llama al procedimiento*/
SET SERVEROUTPUT ON;
GRANT UPDATE ON HR.employees TO CURSO;
declare 
--   id_emp hr.employees.employee_id%type;
--   new_job hr.employees.job_id%type;
begin
    cambiar_job(&id_emp, '&new_job');
end;

/*108 FI_MGR*/
rollback;