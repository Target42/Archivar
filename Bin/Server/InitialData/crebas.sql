/* ============================================================ */
/*   Database name:  MODEL_2                                    */
/*   DBMS name:      InterBase                                  */
/*   Created on:     10.09.2024  20:06                          */
/* ============================================================ */

create generator gen_be_id;
create generator gen_cp_id;
create generator gen_ct_id;
create generator gen_da_id;
create generator gen_di_id;
create generator gen_dr_id;
create generator gen_el_id;
create generator gen_ep_id;
create generator gen_fc_id;
create generator gen_fd_id;
create generator gen_fi_id;
create generator gen_gr_id;
create generator gen_hc_id;
create generator gen_ln_id;
create generator gen_lt_id;
create generator gen_ma_id;
create generator gen_mac_id;
create generator gen_maf_id;
create generator gen_mam_id;
create generator gen_pe_id;
create generator gen_pi_id;
create generator gen_pk_id;
create generator gen_pl_id;
create generator gen_pr_id;
create generator gen_st_id;
create generator gen_ta_id;
create generator gen_tb_id;
create generator gen_te_id;
create generator gen_tg_id;
create generator gen_tn_id;
create generator gen_ty_id;
create generator gen_wi_id;
create generator gen_wa_id;
create generator gen_wl_id;
create generator gen_wd_id;
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
    TB_CLID                         VARCHAR(38)                    ,
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
/*   Table: FH_FILE_HIST                                        */
/* ============================================================ */
create table FH_FILE_HIST
(
    FI_ID                           INTEGER                not null,
    FI_VERSION                      INTEGER                not null,
    FI_NAME                         VARCHAR(150)                   ,
    FI_TYPE                         VARCHAR(10)                    ,
    FI_CREATED                      DATE                           ,
    FI_TODELETE                     DATE                           ,
    FI_CREATED_BY                   VARCHAR(200)                   ,
    FI_DATA                         BLOB                           ,
    FI_SIZE                         BIGINT                         ,
    constraint PK_FH_FILE_HIST primary key (FI_ID, FI_VERSION)
);

/* ============================================================ */
/*   Table: PL_PLUGIN                                           */
/* ============================================================ */
create table PL_PLUGIN
(
    PL_ID                           INTEGER                not null,
    PL_NAME                         VARCHAR(150)                   ,
    PL_DATA                         BLOB                           ,
    PL_MD5                          VARCHAR(32)                    ,
    PL_STATE                        CHAR(1)                        ,
    PL_FILENAME                     VARCHAR(250)                   ,
    constraint PK_PL_PLUGIN primary key (PL_ID)
);

/* ============================================================ */
/*   Index: PL_PLUGIN_NAME                                      */
/* ============================================================ */
create unique ASC index PL_PLUGIN_NAME on PL_PLUGIN (PL_NAME);

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
/*   Table: FC_FILE_CACHE                                       */
/* ============================================================ */
create table FC_FILE_CACHE
(
    FC_ID                           INTEGER                not null,
    FC_NAME                         VARCHAR(100)                   ,
    FC_CACHE                        VARCHAR(50)                    ,
    FC_MD5                          VARCHAR(32)                    ,
    FC_STAMP                        TIMESTAMP                      ,
    FC_DATA                         BLOB                           ,
    constraint PK_FC_FILE_CACHE primary key (FC_ID)
);

/* ============================================================ */
/*   Index: FC_FILE_CACHE_NAME                                  */
/* ============================================================ */
create ASC index FC_FILE_CACHE_NAME on FC_FILE_CACHE (FC_NAME);

/* ============================================================ */
/*   Table: DR_DIR                                              */
/* ============================================================ */
create table DR_DIR
(
    DR_ID                           INTEGER                not null,
    DR_GROUP                        INTEGER                        ,
    DR_PARENT                       INTEGER                        ,
    DR_NAME                         VARCHAR(150)                   ,
    DR_STAMP                        TIMESTAMP                      ,
    DR_SIZE                         BIGINT                         ,
    constraint PK_DR_DIR primary key (DR_ID)
);

/* ============================================================ */
/*   Index: DR_DIR_SEC                                          */
/* ============================================================ */
create ASC index DR_DIR_SEC on DR_DIR (DR_GROUP);

/* ============================================================ */
/*   Table: MAC_MAIL_ACCOUNT                                    */
/* ============================================================ */
create table MAC_MAIL_ACCOUNT
(
    MAC_ID                          INTEGER                not null,
    MAC_TITLE                       VARCHAR(150)                   ,
    MAC_TYPE                        VARCHAR(32)                    ,
    MAC_DATA                        BLOB                           ,
    MAC_ACTIVE                      CHAR(1)                        ,
    constraint PK_MAC_MAIL_ACCOUNT primary key (MAC_ID)
);

/* ============================================================ */
/*   Table: WI_WIKI                                             */
/* ============================================================ */
create table WI_WIKI
(
    WI_ID                           INTEGER                not null,
    WI_NAME                         VARCHAR(250)                   ,
    WI_USER                         VARCHAR(100)                   ,
    WI_STAMP                        TIMESTAMP                      ,
    constraint PK_WI_WIKI primary key (WI_ID)
);

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
    DR_ID                           INTEGER                        ,
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
    TA_DELETED                      CHAR(1)                        ,
    TA_BEARBEITER                   VARCHAR(255)                   ,
    TA_MSGID                        VARCHAR(255)                   ,
    constraint PK_TA_TASK primary key (TA_ID)
);

/* ============================================================ */
/*   Index: TA_TASK_CLID                                        */
/* ============================================================ */
create unique ASC index TA_TASK_CLID on TA_TASK (TA_CLID);

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
/*   Index: CT_CHAPTER_TEXT_TA                                  */
/* ============================================================ */
create ASC index CT_CHAPTER_TEXT_TA on CT_CHAPTER_TEXT (TA_ID, CT_ID);

/* ============================================================ */
/*   Table: FI_FILE                                             */
/* ============================================================ */
create table FI_FILE
(
    FI_ID                           INTEGER                not null,
    DR_ID                           INTEGER                        ,
    FI_NAME                         VARCHAR(150)                   ,
    FI_TYPE                         VARCHAR(10)                    ,
    FI_DATA                         BLOB                           ,
    FI_CREATED                      DATE                           ,
    FI_TODELETE                     DATE                           ,
    FI_VERSION                      INTEGER                        ,
    FI_CREATED_BY                   VARCHAR(200)                   ,
    FI_SIZE                         BIGINT                         ,
    FI_LOCKED                       CHAR(1)                        ,
    PE_ID                           INTEGER                        ,
    constraint PK_FI_FILE primary key (FI_ID)
);

/* ============================================================ */
/*   Index: FI_FILE_SEC                                         */
/* ============================================================ */
create ASC index FI_FILE_SEC on FI_FILE (DR_ID, FI_ID);

/* ============================================================ */
/*   Table: GR_GREMIUM                                          */
/* ============================================================ */
create table GR_GREMIUM
(
    GR_ID                           INTEGER                not null,
    DR_ID                           INTEGER                        ,
    GR_NAME                         VARCHAR(100)                   ,
    GR_SHORT                        VARCHAR(20)                    ,
    GR_PARENT_SHORT                 VARCHAR(20)                    ,
    GR_CHANGES                      BLOB                           ,
    GR_PIC_NAME                     VARCHAR(100)                   ,
    GR_COLOR                        INTEGER                        ,
    constraint PK_GR_GREMIUM primary key (GR_ID)
);

/* ============================================================ */
/*   Index: GR_GREMIUM_SHORT                                    */
/* ============================================================ */
create unique ASC index GR_GREMIUM_SHORT on GR_GREMIUM (GR_SHORT);

/* ============================================================ */
/*   Table: PE_PERSON                                           */
/* ============================================================ */
create table PE_PERSON
(
    PE_ID                           INTEGER                not null,
    DR_ID                           INTEGER                        ,
    PE_NAME                         VARCHAR(100)                   ,
    PE_VORNAME                      VARCHAR(100)                   ,
    PE_DEPARTMENT                   VARCHAR(25)                    ,
    PE_NET                          VARCHAR(25)                    ,
    PE_MAIL                         VARCHAR(200)                   ,
    PE_PWD                          VARCHAR(64)                    ,
    PE_ROLS                         VARCHAR(200)                   ,
    PE_KEY                          BLOB                           ,
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
/*   Table: MAF_FOLDER                                          */
/* ============================================================ */
create table MAF_FOLDER
(
    MAF_ID                          INTEGER                not null,
    MAC_ID                          INTEGER                        ,
    MAF_NAME                        VARCHAR(255)                   ,
    MAF_ACTIVE                      CHAR(1)                        ,
    constraint PK_MAF_FOLDER primary key (MAF_ID)
);

/* ============================================================ */
/*   Index: MAF_FOLDER_NAME                                     */
/* ============================================================ */
create unique ASC index MAF_FOLDER_NAME on MAF_FOLDER (MAC_ID, MAF_NAME);

/* ============================================================ */
/*   Table: WA_ARTIKEL                                          */
/* ============================================================ */
create table WA_ARTIKEL
(
    WA_ID                           INTEGER                not null,
    WI_ID                           INTEGER                        ,
    WA_NAME                         VARCHAR(255)                   ,
    WA_TEXT                         BLOB                           ,
    WA_TAGS                         VARCHAR(255)                   ,
    WA_CREATED                      VARCHAR(100)                   ,
    WA_EDITED                       VARCHAR(100)                   ,
    WA_STAMP                        TIMESTAMP                      ,
    WA_PARENT                       INTEGER                        ,
    constraint PK_WA_ARTIKEL primary key (WA_ID)
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

/* ============================================================ */
/*   Table: FL_FILE_LOCK                                        */
/* ============================================================ */
create table FL_FILE_LOCK
(
    FC_ID                           INTEGER                not null,
    PE_ID                           INTEGER                        ,
    FL_USER                         VARCHAR(150)                   ,
    FL_STAMP                        TIMESTAMP                      ,
    constraint PK_FL_FILE_LOCK primary key (FC_ID)
);

/* ============================================================ */
/*   Table: LT_TASK_LOG                                         */
/* ============================================================ */
create table LT_TASK_LOG
(
    LT_ID                           INTEGER                not null,
    TA_ID                           INTEGER                        ,
    LT_STAMP                        TIMESTAMP                      ,
    LT_NAME                         VARCHAR(200)                   ,
    LT_REM                          BLOB                           ,
    constraint PK_LT_TASK_LOG primary key (LT_ID)
);

/* ============================================================ */
/*   Index: LT_TASK_LOG                                         */
/* ============================================================ */
create ASC index LT_TASK_LOG on LT_TASK_LOG (TA_ID, LT_STAMP);

/* ============================================================ */
/*   Table: PK_PUBLIC_KEY                                       */
/* ============================================================ */
create table PK_PUBLIC_KEY
(
    PE_ID                           INTEGER                not null,
    PK_ID                           INTEGER                not null,
    PK_START                        TIMESTAMP                      ,
    PK_END                          TIMESTAMP                      ,
    PK_DATA                         BLOB                           ,
    constraint PK_PK_PUBLIC_KEY primary key (PE_ID, PK_ID)
);

/* ============================================================ */
/*   Table: DI_DAIRY                                            */
/* ============================================================ */
create table DI_DAIRY
(
    DI_ID                           INTEGER                not null,
    PE_ID                           INTEGER                        ,
    DI_STAMP                        TIMESTAMP                      ,
    DI_CRYPTED                      CHAR(1)                        ,
    DI_TEXT                         BLOB                           ,
    DI_TAGS                         VARCHAR(255)                   ,
    constraint PK_DI_DAIRY primary key (DI_ID)
);

/* ============================================================ */
/*   Index: DI_DAIRY_USER                                       */
/* ============================================================ */
create DESC index DI_DAIRY_USER on DI_DAIRY (PE_ID, DI_STAMP);

/* ============================================================ */
/*   Table: ST_STORAGE                                          */
/* ============================================================ */
create table ST_STORAGE
(
    ST_ID                           INTEGER                not null,
    DR_ID                           INTEGER                        ,
    ST_NAME                         VARCHAR(150)                   ,
    constraint PK_ST_STORAGE primary key (ST_ID)
);

/* ============================================================ */
/*   Index: ST_STORAGE_NAME                                     */
/* ============================================================ */
create unique ASC index ST_STORAGE_NAME on ST_STORAGE (ST_NAME);

/* ============================================================ */
/*   Table: FI_LOCK                                             */
/* ============================================================ */
create table FI_LOCK
(
    FI_ID                           INTEGER                not null,
    PE_ID                           INTEGER                        ,
    FI_STAMP                        TIMESTAMP                      ,
    FI_USER                         VARCHAR(250)                   ,
    FI_HOST                         VARCHAR(30)                    ,
    constraint PK_FI_LOCK primary key (FI_ID)
);

/* ============================================================ */
/*   Table: FI_EV                                               */
/* ============================================================ */
create table FI_EV
(
    FI_ID                           INTEGER                not null,
    PE_ID                           INTEGER                not null,
    EV_EVENT                        INTEGER                        ,
    constraint PK_FI_EV primary key (FI_ID, PE_ID)
);

/* ============================================================ */
/*   Table: DR_EV                                               */
/* ============================================================ */
create table DR_EV
(
    DR_ID                           INTEGER                not null,
    PE_ID                           INTEGER                not null,
    EV_EVENT                        INTEGER                        ,
    constraint PK_DR_EV primary key (DR_ID, PE_ID)
);

/* ============================================================ */
/*   Table: GR_TY                                               */
/* ============================================================ */
create table GR_TY
(
    GR_ID                           INTEGER                not null,
    TY_ID                           INTEGER                not null,
    constraint PK_GR_TY primary key (GR_ID, TY_ID)
);

/* ============================================================ */
/*   Table: MAM_MAIL                                            */
/* ============================================================ */
create table MAM_MAIL
(
    MAM_ID                          INTEGER                not null,
    MAF_ID                          INTEGER                        ,
    MAM_SENDER                      VARCHAR(255)                   ,
    MAM_DATE                        TIMESTAMP                      ,
    MAM_TITLE                       VARCHAR(255)                   ,
    MAM_DATA                        BLOB                           ,
    MAM_ATTACH                      INTEGER                        ,
    MAM_MSG_ID                      VARCHAR(32)                    ,
    MAM_STATUS                      VARCHAR(100)                   ,
    MAM_KATEGORIE                   VARCHAR(100)                   ,
    constraint PK_MAM_MAIL primary key (MAM_ID)
);

/* ============================================================ */
/*   Index: MAM_MAIL_ID                                         */
/* ============================================================ */
create ASC index MAM_MAIL_ID on MAM_MAIL (MAF_ID, MAM_MSG_ID);

/* ============================================================ */
/*   Table: TS_TASK_STATUS                                      */
/* ============================================================ */
create table TS_TASK_STATUS
(
    TA_ID                           INTEGER                not null,
    TA_CLID                         VARCHAR(38)                    ,
    TS_STAMP                        TIMESTAMP                      ,
    TS_STATUS                       VARCHAR(255)                   ,
    TS_TEXT                         BLOB                           ,
    TS_AKTIV                        CHAR(1)                        ,
    constraint PK_TS_TASK_STATUS primary key (TA_ID)
);

/* ============================================================ */
/*   Table: WL_LINKS                                            */
/* ============================================================ */
create table WL_LINKS
(
    WL_ID                           INTEGER                not null,
    WA_ID                           INTEGER                        ,
    WL_NAME                         VARCHAR(255)                   ,
    WL_LINK                         VARCHAR(255)                   ,
    constraint PK_WL_LINKS primary key (WL_ID)
);

/* ============================================================ */
/*   Table: WD_DATA                                             */
/* ============================================================ */
create table WD_DATA
(
    WD_ID                           INTEGER                not null,
    WA_ID                           INTEGER                        ,
    WD_NAME                         VARCHAR(255)                   ,
    WD_DATA                         BLOB                           ,
    WD_USER                         VARCHAR(100)                   ,
    WD_STAMP                        TIMESTAMP                      ,
    constraint PK_WD_DATA primary key (WD_ID)
);

alter table TE_TEMPLATE
    add constraint FK_REF_3353 foreign key  (TY_ID)
       references TY_TASKTYPE;

alter table TA_TASK
    add constraint FK_REF_67 foreign key  (TY_ID)
       references TY_TASKTYPE;

alter table TA_TASK
    add constraint FK_REF_3336 foreign key  (TE_ID)
       references TE_TEMPLATE;

alter table TA_TASK
    add constraint FK_REF_10388 foreign key  (DR_ID)
       references DR_DIR;

alter table CT_CHAPTER_TEXT
    add constraint FK_REF_3850 foreign key  (CP_ID)
       references CP_CHAPTER;

alter table CT_CHAPTER_TEXT
    add constraint FK_REF_4070 foreign key  (TA_ID)
       references TA_TASK;

alter table FI_FILE
    add constraint FK_REF_10074 foreign key  (DR_ID)
       references DR_DIR;

alter table GR_GREMIUM
    add constraint FK_REF_10392 foreign key  (DR_ID)
       references DR_DIR;

alter table PE_PERSON
    add constraint FK_REF_10396 foreign key  (DR_ID)
       references DR_DIR;

alter table PR_PROTOKOL
    add constraint FK_REF_108 foreign key  (GR_ID)
       references GR_GREMIUM;

alter table CP_CHAPTER
    add constraint FK_REF_1627 foreign key  (PR_ID)
       references PR_PROTOKOL;

alter table MAF_FOLDER
    add constraint FK_REF_14034 foreign key  (MAC_ID)
       references MAC_MAIL_ACCOUNT;

alter table WA_ARTIKEL
    add constraint FK_REF_16194 foreign key  (WI_ID)
       references WI_WIKI;

alter table GR_PA
    add constraint FK_REF_16 foreign key  (GR_ID)
       references GR_GREMIUM;

alter table GR_PA
    add constraint FK_REF_20 foreign key  (PE_ID)
       references PE_PERSON;

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

alter table FL_FILE_LOCK
    add constraint FK_REF_7931 foreign key  (FC_ID)
       references FC_FILE_CACHE;

alter table FL_FILE_LOCK
    add constraint FK_REF_7935 foreign key  (PE_ID)
       references PE_PERSON;

alter table LT_TASK_LOG
    add constraint FK_REF_8996 foreign key  (TA_ID)
       references TA_TASK;

alter table PK_PUBLIC_KEY
    add constraint FK_REF_9279 foreign key  (PE_ID)
       references PE_PERSON;

alter table DI_DAIRY
    add constraint FK_REF_9581 foreign key  (PE_ID)
       references PE_PERSON;

alter table ST_STORAGE
    add constraint FK_REF_11191 foreign key  (DR_ID)
       references DR_DIR;

alter table FI_LOCK
    add constraint FK_REF_11537 foreign key  (PE_ID)
       references PE_PERSON;

alter table FI_EV
    add constraint FK_REF_11553 foreign key  (FI_ID)
       references FI_FILE;

alter table DR_EV
    add constraint FK_REF_11566 foreign key  (DR_ID)
       references DR_DIR;

alter table GR_TY
    add constraint FK_REF_12252 foreign key  (GR_ID)
       references GR_GREMIUM;

alter table GR_TY
    add constraint FK_REF_12256 foreign key  (TY_ID)
       references TY_TASKTYPE;

alter table MAM_MAIL
    add constraint FK_REF_14049 foreign key  (MAF_ID)
       references MAF_FOLDER;

alter table TS_TASK_STATUS
    add constraint FK_REF_15582 foreign key  (TA_ID)
       references TA_TASK;

alter table WL_LINKS
    add constraint FK_REF_16202 foreign key  (WA_ID)
       references WA_ARTIKEL;

alter table WD_DATA
    add constraint FK_REF_16659 foreign key  (WA_ID)
       references WA_ARTIKEL;

set term /;
CREATE TRIGGER SET_CP_CHAPTER FOR CP_CHAPTER
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  IF (NEW.CP_CREATED IS NULL) THEN
    NEW.CP_CREATED = CURRENT_TIMESTAMP;
END
;/
set term ;/

set term /;
CREATE TRIGGER SET_CT_CHAPTER_TEXT FOR CT_CHAPTER_TEXT
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  IF (NEW.CT_CREATED IS NULL) THEN
    NEW.CT_CREATED = CURRENT_TIMESTAMP;
END
;/
set term ;/

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

set term /;
CREATE TRIGGER SET_DR_DIR_NEW FOR DR_DIR
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  IF (NEW.DR_STAMP IS NULL) THEN
    NEW.DR_STAMP = CURRENT_TIMESTAMP;
END
;/

set term ;/
/*  Insert trigger "tu_ts_task_status" for table "TS_TASK_STATUS"  */
set term /;
create trigger tu_ts_task_status for TS_TASK_STATUS
before update as
begin
    new.ts_stamp = current_timestamp;

end;/
set term ;/


commit;

INSERT INTO PE_PERSON (PE_ID, PE_NAME, PE_VORNAME, PE_DEPARTMENT, PE_NET,
    PE_MAIL, PE_PWD, PE_ROLS)
VALUES (
    1, 
    'Doe', 
    'John', 
    'Admin', 
    'admin', 
    '', 
    '',
    'admin'
);

set generator gen_pe_id to 100;
set generator gen_te_id to 100;
set generator gen_ty_id to 100;
