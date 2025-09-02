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

