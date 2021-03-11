/*Bloque Anónimo que llama al procedimiento*/
/*PARA DAR PERMISOS*/
/*Ejecutar esta sentencia como SYSTEM*/
--GRANT UPDATE ON HR.employees TO PUBLIC;
/*100 , AD_PRES -> AD_VP*/
SET SERVEROUTPUT ON;

DECLARE
    --Variables que se emplean como argumentos
    id_emp hr.employees.employee_id%type;
    new_job HR.jobs.JOB_ID%TYPE;
BEGIN
    --Llamar al procedimiento y emplear variables de sustitución
    cambiar_job(&id_emp, '&new_job');
/*Volver al estado anterior*/
ROLLBACK;
END;

