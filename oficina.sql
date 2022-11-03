-- Create a simple SQL script for a basic Garage scenario
create database garage;
use garage;

-- Create clients table
create table clients(
	idClients int auto_increment primary key,
    fullName varchar(35) not null,
    CPF char(11) not null,
    address varchar(255),
    constraint unique_cpf_clients unique (CPF)
);

-- Create service table
create table service(
	idService int auto_increment primary key,
    serviceCode char(10) not null,
    serviceName varchar(35),
    price float not null
);

-- Create parts table
create table parts(
	idParts int auto_increment primary key,
    partsCode char(10) not null,
    partsName varchar(35) not null,
    price float not null
);

-- Create mechanic table
create table mechanic(
	idMechanic int auto_increment primary key,
    mechanicCode char(10) not null,
    fullName varchar(35) not null,
    address varchar(255) not null,
    specialty varchar(35)
);

-- Create vehicle table
create table vehicle(
    idVehicle int auto_increment primary key,
    idVehicleClients int,
    brand varchar(35) not null,
    model varchar(35) not null,
    fabyear char(4) not null,
    licensePlate char(7),
    constraint fk_vehicle_clients foreign key (idVehicleClients) references clients(idClients)
);

-- Create serviceOrder table
create table serviceOrder(
    idServiceOrder int auto_increment primary key,
    idServiceOrderVehicle int,
    orderCode char(10) not null,
    emissionDate date not null,
    price float not null,
    ordersStatus enum("Cancelado", "Confirmado", "Em processamento") default "Em processamento" not null,
    completionDate date,
    constraint fk_serviceOrder_vehicle foreign key (idServiceOrderVehicle) references vehicle(idVehicle)
);

-- Create association_serviceOrder_service table
create table association_serviceOrder_service(
	idAServiceOrder int,
    idAService int,
    primary key (idAServiceOrder, idAService),
	constraint fk_ASOS_serviceOrder foreign key (idAServiceOrder) references serviceOrder(idServiceOrder),
    constraint fk_ASOS_service foreign key (idAService) references service(idService)
);

-- Create association_serviceOrder_parts table
create table association_serviceOrder_parts(
	idAServiceOrder int,
    idAParts int,
    primary key (idAServiceOrder, idAParts),
	constraint fk_ASOP_serviceOrder foreign key (idAServiceOrder) references serviceOrder(idServiceOrder),
    constraint fk_ASOP_parts foreign key (idAParts) references parts(idParts)
);

-- Create association_serviceOrder_vehicle table
create table association_serviceOrder_vehicle(
	idAServiceOrder int,
    idAVehicle int,
    primary key (idAServiceOrder, idAVehicle),
	constraint fk_ASOV_serviceOrder foreign key (idAServiceOrder) references serviceOrder(idServiceOrder),
    constraint fk_ASOV_vehicle foreign key (idAVehicle) references vehicle(idVehicle)
);