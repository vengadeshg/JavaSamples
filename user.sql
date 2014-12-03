create table user (
idUser int not null auto_increment,
userName varchar(50) unique,
password varchar(50),
realName varchar(100),
email varchar(50),
idAdmin boolean,
primary key(idUser)) ENGINE=innodb;


