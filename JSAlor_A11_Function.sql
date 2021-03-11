/*Funcion que devuelve T o F dependiendo de que exista un JOB_ID*/
CREATE OR REPLACE
FUNCTION existe_puesto
(id_job IN HR.jobs.job_id%type, F_Job OUT HR.jobs%ROWTYPE) 
RETURN BOOLEAN AS
BEGIN
    SELECT * 
    INTO F_Job
    FROM HR.JOBS 
    WHERE job_id = id_job; 
    RETURN TRUE; 
    
    EXCEPTION WHEN NO_DATA_FOUND THEN RETURN FALSE; 

END existe_puesto;