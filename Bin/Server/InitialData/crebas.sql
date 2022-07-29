/* ============================================================ */
/*   Database name:  MODEL_2                                    */
/*   DBMS name:      InterBase                                  */
/*   Created on:     25.05.2022  20:00                          */
/* ============================================================ */

create generator gen_xm_id;
create generator gen_tt_id;

create generator gen_pr_id;
create generator gen_pe_id;
create generator gen_gr_id;
create generator gen_be_id;
/* ============================================================ */
/*   Table: XM_XML                                              */
/* ============================================================ */
create table XM_XML
(
    XM_ID                           INTEGER                not null,
    XM_CLID                         CHAR(38)                       ,
    XM_SCHEMA                       CHAR(38)                       ,
    XM_CREATED                      TIMESTAMP                      ,
    XM_CHANGED                      TIMESTAMP                      ,
    XM_DATA                         BLOB                           ,
    XM_TITLE                        VARCHAR(256)                   ,
    XM_STATUS                       CHAR(1)                        ,
    XM_TAGS                         VARCHAR(100)                   ,
    constraint PK_XM_XML primary key (XM_ID)
);

/* ============================================================ */
/*   Index: XM_CLID_INX                                         */
/* ============================================================ */
create unique ASC index XM_CLID_INX on XM_XML (XM_CLID);

/* ============================================================ */
/*   Index: XM_SCHEMA_INX                                       */
/* ============================================================ */
create ASC index XM_SCHEMA_INX on XM_XML (XM_SCHEMA);

/* ============================================================ */
/*   Table: TT_TASK_TYPE                                        */
/* ============================================================ */
create table TT_TASK_TYPE
(
    TT_ID                           INTEGER                not null,
    TT_NAME                         VARCHAR(100)                   ,
    constraint PK_TT_TASK_TYPE primary key (TT_ID)
);

/* ============================================================ */
/*   Index: TT_TASK_TYPE_NAME                                   */
/* ============================================================ */
create unique ASC index TT_TASK_TYPE_NAME on TT_TASK_TYPE (TT_NAME);

/* ============================================================ */
/*   Table: PE_PERSON                                           */
/* ============================================================ */
create table PE_PERSON
(
    PE_ID                           INTEGER                not null,
    PE_NAME                         VARCHAR(100)                   ,
    PE_VORNAME                      VARCHAR(100)                   ,
    PE_ABTEILUNG                    VARCHAR(30)                    ,
    PE_MAIL                         VARCHAR(250)                   ,
    PE_STIMMEN                      INTEGER                        ,
    constraint PK_PE_PERSON primary key (PE_ID)
);

/* ============================================================ */
/*   Index: PE_PERSON_NAME                                      */
/* ============================================================ */
create ASC index PE_PERSON_NAME on PE_PERSON (PE_NAME, PE_VORNAME);

/* ============================================================ */
/*   Table: GR_GREMIUM                                          */
/* ============================================================ */
create table GR_GREMIUM
(
    GR_ID                           INTEGER                not null,
    GR_NAME                         VARCHAR(150)                   ,
    GR_SHORT                        VARCHAR(20)                    ,
    GR_PIC                          BLOB                           ,
    GR_PIC_MD5                      VARCHAR(32)                    ,
    GR_PARENT_ID                    INTEGER                        ,
    GR_VALID                        INTEGER                        ,
    GR_PROTO_NR                     INTEGER                        ,
    constraint PK_GR_GREMIUM primary key (GR_ID)
);

/* ============================================================ */
/*   Index: GR_GREMIUM_NAME                                     */
/* ============================================================ */
create ASC index GR_GREMIUM_NAME on GR_GREMIUM (GR_NAME);

/* ============================================================ */
/*   Table: PR_PROTOKOLL                                        */
/* ============================================================ */
create table PR_PROTOKOLL
(
    PR_ID                           INTEGER                not null,
    GR_ID                           INTEGER                        ,
    PR_NR                           INTEGER                        ,
    PR_TITLE                        VARCHAR(150)                   ,
    PR_DATE                         DATE                           ,
    PR_DATA                         BLOB                           ,
    PR_STATE                        CHAR(1)                        ,
    constraint PK_PR_PROTOKOLL primary key (PR_ID)
);

/* ============================================================ */
/*   Table: OT_OPEN_TASK                                        */
/* ============================================================ */
create table OT_OPEN_TASK
(
    TT_ID                           INTEGER                not null,
    XM_ID                           INTEGER                not null,
    constraint PK_OT_OPEN_TASK primary key (TT_ID, XM_ID)
);

/* ============================================================ */
/*   Table: GR_PE                                               */
/* ============================================================ */
create table GR_PE
(
    GR_ID                           INTEGER                not null,
    PE_ID                           INTEGER                not null,
    GP_ROLLE                        VARCHAR(50)                    ,
    constraint PK_GR_PE primary key (GR_ID, PE_ID)
);

/* ============================================================ */
/*   Table: BE_BESCHLUSS                                        */
/* ============================================================ */
create table BE_BESCHLUSS
(
    BE_ID                           INTEGER                not null,
    PR_ID                           INTEGER                not null,
    XM_ID                           INTEGER                not null,
    BE_ANGENOMMEN                   CHAR(1)                        ,
    BE_DATA                         BLOB                           ,
    constraint PK_BE_BESCHLUSS primary key (BE_ID, PR_ID, XM_ID)
);

/* ============================================================ */
/*   Table: PR_XM                                               */
/* ============================================================ */
create table PR_XM
(
    PR_ID                           INTEGER                not null,
    XM_ID                           INTEGER                not null,
    constraint PK_PR_XM primary key (PR_ID, XM_ID)
);

alter table PR_PROTOKOLL
    add constraint FK_REF_86 foreign key  (GR_ID)
       references GR_GREMIUM;

alter table OT_OPEN_TASK
    add constraint FK_REF_25 foreign key  (TT_ID)
       references TT_TASK_TYPE;

alter table OT_OPEN_TASK
    add constraint FK_REF_29 foreign key  (XM_ID)
       references XM_XML;

alter table GR_PE
    add constraint FK_REF_71 foreign key  (GR_ID)
       references GR_GREMIUM;

alter table GR_PE
    add constraint FK_REF_75 foreign key  (PE_ID)
       references PE_PERSON;

alter table BE_BESCHLUSS
    add constraint FK_REF_91 foreign key  (PR_ID)
       references PR_PROTOKOLL;

alter table BE_BESCHLUSS
    add constraint FK_REF_95 foreign key  (XM_ID)
       references XM_XML;

alter table PR_XM
    add constraint FK_REF_255 foreign key  (PR_ID)
       references PR_PROTOKOLL;

alter table PR_XM
    add constraint FK_REF_259 foreign key  (XM_ID)
       references XM_XML;

SET TERM ^ ;
create trigger XM_XML_INSERT for XM_XML
  active before insert   
as
begin
  if (new.xm_created is null)
    then new.xm_created = current_timestamp;
  new.XM_CHANGED = current_timestamp;
end^
SET TERM ; ^

SET TERM ^ ;
create trigger XM_XML_UPDATE for XM_XML
  active before update
as
begin
  new.XM_CHANGED = current_timestamp;
end^
SET TERM ; ^

commit;

INSERT INTO TT_TASK_TYPE (TT_ID, TT_NAME) VALUES ( 100, 'Einstellung' );
INSERT INTO TT_TASK_TYPE (TT_ID, TT_NAME) VALUES ( 101, 'Versetzung' );
INSERT INTO TT_TASK_TYPE (TT_ID, TT_NAME) VALUES ( 102, 'Orga-Žderung');
INSERT INTO TT_TASK_TYPE (TT_ID, TT_NAME) VALUES ( 103, 'Mutterschutz' );
INSERT INTO TT_TASK_TYPE (TT_ID, TT_NAME) VALUES ( 104, 'Praktika' );
INSERT INTO TT_TASK_TYPE (TT_ID, TT_NAME) VALUES ( 105, 'WerksStudenten');
INSERT INTO TT_TASK_TYPE (TT_ID, TT_NAME) VALUES ( 106, 'Wissenschaftliche Arbeiten');
INSERT INTO TT_TASK_TYPE (TT_ID, TT_NAME) VALUES ( 107, 'ANš');
INSERT INTO TT_TASK_TYPE (TT_ID, TT_NAME) VALUES ( 108, 'Verl„ngerung ANš');
INSERT INTO TT_TASK_TYPE (TT_ID, TT_NAME) VALUES ( 109, 'Verl„ngerung Praktika');
INSERT INTO TT_TASK_TYPE (TT_ID, TT_NAME) VALUES ( 110, 'Verl„ngerung Werksstudenten');
INSERT INTO TT_TASK_TYPE (TT_ID, TT_NAME) VALUES ( 111, 'Verl„ngerung Wissenschaftliche Arbeiten');
INSERT INTO TT_TASK_TYPE (TT_ID, TT_NAME) VALUES ( 112, 'Abpordnung');

INSERT INTO TT_TASK_TYPE (TT_ID, TT_NAME) VALUES ( 200, 'Umgruppierungen' );
INSERT INTO TT_TASK_TYPE (TT_ID, TT_NAME) VALUES ( 201, 'Mehrarbeit');

commit;
