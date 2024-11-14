--1 creation de la base de donnee formation 
 create database centre_formation;

--2 CRATIONDES TABLES
-- TABLE APPARTENIR
create table APPARTENIR
(
   CODESPEC             varchar(10) not null,
   CODEFORM             varchar(10) not null,
   primary key (CODESPEC, CODEFORM)
)ENGINE=InnoDB;

--Table ETRE_RATACHE
create table ETRE_RATACHE
(
   ID_INS               varchar(10) not null,
   CODESESS             varchar(10) not null,
   primary key (ID_INS, CODESESS)
)ENGINE=InnoDB;

--Table ETUDIANT
create table ETUDIANT
(
   NUNCNIETU            varchar(100) not null,
   ID_VILLE             int not null,
   NOMETU               varchar(50),
   PRENOMETU            varchar(50),
   DATENAISSETU         date,
   ADRESSEETU           bigint,
   primary key (NUNCNIETU)
)ENGINE=InnoDB;

--Table FORMATION
create table FORMATION
(
   CODEFORM             varchar(10) not null,
   TITREFORM            varchar(30),
   DUREEFORM            time,
   PRIXFORM             int,
   primary key (CODEFORM)
)ENGINE=InnoDB;

--Table INSCRIPTION
create table INSCRIPTION
(
   ID_INS               varchar(10) not null,
   NUNCNIETU            varchar(100) not null,
   ID_NIVEAU            int not null,
   DATE_INS             datetime,
   ANNEE_SCOLAIRE       varchar(10),
   TYPECOURS         varchar(50),
   primary key (ID_INS)
)ENGINE=InnoDB;

--Table NIVEAU
create table NIVEAU
(
   ID_NIVEAU            int not null,
   LIBELLENIV           varchar(30),
   primary key (ID_NIVEAU)
)ENGINE=InnoDB;

--Table SESSION 
create table SESSION
(
   CODESESS             varchar(10) not null,
   CODEFORM             varchar(10) not null,
   NOMSESS              varchar(50),
   DATEDEBUT            datetime,
   DATEFIN              datetime,
   primary key (CODESESS)
)ENGINE=InnoDB;

--Table SPECIALITE
create table SPECIALITE
(
   CODESPEC             varchar(10) not null,
   NOMSPEC              varchar(30),
   DESCSPEC             varchar(50),
   primary key (CODESPEC)
)ENGINE=InnoDB;

-- Table VILLE   
create table VILLE
(
   ID_VILLE             int not null,
   NOM_VILLE            varchar(30),
   primary key (ID_VILLE)
)ENGINE=InnoDB;

--LES CLES ETRANGERES
alter table APPARTENIR add constraint FK_APPARTENIR foreign key (CODEFORM)
      references FORMATION (CODEFORM) on delete restrict on update restrict;

alter table APPARTENIR add constraint FK_APPARTENIR2 foreign key (CODESPEC)
      references SPECIALITE (CODESPEC) on delete restrict on update restrict;

alter table ETRE_RATACHE add constraint FK_ETRE_RATACHE foreign key (CODESESS)
      references SESSION (CODESESS) on delete restrict on update restrict;

alter table ETRE_RATACHE add constraint FK_ETRE_RATACHE2 foreign key (ID_INS)
      references INSCRIPTION (ID_INS) on delete restrict on update restrict;

alter table ETUDIANT add constraint FK_VIVRE foreign key (ID_VILLE)
      references VILLE (ID_VILLE) on delete restrict on update restrict;

alter table INSCRIPTION add constraint FK_CONCERNER_ foreign key (ID_NIVEAU)
      references NIVEAU (ID_NIVEAU) on delete restrict on update restrict;

alter table INSCRIPTION add constraint FK_EFFECTUER foreign key (NUNCNIETU)
      references ETUDIANT (NUNCNIETU) on delete restrict on update restrict;

alter table SESSION add constraint FK_CONCERNER foreign key (CODEFORM)
      references FORMATION (CODEFORM) on delete restrict on update restrict;


--3 AJOUT DE LA CONTRAINT NOT NULL SUR LA COLOMNE TYPE COURS DE LA TABLE INSCRIPTION
ALTER TABLE INSCRIPTION MODIFY TYPECOURS VARCHAR(30) NOT NULL;

--4 ajout de la contrainte qui verifie que la dateFin soit toujour supperrieure a la dateDebut dans la table session.
ALTER TABLE SESSION ADD CONSTRAINT CK_DATEFIN CHECK (DATEFIN>DATEDEBUT);

--5 ajouter une colomne active sur la table specialite
 ALTER TABLE `specialite` ADD `ACTIVE` BIT DEFAULT 0 CONSTRAINT CK_ACTIVE CHECK (ACTIVE IN (0,1));