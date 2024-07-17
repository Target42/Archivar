/* ============================================================ */
/*   Database name:  MODEL_2                                    */
/*   DBMS name:      InterBase                                  */
/*   Created on:     15.07.2024  20:58                          */
/* ============================================================ */

/*  Insert trigger "tu_ts_task_status" for table "TS_TASK_STATUS"  */
set term /;
create trigger tu_ts_task_status for TS_TASK_STATUS
before update as
begin
    new.ts_stamp = current_timestamp;

end;/
set term ;/

