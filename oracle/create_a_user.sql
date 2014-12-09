set echo on

-- SET SERVEROUTPUT ON;

accept vstring prompt "Please enter your name: ";

declare
   v_line varchar2(40);
   schema varchar2(40);
begin
   schema := '&vstring';
   v_line := 'Hello '|| schema;
   dbms_output.put_line(v_line);
   begin
      execute immediate 'DROP USER ' || schema || ' CASCADE';
   exception 
     when others 
     then
        dbms_output.put_line('User: ' || schema || ' not exists');	
   end;
--   spool 'create_' || schema || '.log';
   execute immediate 'CREATE USER ' || schema || ' IDENTIFIED BY TEST DEFAULT TABLESPACE DATA TEMPORARY TABLESPACE TEMP PROFILE DEFAULT ACCOUNT UNLOCK';
   execute immediate 'GRANT RESOURCE TO ' || schema;
   execute immediate 'GRANT DBA TO ' || schema;
   execute immediate 'GRANT CONNECT TO ' || schema;
   execute immediate 'ALTER USER ' || schema || ' DEFAULT ROLE ALL';
   execute immediate 'GRANT GLOBAL QUERY REWRITE TO ' || schema;
   execute immediate 'GRANT UNLIMITED TABLESPACE TO ' || schema;
end;
/

exit;

