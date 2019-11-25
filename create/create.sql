-- Clean database
drop table categoria cascade constraints;
drop table portao cascade CONSTRAINTS;
drop table aeronave CASCADE CONSTRAINTS;
drop table companhia_aerea CASCADE CONSTRAINTS;
drop table frota CASCADE CONSTRAINTS;
drop table voo CASCADE CONSTRAINTS;

drop sequence sCategoria;
drop sequence sPortao;
drop sequence sAeronave;
drop sequence sFrota;
drop sequence sCompAerea;
drop sequence sVoo;
-- Create tables
create table categoria (
    id_categoria number(6) primary key not null,
    nome varchar2(25) not null,
    quantidade number not null
);

create table portao (
    id_portao number(6) primary key not null,
    id_categoria number(6) not null,
    disponibilidade number(1) not null
);

create table aeronave (
    id_aeronave number(6) primary key not null,
    id_categoria number(6) not null,
    modelo varchar2(25)
);

create table companhia_aerea(
    id_companhia_aerea number(6) primary key not null,
    nome varchar2(25) not null
);

create table frota (
    id_callsign number(6) primary key not null,
    id_aeronave number(6) not null,
    id_companhia_aerea number(6) not null
);

create table voo(
    id_voo number(6) primary key not null,
    id_aeronave number(6) not null,
    id_companhia_aerea number(6) not null,
    data_chegada date,
    date_saida date
);

alter table portao add constraint FK_id_categoria_portao FOREIGN key(id_categoria) 
    references categoria(id_categoria);

alter table aeronave add constraint FK_id_categoria_aeronave foreign key(id_categoria)
    references categoria(id_categoria);
    
alter table frota add constraint FK_id_aeronave_frota foreign key(id_aeronave) 
    references aeronave(id_aeronave);
    
alter table frota add constraint FK_id_comp_aerea_frota foreign key (id_companhia_aerea)
    references companhia_aerea(id_companhia_aerea);
    
alter table voo add constraint FK_id_aeronave_voo foreign key (id_aeronave) 
    references aeronave(id_aeronave);
alter table voo add constraint FK_id_comp_aerea_comp foreign key (id_companhia_aerea)
    references companhia_aerea(id_companhia_aerea);
    
create sequence sCategoria start with 1 nocache;
create sequence sPortao start with 1 nocache;
create sequence sAeronave start with 1 nocache;
create sequence sFrota start with 1 nocache;
create sequence sCompAerea start with 1 nocache;
create sequence sVoo start with 1 nocache;

