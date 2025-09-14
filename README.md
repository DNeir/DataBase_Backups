# MySQL
   BD     PASS       bd      user    pass
mysqlDB   12345  odontology  neir    117

## Backups
docker exec [nombre_contenedor] mysqldump -u [usuario] -p[nombre_contraseña] [nombre_base_datos] > [archivo_backup.sql]
//Mi caso
docker exec mysqlDB mysqldump -u neir -p 117 odontology_mysql > odontologyBackup.sql

## IMPORTAR
docker cp [archivo_backup.sql] [nombre_contenedor]:/tmp/
docker exec -it [nombre_contenedor] bash
docker exec -i [nombre_contenedor] mysql -u [usuario] -p[nombre_contraseña] [nombre_base_datos] < /tmp/[archivo_backup.sql]
//En mi caso
docker cp odontologyBackup.sql mysqlDB:/tmp/
docker exec -it mysqlDB bash //Para comprobar
//Dentro del bash
mysql -u root -p12345 < /tmp/odontologyBackup.sql


### Postgresql
sudo -u postgres psql

## Backups
pg_dump -U neir -h localhost -p 5432 -F plain -f odontologyBackupPost odontology_post

## IMPORTAR
psql -U [usuario] -h localhost -p 5432 -d odontology_post -f [archivo_backup]
//En mi caso
psql -U neir -h localhost -p 5432 -d odontology_post -f odontologyBackupPost



## msql-server
docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Sala8101' \
   -p 1433:1433 \
   --name sqlserver-container \
   -d mcr.microsoft.com/mssql/server:2022-latest

## Oracle
docker run -d --name oracle-xe \
-p 1521:1521 -p 8080:8080 \
-e ORACLE_PASSWORD=Sala8101 \
-v /home/neir/Documentos/Uniguajira/BDI/backups/oracle:/opt/oracle/backups \
gvenzl/oracle-xe

### Conectarte a Oracle y verificar la contraseña
sudo docker exec -it oracle-xe bash
### Conexión como sys (administrador):
sqlplus sys/Sala8101 as sysdba
### Crear Nuevo Usuario
create user odontology_cli identified by Sala8101; 
grant connect,resource to odontology_cli; 
ALTER USER odontology_cli QUOTA UNLIMITED ON USERS;

### Asignar y Crear Directorio de Backup
CREATE OR REPLACE DIRECTORY BACKUP_DIR AS '/opt/oracle/backups'; 
GRANT READ, WRITE ON DIRECTORY BACKUP_DIR TO system;
exit
exit

### Entrar a la bases de datos desde el bash
sqlplus odontology_cli/Sala8101

## Backups
expdp odontology_cli/Sala8101@//localhost:1521/XE \
  directory=BACKUP_DIR \
  dumpfile=odontology_backup_$(date +%Y%m%d).dmp \
  logfile=odontology_backup_$(date +%Y%m%d).log \
  schemas=odontology_cli

### Restaurar 
impdp odontology_cli/Sala8101@//localhost:1521/XE \
  directory=BACKUP_DIR \
  dumpfile=odontology_backup_20250910.dmp \
  logfile=restore_$(date +%Y%m%d_%H%M%S).log \
  remap_tablespace=USERS:USERS \
  table_exists_action=replace \
  transform=segment_attributes:n

