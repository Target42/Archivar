/* ============================================================ */
/*   Database name:  MODEL_2                                    */
/*   DBMS name:      InterBase                                  */
/*   Created on:     10.09.2021  17:05                          */
/* ============================================================ */

create generator gen_be_id;
create generator gen_ct_id;
create generator gen_cp_id;
create generator gen_da_id;
create generator gen_el_id;
create generator gen_fi_id;
create generator gen_fd_id;
create generator gen_gr_id;
create generator gen_hc_id;
create generator gen_ln_id;
create generator gen_ma_id;
create generator gen_pi_id;
create generator gen_pe_id;
create generator gen_pr_id;
create generator gen_ta_id;
create generator gen_tb_id;
create generator gen_te_id;
create generator gen_tg_id;
create generator gen_tn_id;
create generator gen_ty_id;
create generator gen_ep_id;
/* ============================================================ */
/*   Table: MA_MITAREITER                                       */
/* ============================================================ */
create table MA_MITAREITER
(
    MA_ID                           INTEGER                not null,
    MA_NAME                         VARCHAR(100)                   ,
    MA_VORNAME                      VARCHAR(100)                   ,
    MA_DEPT                         VARCHAR(100)                   ,
    constraint PK_MA_MITAREITER primary key (MA_ID)
);

/* ============================================================ */
/*   Table: FD_DELETE                                           */
/* ============================================================ */
create table FD_DELETE
(
    FD_ID                           INTEGER                not null,
    FD_NAME                         VARCHAR(100)                   ,
    FD_MONATE                       INTEGER                        ,
    FD_TEXT                         VARCHAR(25)                    ,
    constraint PK_FD_DELETE primary key (FD_ID)
);

/* ============================================================ */
/*   Table: PI_PIC                                              */
/* ============================================================ */
create table PI_PIC
(
    PI_ID                           INTEGER                not null,
    PI_NAME                         VARCHAR(100)                   ,
    PI_MD5                          VARCHAR(32)                    ,
    PI_DATA                         BLOB                           ,
    constraint PK_PI_PIC primary key (PI_ID)
);

/* ============================================================ */
/*   Index: PI_PIC_NAME                                         */
/* ============================================================ */
create unique ASC index PI_PIC_NAME on PI_PIC (PI_NAME);

/* ============================================================ */
/*   Table: DA_DATAFIELD                                        */
/* ============================================================ */
create table DA_DATAFIELD
(
    DA_ID                           INTEGER                not null,
    DA_NAME                         VARCHAR(50)                    ,
    DA_TYPE                         VARCHAR(50)                    ,
    DA_REM                          VARCHAR(250)                   ,
    DA_CLID                         VARCHAR(38)                    ,
    DA_PROPS                        BLOB                           ,
    constraint PK_DA_DATAFIELD primary key (DA_ID)
);

/* ============================================================ */
/*   Index: DA_DATAFIELD_SEC                                    */
/* ============================================================ */
create unique ASC index DA_DATAFIELD_SEC on DA_DATAFIELD (DA_NAME);

/* ============================================================ */
/*   Table: IN_INTERNAL                                         */
/* ============================================================ */
create table IN_INTERNAL
(
    IN_NAME                         VARCHAR(100)           not null,
    IN_VALUE                        VARCHAR(255)                   ,
    constraint PK_IN_INTERNAL primary key (IN_NAME)
);

/* ============================================================ */
/*   Table: TB_TEXT                                             */
/* ============================================================ */
create table TB_TEXT
(
    TB_ID                           INTEGER                not null,
    TB_NAME                         VARCHAR(200)                   ,
    TB_TEXT                         BLOB                           ,
    TB_TAGS                         VARCHAR(255)                   ,
    constraint PK_TB_TEXT primary key (TB_ID)
);

/* ============================================================ */
/*   Index: TB_TEXT_NAME_INX                                    */
/* ============================================================ */
create unique ASC index TB_TEXT_NAME_INX on TB_TEXT (TB_NAME);

/* ============================================================ */
/*   Table: HC_HTTP                                             */
/* ============================================================ */
create table HC_HTTP
(
    HC_ID                           INTEGER                not null,
    HC_NAME                         VARCHAR(255)                   ,
    HC_PATH                         VARCHAR(255)                   ,
    HC_MD5                          VARCHAR(32)                    ,
    HC_DATA                         BLOB                           ,
    constraint PK_HC_HTTP primary key (HC_ID)
);

/* ============================================================ */
/*   Table: EP_EPUB                                             */
/* ============================================================ */
create table EP_EPUB
(
    EP_ID                           INTEGER                not null,
    EP_NAME                         VARCHAR(100)                   ,
    EP_TITLE                        VARCHAR(200)                   ,
    EP_MD5                          VARCHAR(32)                    ,
    EP_GROUP                        VARCHAR(50)                    ,
    EP_SUB                          VARCHAR(50)                    ,
    EP_DATA                         BLOB                           ,
    constraint PK_EP_EPUB primary key (EP_ID)
);

/* ============================================================ */
/*   Index: EP_EPUB_TITLE_INX                                   */
/* ============================================================ */
create ASC index EP_EPUB_TITLE_INX on EP_EPUB (EP_TITLE);

/* ============================================================ */
/*   Index: EP_EPUB_NAME_INX                                    */
/* ============================================================ */
create ASC index EP_EPUB_NAME_INX on EP_EPUB (EP_NAME);

/* ============================================================ */
/*   Table: LN_LINK                                             */
/* ============================================================ */
create table LN_LINK
(
    LN_ID                           INTEGER                not null,
    LN_SHORT                        VARCHAR(200)                   ,
    LN_DEST                         BLOB                           ,
    LN_INTERVAL                     INTEGER                        ,
    LN_CREATED                      DATE                           ,
    LN_USER                         VARCHAR(200)                   ,
    LN_TAGS                         VARCHAR(256)                   ,
    constraint PK_LN_LINK primary key (LN_ID)
);

/* ============================================================ */
/*   Index: LN_LINK_SEC                                         */
/* ============================================================ */
create ASC index LN_LINK_SEC on LN_LINK (LN_SHORT);

/* ============================================================ */
/*   Table: PE_PERSON                                           */
/* ============================================================ */
create table PE_PERSON
(
    PE_ID                           INTEGER                not null,
    PE_NAME                         VARCHAR(100)                   ,
    PE_VORNAME                      VARCHAR(100)                   ,
    PE_DEPARTMENT                   VARCHAR(25)                    ,
    PE_NET                          VARCHAR(25)                    ,
    PE_MAIL                         VARCHAR(200)                   ,
    PE_PWD                          VARCHAR(64)                    ,
    constraint PK_PE_PERSON primary key (PE_ID)
);

/* ============================================================ */
/*   Index: PE_PERSON_NAME                                      */
/* ============================================================ */
create ASC index PE_PERSON_NAME on PE_PERSON (PE_NAME, PE_VORNAME);

/* ============================================================ */
/*   Index: PE_PERSON_NET                                       */
/* ============================================================ */
create unique ASC index PE_PERSON_NET on PE_PERSON (PE_NET);

/* ============================================================ */
/*   Table: GR_GREMIUM                                          */
/* ============================================================ */
create table GR_GREMIUM
(
    GR_ID                           INTEGER                not null,
    GR_NAME                         VARCHAR(100)                   ,
    GR_SHORT                        VARCHAR(20)                    ,
    GR_PARENT_SHORT                 VARCHAR(20)                    ,
    GR_CHANGES                      BLOB                           ,
    GR_PIC_NAME                     VARCHAR(100)                   ,
    constraint PK_GR_GREMIUM primary key (GR_ID)
);

/* ============================================================ */
/*   Index: GR_GREMIUM_SHORT                                    */
/* ============================================================ */
create unique ASC index GR_GREMIUM_SHORT on GR_GREMIUM (GR_SHORT);

/* ============================================================ */
/*   Table: FI_FILE                                             */
/* ============================================================ */
create table FI_FILE
(
    FI_ID                           INTEGER                not null,
    FI_NAME                         VARCHAR(150)                   ,
    FI_TYPE                         VARCHAR(10)                    ,
    FI_DATA                         BLOB                           ,
    FI_CREATED                      DATE                           ,
    FI_TODELETE                     DATE                           ,
    FI_VERSION                      INTEGER                        ,
    FI_CREATED_BY                   VARCHAR(200)                   ,
    constraint PK_FI_FILE primary key (FI_ID)
);

/* ============================================================ */
/*   Table: TY_TASKTYPE                                         */
/* ============================================================ */
create table TY_TASKTYPE
(
    TY_ID                           INTEGER                not null,
    TY_NAME                         VARCHAR(100)                   ,
    TY_TAGE                         INTEGER                        ,
    constraint PK_TY_TASKTYPE primary key (TY_ID)
);

/* ============================================================ */
/*   Index: TY_TASKTYPE_SEC                                     */
/* ============================================================ */
create ASC index TY_TASKTYPE_SEC on TY_TASKTYPE (TY_NAME);

/* ============================================================ */
/*   Table: PR_PROTOKOL                                         */
/* ============================================================ */
create table PR_PROTOKOL
(
    PR_ID                           INTEGER                not null,
    GR_ID                           INTEGER                        ,
    PR_DATUM                        DATE                           ,
    PR_NR                           INTEGER                        ,
    PR_NAME                         VARCHAR(75)                    ,
    PR_STATUS                       CHAR(1)                        ,
    PR_DATA                         BLOB                           ,
    PR_CLID                         VARCHAR(38)                    ,
    constraint PK_PR_PROTOKOL primary key (PR_ID)
);

/* ============================================================ */
/*   Table: CP_CHAPTER                                          */
/* ============================================================ */
create table CP_CHAPTER
(
    PR_ID                           INTEGER                not null,
    CP_ID                           INTEGER                not null,
    CP_TITLE                        VARCHAR(200)                   ,
    CP_DATA                         BLOB                           ,
    CP_NR                           INTEGER                        ,
    CP_CREATED                      TIMESTAMP                      ,
    constraint PK_CP_CHAPTER primary key (CP_ID)
);

/* ============================================================ */
/*   Index: CP_CHAPTER_SEC                                      */
/* ============================================================ */
create ASC index CP_CHAPTER_SEC on CP_CHAPTER (PR_ID, CP_ID);

/* ============================================================ */
/*   Table: TE_TEMPLATE                                         */
/* ============================================================ */
create table TE_TEMPLATE
(
    TE_ID                           INTEGER                not null,
    TY_ID                           INTEGER                        ,
    TE_NAME                         VARCHAR(100)                   ,
    TE_SYSTEM                       CHAR(1)                        ,
    TE_TAGS                         VARCHAR(100)                   ,
    TE_SHORT                        VARCHAR(200)                   ,
    TE_DATA                         BLOB                           ,
    TE_STATE                        CHAR(1)                        ,
    TE_VERSION                      INTEGER                        ,
    TE_CLID                         VARCHAR(38)                    ,
    TE_MD5                          VARCHAR(32)                    ,
    constraint PK_TE_TEMPLATE primary key (TE_ID)
);

/* ============================================================ */
/*   Index: TE_TEMPLATE_NAME                                    */
/* ============================================================ */
create ASC index TE_TEMPLATE_NAME on TE_TEMPLATE (TE_NAME, TE_SYSTEM);

/* ============================================================ */
/*   Index: TE_TEMPLATE_CLID                                    */
/* ============================================================ */
create unique ASC index TE_TEMPLATE_CLID on TE_TEMPLATE (TE_CLID);

/* ============================================================ */
/*   Table: TA_TASK                                             */
/* ============================================================ */
create table TA_TASK
(
    TE_ID                           INTEGER                        ,
    TA_ID                           INTEGER                not null,
    TY_ID                           INTEGER                        ,
    TA_STARTED                      DATE                           ,
    TA_CREATED                      TIMESTAMP                      ,
    TA_NAME                         VARCHAR(200)                   ,
    TA_DATA                         BLOB                           ,
    TA_CREATED_BY                   VARCHAR(200)                   ,
    TA_TERMIN                       DATE                           ,
    TA_CLID                         VARCHAR(38)                    ,
    TA_FLAGS                        INTEGER                        ,
    TA_STATUS                       VARCHAR(50)                    ,
    TA_STYLE                        VARCHAR(200)                   ,
    TA_STYLE_CLID                   VARCHAR(38)                    ,
    TA_REM                          VARCHAR(256)                   ,
    TA_COLOR                        INTEGER                        ,
    constraint PK_TA_TASK primary key (TA_ID)
);

/* ============================================================ */
/*   Table: CT_CHAPTER_TEXT                                     */
/* ============================================================ */
create table CT_CHAPTER_TEXT
(
    CP_ID                           INTEGER                        ,
    CT_ID                           INTEGER                not null,
    TA_ID                           INTEGER                        ,
    CT_PARENT                       INTEGER                        ,
    CT_TITLE                        VARCHAR(200)                   ,
    CT_NUMBER                       INTEGER                        ,
    CT_DATA                         BLOB                           ,
    CT_POS                          INTEGER                        ,
    CT_CREATED                      TIMESTAMP                      ,
    constraint PK_CT_CHAPTER_TEXT primary key (CT_ID)
);

/* ============================================================ */
/*   Table: GR_PA                                               */
/* ============================================================ */
create table GR_PA
(
    GR_ID                           INTEGER                not null,
    PE_ID                           INTEGER                not null,
    GP_ROLLE                        VARCHAR(100)                   ,
    constraint PK_GR_PA primary key (GR_ID, PE_ID)
);

/* ============================================================ */
/*   Table: FI_TA                                               */
/* ============================================================ */
create table FI_TA
(
    TA_ID                           INTEGER                not null,
    FI_ID                           INTEGER                not null,
    constraint PK_FI_TA primary key (TA_ID, FI_ID)
);

/* ============================================================ */
/*   Table: BE_BESCHLUS                                         */
/* ============================================================ */
create table BE_BESCHLUS
(
    CT_ID                           INTEGER                not null,
    BE_ID                           INTEGER                not null,
    BE_TIMESTAMP                    TIMESTAMP                      ,
    BE_DATA                         BLOB                           ,
    BE_ANZ                          INTEGER                        ,
    BE_JA                           INTEGER                        ,
    BE_NEIN                         INTEGER                        ,
    BE_UN                           INTEGER                        ,
    BE_TITEL                        VARCHAR(100)                   ,
    constraint PK_BE_BESCHLUS primary key (CT_ID, BE_ID)
);

/* ============================================================ */
/*   Table: TN_TEILNEHMER                                       */
/* ============================================================ */
create table TN_TEILNEHMER
(
    PR_ID                           INTEGER                not null,
    TN_ID                           INTEGER                not null,
    TN_NAME                         VARCHAR(100)                   ,
    TN_VORNAME                      VARCHAR(100)                   ,
    TN_DEPARTMENT                   VARCHAR(25)                    ,
    TN_ROLLE                        VARCHAR(50)                    ,
    TN_STATUS                       INTEGER                        ,
    PE_ID                           INTEGER                        ,
    TN_GRUND                        VARCHAR(100)                   ,
    TN_READ                         TIMESTAMP                      ,
    constraint PK_TN_TEILNEHMER primary key (PR_ID, TN_ID)
);

/* ============================================================ */
/*   Index: TN_TEILNEHMER_SEC                                   */
/* ============================================================ */
create ASC index TN_TEILNEHMER_SEC on TN_TEILNEHMER (TN_NAME, TN_VORNAME, TN_DEPARTMENT);

/* ============================================================ */
/*   Table: TG_GAESTE                                           */
/* ============================================================ */
create table TG_GAESTE
(
    PR_ID                           INTEGER                not null,
    TG_ID                           INTEGER                not null,
    TG_NAME                         VARCHAR(100)                   ,
    TG_VORNAME                      VARCHAR(100)                   ,
    TG_DEPARTMENT                   VARCHAR(20)                    ,
    TG_VON                          TIME                           ,
    TG_BIS                          TIME                           ,
    TG_GRUND                        VARCHAR(255)                   ,
    constraint PK_TG_GAESTE primary key (PR_ID, TG_ID)
);

/* ============================================================ */
/*   Table: TO_OPEN                                             */
/* ============================================================ */
create table TO_OPEN
(
    GR_ID                           INTEGER                not null,
    TA_ID                           INTEGER                not null,
    constraint PK_TO_OPEN primary key (GR_ID, TA_ID)
);

/* ============================================================ */
/*   Table: EL_EINLADUNG                                        */
/* ============================================================ */
create table EL_EINLADUNG
(
    PR_ID                           INTEGER                        ,
    EL_ID                           INTEGER                not null,
    GR_ID                           INTEGER                        ,
    PE_ID                           INTEGER                        ,
    EL_DATUM                        DATE                           ,
    EL_ZEIT                         TIME                           ,
    EL_TITEL                        VARCHAR(200)                   ,
    EL_DATA                         BLOB                           ,
    EL_DATA_STAMP                   TIMESTAMP                      ,
    EL_ENDE                         TIME                           ,
    EL_STATUS                       CHAR(1)                        ,
    EL_CLID                         VARCHAR(38)                    ,
    constraint PK_EL_EINLADUNG primary key (EL_ID)
);

alter table PR_PROTOKOL
    add constraint FK_REF_108 foreign key  (GR_ID)
       references GR_GREMIUM;

alter table CP_CHAPTER
    add constraint FK_REF_1627 foreign key  (PR_ID)
       references PR_PROTOKOL;

alter table TE_TEMPLATE
    add constraint FK_REF_3353 foreign key  (TY_ID)
       references TY_TASKTYPE;

alter table TA_TASK
    add constraint FK_REF_67 foreign key  (TY_ID)
       references TY_TASKTYPE;

alter table TA_TASK
    add constraint FK_REF_3336 foreign key  (TE_ID)
       references TE_TEMPLATE;

alter table CT_CHAPTER_TEXT
    add constraint FK_REF_3850 foreign key  (CP_ID)
       references CP_CHAPTER;

alter table CT_CHAPTER_TEXT
    add constraint FK_REF_4070 foreign key  (TA_ID)
       references TA_TASK;

alter table GR_PA
    add constraint FK_REF_16 foreign key  (GR_ID)
       references GR_GREMIUM;

alter table GR_PA
    add constraint FK_REF_20 foreign key  (PE_ID)
       references PE_PERSON;

alter table FI_TA
    add constraint FK_REF_113 foreign key  (TA_ID)
       references TA_TASK;

alter table FI_TA
    add constraint FK_REF_117 foreign key  (FI_ID)
       references FI_FILE;

alter table BE_BESCHLUS
    add constraint FK_REF_5058 foreign key  (CT_ID)
       references CT_CHAPTER_TEXT;

alter table TN_TEILNEHMER
    add constraint FK_REF_1060 foreign key  (PR_ID)
       references PR_PROTOKOL;

alter table TG_GAESTE
    add constraint FK_REF_1071 foreign key  (PR_ID)
       references PR_PROTOKOL;

alter table TO_OPEN
    add constraint FK_REF_1251 foreign key  (GR_ID)
       references GR_GREMIUM;

alter table TO_OPEN
    add constraint FK_REF_1255 foreign key  (TA_ID)
       references TA_TASK;

alter table EL_EINLADUNG
    add constraint FK_REF_5543 foreign key  (GR_ID)
       references GR_GREMIUM;

alter table EL_EINLADUNG
    add constraint FK_REF_6727 foreign key  (PR_ID)
       references PR_PROTOKOL;

alter table EL_EINLADUNG
    add constraint FK_REF_7035 foreign key  (PE_ID)
       references PE_PERSON;


set term /;
CREATE TRIGGER SET_TA_TASK_NEW FOR TA_TASK
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  IF (NEW.TA_CREATED IS NULL) THEN
    NEW.TA_CREATED = CURRENT_TIMESTAMP;
END
;/
set term ;/


SET TERM ^ ;
CREATE TRIGGER EL_LAST_CHANGE FOR EL_EINLADUNG
ACTIVE BEFORE INSERT OR UPDATE POSITION 0
AS
BEGIN
new.EL_DATA_STAMP = current_timestamp;
END^
SET TERM ; ^ 

commit;

INSERT INTO PE_PERSON (PE_ID, PE_NAME, PE_VORNAME, PE_DEPARTMENT, PE_NET,
    PE_MAIL, PE_PWD)
VALUES (
    1, 
    'Doe', 
    'John', 
    'Admin', 
    'admin', 
    '', 
    ''
);

set generator gen_pe_id to 10;
