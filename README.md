# Practica 7 y 6
Normalización y DDL
* Edgar Quiroz Castañeda 418003808
* Silvia Díaz Gomez 408002330
* Narciso Isaac Eugenio Aceves 315581461

## Notas

Para crear la base de datos 
* Hay que abrir una sesión de la terminal en el directorio de esta práctica.
* Después, hay que iniciar SQLplus, usando cualquier sesión administrativa.

        $ sqlplus ADMIN/PASSWORD

    Donde ADMIN es el usuario administrativo, y PASSWORD su contraseña.
* Después hay que crear un usuario usando el script proporcionado
  
        SQL > START tblspace.sql;

* Después hay que cambiar la sesión a la de ese usuario.
  
        SQL > CONNECT USER70/p299007346403;

* Y finalmente crear las tablas usando el script proporcionado
  
        SQL > START DDL.sql;

Si se desea ver la lista de tablas creeadas, se puede hacer ejecutado

        SQL > SELECT table_name FROM user_tables;

