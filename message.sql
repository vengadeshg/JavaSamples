create table message (
idMessage int not null auto_increment,
message text,
subject tinytext,
sentDate timestamp default now(),
idFrom int not null,
idTo int not null,
primary key (idMessage),
index idFromIndex(idFrom),
index idToIndex(idTo),
foreign key (idFrom) references user(idUser) on delete cascade,
foreign key (idTo) references user(idUser) on delete cascade) ENGINE=innodb;
