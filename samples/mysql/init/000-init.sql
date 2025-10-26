set global host_cache_size=0;
create database if not exists human_resources;
alter user 'root'@'%' identified with 'mysql_native_password' by 'flyway';