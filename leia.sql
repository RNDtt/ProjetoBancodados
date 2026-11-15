create database DBA;
use DBA;

create table predio(
id_predio int unique not null auto_increment,
cep char(9) primary key not null,
cidade varchar(30) not null,
endereco varchar(150) not null
);

Create table sala(
id_sala int auto_increment not null unique,
andar char(3),
numero_sala int not null,
primary key (id_sala)
);

create table categoria_item(
id_categoria int not null unique auto_increment,
nome_categoria varchar(30),
descrição varchar(150)
);

create table item_inventario(
id_item_inventario int not null auto_increment unique,
nome_item varchar(20),
tipo_item varchar(15),
primary key (id_item_inventario)
);

create table colaborador(
id_funcionario int not null unique auto_increment,
nome_funcionario varchar(100)not null,
item_uso varchar(50) not null
);

create table movimentação(

);
