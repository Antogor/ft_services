FLUSH PRIVILEGES;
CREATE USER 'agarzon'@'%' IDENTIFIED BY 'agarzon';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'agarzon'@'%' IDENTIFIED BY 'agarzon' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'agarzon'@'localhost' IDENTIFIED BY 'agarzon' WITH GRANT OPTION;
CREATE DATABASE wordpress;
DROP DATABASE test;
FLUSH PRIVILEGES;
