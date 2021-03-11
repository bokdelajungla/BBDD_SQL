/*Creación de la Base de Datos*/
create database EMPRESA;
use EMPRESA;

/*Creacion de las tablas*/
/*Primero las que no hagan referencia a otras tablas*/
create table Departamentos
(IdDpto int not null unique,
Nombre varchar(20) not null unique,
Presupuesto int not null, 
check (Presupuesto >= 5000),
primary key (IdDpto)
);
create index indDep on Departamentos(Nombre);

create table Proyectos
(IdProy int not null unique,
Nombre varchar(20) not null unique default 'INDEF',
Fecha_ini date,
Fecha_fin date,
check (Fecha_fin > Fecha_ini),
primary key (IdProy)
);

create table Empleados
(IdEmp int not null,
Nombre varchar(20) not null,
Apellidos varchar(50) not null,
Sexo char(1) not null,
Fecha_nac date,
Sueldo int not null,
Municipio varchar(20),
IdDpto int,
check (Sexo in ('M','F')),
check (Sueldo >= 1000),
primary key (IdEmp),
foreign key (IdDpto) references Departamentos(IdDpto)
on delete set null
);

create table Asignacion
(IdEmp int not null,
IdProy int not null,
foreign key (IdEmp) references Empleados(IdEmp),
foreign key (IdProy) references	Proyectos(IdProy),
primary key (IdEmp,IdProy)
);

/*Insercion de datos*/
/*Seguir el mismo orden que al crearlas*/
/*Departamentos*/
insert into Departamentos values(1,'I+D',50000);
insert into Departamentos values(2,'Diseño',25000);
insert into Departamentos values(3,'Ventas',15000);
insert into Departamentos values(4,'Marketing',10000);

/*Proyectos*/
insert into Proyectos values(1,'SINUBE','2018-01-01','2018-03-15');
insert into Proyectos values(2,'TRASPI','2018-02-15','2018-12-30');
insert into Proyectos values(3,'RUNTA','2018-06-06','2018-09-15');
insert into Proyectos values(4,'CARTAL','2018-05-05','2018-09-25');

/*Empleados*/
insert into Empleados values(10478,'Alberto','Pérez López','M','1969-10-12',1500,'Madrid',1);
insert into Empleados values(10479,'Gloria','Ruiz Ruiz','F','1965-11-07',1650,'Sevilla',2);
insert into Empleados values(10480,'Antonio','García Montero','M','1960-10-07',1350,'Madrid',1);
insert into Empleados values(10481,'Ana','López Ramírez','F','1990-10-01',1250,'Sevilla',3);
insert into Empleados values(10482,'Eduardo','Chicón Terrales','M','1980-11-07',1470,'Córdoba',2);

/*Asignación*/
insert into Asignacion values(10478,1);
insert into Asignacion values(10480,3);
insert into Asignacion values(10481,1);
insert into Asignacion values(10482,2);
