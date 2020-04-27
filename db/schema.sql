
create database test;

CREATE USER 'raphael'@'%' IDENTIFIED VIA pam USING 'local_oauth2';
GRANT SELECT ON test.* TO raphael@'%';

use test;

create table person (
    id int,
    name varchar(30)
);

insert into person values
(0,'jim')
,(1,'john')