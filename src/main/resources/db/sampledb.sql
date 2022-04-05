CREATE MEMORY TABLE SAMPLE(ID VARCHAR(16) NOT NULL PRIMARY KEY,NAME VARCHAR(50),DESCRIPTION VARCHAR(100),USE_YN CHAR(1),REG_USER VARCHAR(10))
CREATE MEMORY TABLE IDS(TABLE_NAME VARCHAR(16) NOT NULL PRIMARY KEY,NEXT_ID DECIMAL(30) NOT NULL)
/**********************************/
/* Table Name: 사용자 */
/**********************************/
CREATE TABLE user(
		id VARCHAR(20),
		passwd VARCHAR(200),
		grade_cd VARCHAR(4),
		user_kind_cd VARCHAR(4),
		name VARCHAR(30) NOT NULL,
		birthday VARCHAR(8),
		cell_phone_no VARCHAR(13),
		email VARCHAR(30),
		session_key VARCHAR(80),
		session_limit TIMESTAMP,
		use_yn CHAR(1) DEFAULT 'Y',
		create_user_id VARCHAR(20),
		create_dt DATETIME,
		update_user_id VARCHAR(20),
		update_dt DATETIME
);

/**********************************/
/* Table Name: 등급코드_이력 */
/**********************************/
CREATE TABLE user_grade_history(
		id VARCHAR(20),
		grade_cd VARCHAR(4),
		create_user_id VARCHAR(20),
		create_dt DATETIME,
		update_user_id VARCHAR(20),
		update_dt DATETIME
);

/**********************************/
/* Table Name: 사용자_주소 */
/**********************************/
CREATE TABLE user_address(
		id VARCHAR(20),
		seq_no INT,
		addr VARCHAR(100),
		addr_detail VARCHAR(100),
		use_yn CHAR(1) DEFAULT 'Y'
);

/**********************************/
/* Table Name: 시스템_코드_그룹 */
/**********************************/
CREATE TABLE system_code_group(
		group_cd VARCHAR(4),
		group_cd_nm VARCHAR(50),
		create_user_id VARCHAR(20),
		create_dt DATETIME,
		update_user_id VARCHAR(20),
		update_dt DATETIME
);

/**********************************/
/* Table Name: 시스템_코드 */
/**********************************/
CREATE TABLE system_code(
		sys_cd VARCHAR(4),
		group_cd VARCHAR(4),
		sys_cd_nm VARCHAR(50),
		use_yn CHAR(1) DEFAULT 'Y',
		create_user_id VARCHAR(20),
		create_dt DATETIME,
		update_user_id VARCHAR(20),
		update_dt DATETIME
);

/**********************************/
/* Table Name: 매뉴 */
/**********************************/
CREATE TABLE menu(
		menu_cd VARCHAR(4),
		menu_nm VARCHAR(50),
		parent_menu_cd VARCHAR(4),
		path VARCHAR(100),
		menu_kind_cd VARCHAR(20),
		login_require_yn CHAR(1) DEFAULT 'N',
		attr1 VARCHAR(1000),
		attr2 VARCHAR(1000),
		use_yn CHAR(1) DEFAULT 'Y',
		create_user_id VARCHAR(20),
		create_dt DATETIME,
		update_user_id VARCHAR(20),
		update_dt DATETIME
);

/**********************************/
/* Table Name: 사용자_메뉴_권한 */
/**********************************/
CREATE TABLE user_menu_auth(
		id VARCHAR(20),
		menu_cd VARCHAR(4),
		create_user_id VARCHAR(20),
		create_dt DATETIME,
		update_user_id VARCHAR(20),
		update_dt DATETIME
);

/**********************************/
/* Table Name: API */
/**********************************/
CREATE TABLE api(
		api_cd VARCHAR(4),
		path VARCHAR(100),
		use_detail VARCHAR(300),
		login_require_yn CHAR(1) DEFAULT 'N',
		attr1 VARCHAR(1000),
		attr2 VARCHAR(1000),
		use_yn CHAR(1) DEFAULT 'Y'
);

/**********************************/
/* Table Name: 사용자_API_권한 */
/**********************************/
CREATE TABLE user_api_auth(
		id VARCHAR(20),
		api_cd VARCHAR(4)
);

/**********************************/
/* Table Name: 로그 */
/**********************************/
CREATE TABLE log(
		seq_no INT IDENTITY,
		id VARCHAR(20),
		timestamp VARCHAR(17),
		path VARCHAR(100),
		code VARCHAR(30),
		msg VARCHAR(2000),
		msg_detail VARCHAR(3000),
		input VARCHAR(4000),
		output VARCHAR(4000)
);


ALTER TABLE user ADD CONSTRAINT IDX_user_PK PRIMARY KEY (id);

ALTER TABLE user_grade_history ADD CONSTRAINT IDX_user_grade_history_PK PRIMARY KEY (id, grade_cd, create_dt);
ALTER TABLE user_grade_history ADD CONSTRAINT IDX_user_grade_history_FK0 FOREIGN KEY (id) REFERENCES user (id);

ALTER TABLE user_address ADD CONSTRAINT IDX_user_address_PK PRIMARY KEY (id, seq_no);
ALTER TABLE user_address ADD CONSTRAINT IDX_user_address_FK0 FOREIGN KEY (id) REFERENCES user (id);

ALTER TABLE system_code_group ADD CONSTRAINT IDX_system_code_group_PK PRIMARY KEY (group_cd);

ALTER TABLE system_code ADD CONSTRAINT IDX_system_code_PK PRIMARY KEY (sys_cd);
ALTER TABLE system_code ADD CONSTRAINT IDX_system_code_FK0 FOREIGN KEY (group_cd) REFERENCES system_code_group (group_cd);

ALTER TABLE menu ADD CONSTRAINT IDX_menu_PK PRIMARY KEY (menu_cd);
CREATE INDEX IDX_menu_1 ON menu (path);

ALTER TABLE user_menu_auth ADD CONSTRAINT IDX_user_menu_auth_PK PRIMARY KEY (id, menu_cd);
ALTER TABLE user_menu_auth ADD CONSTRAINT IDX_user_menu_auth_FK0 FOREIGN KEY (menu_cd) REFERENCES menu (menu_cd);
ALTER TABLE user_menu_auth ADD CONSTRAINT IDX_user_menu_auth_FK1 FOREIGN KEY (id) REFERENCES user (id);

ALTER TABLE api ADD CONSTRAINT IDX_api_PK PRIMARY KEY (api_cd);
ALTER TABLE api ADD CONSTRAINT IDX_api_1 UNIQUE (path);

ALTER TABLE user_api_auth ADD CONSTRAINT IDX_user_api_auth_PK PRIMARY KEY (id, api_cd);
ALTER TABLE user_api_auth ADD CONSTRAINT IDX_user_api_auth_FK0 FOREIGN KEY (api_cd) REFERENCES api (api_cd);
ALTER TABLE user_api_auth ADD CONSTRAINT IDX_user_api_auth_FK1 FOREIGN KEY (id) REFERENCES user (id);



INSERT INTO system_code_group VALUES(
	'1001',
	'사용자 유형',
	'ADMIN',
	SYSDATE,
	NULL,
	NULL
);

	INSERT INTO system_code VALUES (
		'0001',
		'1001',
		'고객',
		'Y',
		'ADMIN',
		SYSDATE,
		NULL,
		NULL
	);
	INSERT INTO system_code VALUES (
		'0002',
		'1001',
		'직원',
		'Y',
		'ADMIN',
		SYSDATE,
		NULL,
		NULL
	);

INSERT INTO system_code_group VALUES(
	'1002',
	'메뉴 종류',
	'ADMIN',
	SYSDATE,
	NULL,
	NULL
);

	INSERT INTO system_code VALUES (
		'0003',
		'1002',
		'고객용 메뉴',
		'Y',
		'ADMIN',
		SYSDATE,
		NULL,
		NULL
	);
	INSERT INTO system_code VALUES (
		'0004',
		'1002',
		'직원용 메뉴',
		'Y',
		'ADMIN',
		SYSDATE,
		NULL,
		NULL
	);

INSERT INTO system_code_group VALUES(
	'1003',
	'고객 등급 종류',
	'ADMIN',
	SYSDATE,
	NULL,
	NULL
);

	INSERT INTO system_code VALUES (
		'0005',
		'1003',
		'일반',
		'Y',
		'ADMIN',
		SYSDATE,
		NULL,
		NULL
	);
	INSERT INTO system_code VALUES (
		'0006',
		'1003',
		'실버',
		'Y',
		'ADMIN',
		SYSDATE,
		NULL,
		NULL
	);
	INSERT INTO system_code VALUES (
		'0007',
		'1003',
		'골드',
		'Y',
		'ADMIN',
		SYSDATE,
		NULL,
		NULL
	);
	
INSERT INTO menu (menu_cd, menu_nm, parent_menu_cd, path, menu_kind_cd, login_require_yn) values (
	'0001',
	'사용자',
	'0000',
	'/api/user',
	'0001',
	'N'
);
	INSERT INTO menu (menu_cd, menu_nm, parent_menu_cd, path, menu_kind_cd, login_require_yn) values (
		'0002',
		'로그인',
		'0001',
		'/api/user/login',
		'0001',
		'N'
	);
	INSERT INTO menu (menu_cd, menu_nm, parent_menu_cd, path, menu_kind_cd, login_require_yn) values (
		'0003',
		'회원가입',
		'0001',
		'/api/user/memberJoin',
		'0001',
		'N'
	);
	INSERT INTO menu (menu_cd, menu_nm, parent_menu_cd, path, menu_kind_cd, login_require_yn) values (
		'0004',
		'나의정보',
		'0001',
		'/api/user/myInfo',
		'0001',
		'Y'
	);
INSERT INTO menu (menu_cd, menu_nm, parent_menu_cd, path, menu_kind_cd, login_require_yn) values (
	'0005',
	'API',
	'0000',
	'/api',
	'0002',
	'Y'
);
	INSERT INTO menu (menu_cd, menu_nm, parent_menu_cd, path, menu_kind_cd, login_require_yn) values (
		'0006',
		'API',
		'0005',
		'/api/apiMng',
		'0002',
		'Y'
	);
INSERT INTO menu (menu_cd, menu_nm, parent_menu_cd, path, menu_kind_cd, login_require_yn) values (
	'0007',
	'시스템',
	'0000',
	'/api/sys',
	'0002',
	'Y'
);
	INSERT INTO menu (menu_cd, menu_nm, parent_menu_cd, path, menu_kind_cd, login_require_yn) values (
		'0008',
		'메뉴관리',
		'0007',
		'/api/sys/menuMng',
		'0002',
		'Y'
	);
	INSERT INTO menu (menu_cd, menu_nm, parent_menu_cd, path, menu_kind_cd, login_require_yn) values (
		'0009',
		'코드관리',
		'0007',
		'/api/sys/codeMng',
		'0002',
		'Y'
	);
	
INSERT INTO api (api_cd, path, use_detail, login_require_yn) values (
	'0001',
	'/api/user/joinUser.do',
	'회원가입',
	'N'
);
INSERT INTO api (api_cd, path, use_detail, login_require_yn) values (
	'0002',
	'/api/user/myInfo.do',
	'나의정보',
	'Y'
);
INSERT INTO api (api_cd, path, use_detail, login_require_yn) values (
	'0003',
	'/api/user/login.do',
	'로그인',
	'N'
);

SET SCHEMA PUBLIC
INSERT INTO SAMPLE VALUES('SAMPLE-00001','Runtime Environment','Foundation Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00002','Runtime Environment','Persistence Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00003','Runtime Environment','Presentation Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00004','Runtime Environment','Business Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00005','Runtime Environment','Batch Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00006','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00007','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00008','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00009','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00010','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00011','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00012','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00013','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00014','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00015','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00016','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00017','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00018','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00019','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00020','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00021','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00022','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00023','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00024','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00025','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00026','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00027','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00028','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00029','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00030','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00031','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00032','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00033','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00034','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00035','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00036','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00037','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00038','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00039','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00040','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00041','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00042','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00043','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00044','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00045','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00046','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00047','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00048','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00049','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00050','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00051','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00052','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00053','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00054','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00055','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00056','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00057','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00058','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00059','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00060','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00061','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00062','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00063','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00064','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00065','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00066','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00067','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00068','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00069','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00070','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00071','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00072','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00073','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00074','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00075','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00076','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00077','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00078','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00079','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00080','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00081','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00082','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00083','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00084','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00085','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00086','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00087','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00088','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00089','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00090','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00091','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00092','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00093','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00094','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00095','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00096','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00097','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00098','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00099','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00100','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00101','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00102','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00103','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00104','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00105','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00106','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00107','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00108','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00109','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00110','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00111','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00112','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00113','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO SAMPLE VALUES('SAMPLE-00114','Runtime Environment','Integration Layer','Y','eGov')
INSERT INTO IDS VALUES('SAMPLE',115)
