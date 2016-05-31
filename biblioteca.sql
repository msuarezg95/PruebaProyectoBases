/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     30/05/2016 12:14:20                          */
/*==============================================================*/


alter table DVD
   drop constraint FK_DVD_HERENCIA_EJEMPLAR;

alter table EJEMPLARES
   drop constraint FK_EJEMPLAR_DEVUELVE_SOCIO;

alter table EJEMPLARES
   drop constraint FK_EJEMPLAR_DONA_SOCIO;

alter table EJEMPLARES
   drop constraint FK_EJEMPLAR_ESTAN_LINEA;

alter table EJEMPLARES
   drop constraint FK_EJEMPLAR_PIDE_SOCIO;

alter table EMPRESA
   drop constraint FK_EMPRESA_EMITE_FACTURA;

alter table EMPRESA
   drop constraint FK_EMPRESA_VENDE_EJEMPLAR;

alter table ESCRIBE
   drop constraint FK_ESCRIBE_ESCRIBE_EJEMPLAR;

alter table ESCRIBE
   drop constraint FK_ESCRIBE_ESCRIBE2_AUTOR;

alter table LIBROS
   drop constraint FK_LIBROS_HERENCIA2_EJEMPLAR;

alter table LINEA
   drop constraint FK_LINEA_POSEE_FACTURA;

alter table REVISTA
   drop constraint FK_REVISTA_HERENCIA3_EJEMPLAR;

drop table AUTOR cascade constraints;

drop table DVD cascade constraints;

drop index ESTAN_FK;

drop index DONA_FK;

drop index PIDE_FK;

drop index DEVUELVE_FK;

drop table EJEMPLARES cascade constraints;

drop index VENDE_FK;

drop index EMITE_FK;

drop table EMPRESA cascade constraints;

drop index ESCRIBE2_FK;

drop index ESCRIBE_FK;

drop table ESCRIBE cascade constraints;

drop table FACTURA cascade constraints;

drop table LIBROS cascade constraints;

drop index POSEE_FK;

drop table LINEA cascade constraints;

drop table REVISTA cascade constraints;

drop table SOCIO cascade constraints;

/*==============================================================*/
/* Table: AUTOR                                                 */
/*==============================================================*/
create table AUTOR 
(
   CODIGO_AUTOR         INTEGER              not null,
   NOMBRE               VARCHAR2(20),
   APELLIDOS_AUTOR      VARCHAR2(20),
   EPOCA                VARCHAR2(50),
   constraint PK_AUTOR primary key (CODIGO_AUTOR)
);

/*==============================================================*/
/* Table: DVD                                                   */
/*==============================================================*/
create table DVD 
(
   CODIGO_EJEMPLAR      INTEGER              not null,
   TITULO_DVD           VARCHAR2(100),
   ANO_PUBLICACION      DATE,
   constraint PK_DVD primary key (CODIGO_EJEMPLAR)
);

/*==============================================================*/
/* Table: EJEMPLARES                                            */
/*==============================================================*/
create table EJEMPLARES 
(
   CODIGO_EJEMPLAR      INTEGER              not null,
   CODIGO_SOCIO         VARCHAR2(4),
   CODIGO_FACTURA       VARCHAR2(4),
   NUM_LINEA            INTEGER,
   SOC_CODIGO_SOCIO     VARCHAR2(4),
   SOC_CODIGO_SOCIO2    VARCHAR2(4),
   DISPONIBILIDAD       SMALLINT,
   GENERO               VARCHAR2(20),
   FECHA_DEVOLUCION     DATE,
   FECHA_PRESTAMO       DATE,
   N__EJEMPLARES        INTEGER,
   CANTIDAD             INTEGER,
   constraint PK_EJEMPLARES primary key (CODIGO_EJEMPLAR)
);

/*==============================================================*/
/* Index: DEVUELVE_FK                                           */
/*==============================================================*/
create index DEVUELVE_FK on EJEMPLARES (
   SOC_CODIGO_SOCIO ASC
);

/*==============================================================*/
/* Index: PIDE_FK                                               */
/*==============================================================*/
create index PIDE_FK on EJEMPLARES (
   SOC_CODIGO_SOCIO2 ASC
);

/*==============================================================*/
/* Index: DONA_FK                                               */
/*==============================================================*/
create index DONA_FK on EJEMPLARES (
   CODIGO_SOCIO ASC
);

/*==============================================================*/
/* Index: ESTAN_FK                                              */
/*==============================================================*/
create index ESTAN_FK on EJEMPLARES (
   CODIGO_FACTURA ASC,
   NUM_LINEA ASC
);

/*==============================================================*/
/* Table: EMPRESA                                               */
/*==============================================================*/
create table EMPRESA 
(
   NIF                  VARCHAR2(9)          not null,
   CODIGO_FACTURA       VARCHAR2(4),
   CODIGO_EJEMPLAR      INTEGER,
   EJEMPLARES_VENDIDOS  INTEGER,
   FECHA_VENTA          DATE,
   constraint PK_EMPRESA primary key (NIF)
);

/*==============================================================*/
/* Index: EMITE_FK                                              */
/*==============================================================*/
create index EMITE_FK on EMPRESA (
   CODIGO_FACTURA ASC
);

/*==============================================================*/
/* Index: VENDE_FK                                              */
/*==============================================================*/
create index VENDE_FK on EMPRESA (
   CODIGO_EJEMPLAR ASC
);

/*==============================================================*/
/* Table: ESCRIBE                                               */
/*==============================================================*/
create table ESCRIBE 
(
   CODIGO_EJEMPLAR      INTEGER              not null,
   CODIGO_AUTOR         INTEGER              not null,
   constraint PK_ESCRIBE primary key (CODIGO_EJEMPLAR, CODIGO_AUTOR)
);

/*==============================================================*/
/* Index: ESCRIBE_FK                                            */
/*==============================================================*/
create index ESCRIBE_FK on ESCRIBE (
   CODIGO_EJEMPLAR ASC
);

/*==============================================================*/
/* Index: ESCRIBE2_FK                                           */
/*==============================================================*/
create index ESCRIBE2_FK on ESCRIBE (
   CODIGO_AUTOR ASC
);

/*==============================================================*/
/* Table: FACTURA                                               */
/*==============================================================*/
create table FACTURA 
(
   CODIGO_FACTURA       VARCHAR2(4)          not null,
   FECHA_FACTURA        DATE,
   IMPORTE              NUMBER(3,3),
   constraint PK_FACTURA primary key (CODIGO_FACTURA)
);

/*==============================================================*/
/* Table: LIBROS                                                */
/*==============================================================*/
create table LIBROS 
(
   CODIGO_EJEMPLAR      INTEGER              not null,
   TITULO_LIBRO         VARCHAR2(100),
   EDITORIAL            VARCHAR2(30),
   ANO_PUBLICACION      DATE,
   CORRIENTE            VARCHAR2(20),
   constraint PK_LIBROS primary key (CODIGO_EJEMPLAR)
);

/*==============================================================*/
/* Table: LINEA                                                 */
/*==============================================================*/
create table LINEA 
(
   CODIGO_FACTURA       VARCHAR2(4)          not null,
   NUM_LINEA            INTEGER              not null,
   CANTIDAD             INTEGER,
   constraint PK_LINEA primary key (CODIGO_FACTURA, NUM_LINEA)
);

/*==============================================================*/
/* Index: POSEE_FK                                              */
/*==============================================================*/
create index POSEE_FK on LINEA (
   CODIGO_FACTURA ASC
);

/*==============================================================*/
/* Table: REVISTA                                               */
/*==============================================================*/
create table REVISTA 
(
   CODIGO_EJEMPLAR      INTEGER              not null,
   FECHA_PUBLICACION    DATE,
   constraint PK_REVISTA primary key (CODIGO_EJEMPLAR)
);

/*==============================================================*/
/* Table: SOCIO                                                 */
/*==============================================================*/
create table SOCIO 
(
   CODIGO_SOCIO         VARCHAR2(4)          not null,
   FECHA_INSCRIPCION    DATE,
   NOMBRE               VARCHAR2(20),
   APELLIDOS            VARCHAR2(20),
   OCUPACION            VARCHAR2(20),
   FECHA_CADUCIDAD_CARNET DATE,
   JUBILADO             SMALLINT,
   constraint PK_SOCIO primary key (CODIGO_SOCIO)
);

alter table DVD
   add constraint FK_DVD_HERENCIA_EJEMPLAR foreign key (CODIGO_EJEMPLAR)
      references EJEMPLARES (CODIGO_EJEMPLAR);

alter table EJEMPLARES
   add constraint FK_EJEMPLAR_DEVUELVE_SOCIO foreign key (SOC_CODIGO_SOCIO)
      references SOCIO (CODIGO_SOCIO);

alter table EJEMPLARES
   add constraint FK_EJEMPLAR_DONA_SOCIO foreign key (CODIGO_SOCIO)
      references SOCIO (CODIGO_SOCIO);

alter table EJEMPLARES
   add constraint FK_EJEMPLAR_ESTAN_LINEA foreign key (CODIGO_FACTURA, NUM_LINEA)
      references LINEA (CODIGO_FACTURA, NUM_LINEA);

alter table EJEMPLARES
   add constraint FK_EJEMPLAR_PIDE_SOCIO foreign key (SOC_CODIGO_SOCIO2)
      references SOCIO (CODIGO_SOCIO);

alter table EMPRESA
   add constraint FK_EMPRESA_EMITE_FACTURA foreign key (CODIGO_FACTURA)
      references FACTURA (CODIGO_FACTURA);

alter table EMPRESA
   add constraint FK_EMPRESA_VENDE_EJEMPLAR foreign key (CODIGO_EJEMPLAR)
      references EJEMPLARES (CODIGO_EJEMPLAR);

alter table ESCRIBE
   add constraint FK_ESCRIBE_ESCRIBE_EJEMPLAR foreign key (CODIGO_EJEMPLAR)
      references EJEMPLARES (CODIGO_EJEMPLAR);

alter table ESCRIBE
   add constraint FK_ESCRIBE_ESCRIBE2_AUTOR foreign key (CODIGO_AUTOR)
      references AUTOR (CODIGO_AUTOR);

alter table LIBROS
   add constraint FK_LIBROS_HERENCIA2_EJEMPLAR foreign key (CODIGO_EJEMPLAR)
      references EJEMPLARES (CODIGO_EJEMPLAR);

alter table LINEA
   add constraint FK_LINEA_POSEE_FACTURA foreign key (CODIGO_FACTURA)
      references FACTURA (CODIGO_FACTURA);

alter table REVISTA
   add constraint FK_REVISTA_HERENCIA3_EJEMPLAR foreign key (CODIGO_EJEMPLAR)
      references EJEMPLARES (CODIGO_EJEMPLAR);

