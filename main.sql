DROP TABLESPACE TRANSACCIONAL INCLUDING CONTENTS AND DATAFILES;
CREATE TABLESPACE TRANSACCIONAL DATAFILE 'TRANSACCIONAL_DATA.DBF' SIZE 200M;

DROP USER TRANS CASCADE;
CREATE USER TRANS IDENTIFIED BY TRANS123;
ALTER USER TRANS QUOTA UNLIMITED ON TRANSACCIONAL;
ALTER USER TRANS DEFAULT TABLESPACE TRANSACCIONAL;

GRANT CREATE SESSION, CREATE VIEW, CREATE TABLE, ALTER SESSION, CREATE SEQUENCE TO TRANS;


DROP TABLESPACE INTERMEDIA INCLUDING CONTENTS AND DATAFILES;
CREATE TABLESPACE INTERMEDIA DATAFILE 'INTERMEDIA_DATA.DBF' SIZE 200M;

DROP USER INTER CASCADE;
CREATE USER INTER IDENTIFIED BY INTER123;
ALTER USER INTER QUOTA UNLIMITED ON INTERMEDIA;
ALTER USER INTER DEFAULT TABLESPACE INTERMEDIA;

GRANT ALL PRIVILEGES TO INTER;


/*
Antes de la ejecución del archivo 'main.sql' debe cambiar las rutas donde se encuentran los archivos
a la ubicación física dentro de su equipo 
*/

CONNECT TRANS/TRANS123;
@'C:/Proyecto - Educación - I-2015 /SCRIPTS/cre_transaccional.sql'
@'C:/Proyecto - Educación - I-2015/SCRIPTS/insert_transaccional.sql'
