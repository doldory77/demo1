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
		session_limit VARCHAR(17),
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

/**********************************/
/* Table Name: 국가코드 */
/**********************************/
CREATE TABLE country(
		iso_cd VARCHAR(3),
		initials1 VARCHAR(3),
		initials2 VARCHAR(2),
		country_nm VARCHAR(100)
);


ALTER TABLE user ADD CONSTRAINT IDX_user_PK PRIMARY KEY (id);
CREATE INDEX IDX_user_1 ON user (session_key);

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

ALTER TABLE country ADD CONSTRAINT IDX_country_PK PRIMARY KEY (iso_cd);




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

INSERT INTO user (
	id,
	passwd,
	user_kind_cd,
	name,
	birthday,
	cell_phone_no,
	email,
	use_yn
) values (
	'demo1',
	'03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4',
	'0004',
	'홍길동',
	'19880404',
	'01012349999',
	'doldory@naver.com',
	'Y'
);

	INSERT INTO user_api_auth (id, api_cd) values (
		'demo1',
		'0002'
	);


SET SCHEMA PUBLIC
/*INSERT INTO SAMPLE VALUES('SAMPLE-00001','Runtime Environment','Foundation Layer','Y','eGov')
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
INSERT INTO IDS VALUES('SAMPLE',115)*/

INSERT INTO country VALUES ('288', 'GHA', 'GH', '가나')
INSERT INTO country VALUES ('266', 'GAB', 'GA', '가봉')
INSERT INTO country VALUES ('328', 'GUY', 'GY', '가이아나')
INSERT INTO country VALUES ('270', 'GMB', 'GM', '감비아')
INSERT INTO country VALUES ('831', 'GGY', 'GG', '건지 섬')
INSERT INTO country VALUES ('312', 'GLP', 'GP', '과들루프')
INSERT INTO country VALUES ('320', 'GTM', 'GT', '과테말라')
INSERT INTO country VALUES ('316', 'GUM', 'GU', '괌')
INSERT INTO country VALUES ('308', 'GRD', 'GD', '그레나다')
INSERT INTO country VALUES ('300', 'GRC', 'GR', '그리스')
INSERT INTO country VALUES ('304', 'GRL', 'GL', '그린란드')
INSERT INTO country VALUES ('324', 'GIN', 'GN', '기니')
INSERT INTO country VALUES ('624', 'GNB', 'GW', '기니비사우')
INSERT INTO country VALUES ('516', 'NAM', 'NA', '나미비아')
INSERT INTO country VALUES ('520', 'NRU', 'NR', '나우루')
INSERT INTO country VALUES ('566', 'NGA', 'NG', '나이지리아')
INSERT INTO country VALUES ('728', 'SSD', 'SS', '남수단')
INSERT INTO country VALUES ('710', 'ZAF', 'ZA', '남아프리카 공화국')
INSERT INTO country VALUES ('528', 'NLD', 'NL', '네덜란드')
INSERT INTO country VALUES ('530', 'ANT', 'AN', '네덜란드령 안틸레스')
INSERT INTO country VALUES ('524', 'NPL', 'NP', '네팔')
INSERT INTO country VALUES ('578', 'NOR', 'NO', '노르웨이')
INSERT INTO country VALUES ('574', 'NFK', 'NF', '노퍽 섬')
INSERT INTO country VALUES ('540', 'NCL', 'NC', '누벨칼레도니')
INSERT INTO country VALUES ('554', 'NZL', 'NZ', '뉴질랜드')
INSERT INTO country VALUES ('570', 'NIU', 'NU', '니우에')
INSERT INTO country VALUES ('562', 'NER', 'NE', '니제르')
INSERT INTO country VALUES ('558', 'NIC', 'NI', '니카라과')
INSERT INTO country VALUES ('410', 'KOR', 'KR', '대한민국')
INSERT INTO country VALUES ('208', 'DNK', 'DK', '덴마크')
INSERT INTO country VALUES ('214', 'DOM', 'DO', '도미니카 공화국')
INSERT INTO country VALUES ('212', 'DMA', 'DM', '도미니카 연방')
INSERT INTO country VALUES ('276', 'DEU', 'DE', '독일')
INSERT INTO country VALUES ('626', 'TLS', 'TL', '동티모르')
INSERT INTO country VALUES ('418', 'LAO', 'LA', '라오스')
INSERT INTO country VALUES ('430', 'LBR', 'LR', '라이베리아')
INSERT INTO country VALUES ('428', 'LVA', 'LV', '라트비아')
INSERT INTO country VALUES ('643', 'RUS', 'RU', '러시아')
INSERT INTO country VALUES ('422', 'LBN', 'LB', '레바논')
INSERT INTO country VALUES ('426', 'LSO', 'LS', '레소토')
INSERT INTO country VALUES ('638', 'REU', 'RE', '레위니옹')
INSERT INTO country VALUES ('642', 'ROU', 'RO', '루마니아')
INSERT INTO country VALUES ('442', 'LUX', 'LU', '룩셈부르크')
INSERT INTO country VALUES ('646', 'RWA', 'RW', '르완다')
INSERT INTO country VALUES ('434', 'LBY', 'LY', '리비아')
INSERT INTO country VALUES ('440', 'LTU', 'LT', '리투아니아')
INSERT INTO country VALUES ('438', 'LIE', 'LI', '리히텐슈타인')
INSERT INTO country VALUES ('450', 'MDG', 'MG', '마다가스카르')
INSERT INTO country VALUES ('474', 'MTQ', 'MQ', '마르티니크')
INSERT INTO country VALUES ('584', 'MHL', 'MH', '마셜 제도')
INSERT INTO country VALUES ('175', 'MYT', 'YT', '마요트')
INSERT INTO country VALUES ('446', 'MAC', 'MO', '마카오')
INSERT INTO country VALUES ('807', 'MKD', 'MK', '마케도니아 공화국')
INSERT INTO country VALUES ('454', 'MWI', 'MW', '말라위')
INSERT INTO country VALUES ('458', 'MYS', 'MY', '말레이시아')
INSERT INTO country VALUES ('466', 'MLI', 'ML', '말리')
INSERT INTO country VALUES ('833', 'IMN', 'IM', '맨 섬')
INSERT INTO country VALUES ('484', 'MEX', 'MX', '멕시코')
INSERT INTO country VALUES ('492', 'MCO', 'MC', '모나코')
INSERT INTO country VALUES ('504', 'MAR', 'MA', '모로코')
INSERT INTO country VALUES ('480', 'MUS', 'MU', '모리셔스')
INSERT INTO country VALUES ('478', 'MRT', 'MR', '모리타니')
INSERT INTO country VALUES ('508', 'MOZ', 'MZ', '모잠비크')
INSERT INTO country VALUES ('499', 'MNE', 'ME', '몬테네그로')
INSERT INTO country VALUES ('500', 'MSR', 'MS', '몬트세랫')
INSERT INTO country VALUES ('498', 'MDA', 'MD', '몰도바')
INSERT INTO country VALUES ('462', 'MDV', 'MV', '몰디브')
INSERT INTO country VALUES ('470', 'MLT', 'MT', '몰타')
INSERT INTO country VALUES ('496', 'MNG', 'MN', '몽골')
INSERT INTO country VALUES ('840', 'USA', 'US', '미국')
INSERT INTO country VALUES ('581', 'UMI', 'UM', '미국령 군소 제도')
INSERT INTO country VALUES ('850', 'VIR', 'VI', '미국령 버진아일랜드')
INSERT INTO country VALUES ('104', 'MMR', 'MM', '미얀마')
INSERT INTO country VALUES ('583', 'FSM', 'FM', '미크로네시아 연방')
INSERT INTO country VALUES ('548', 'VUT', 'VU', '바누아투')
INSERT INTO country VALUES ('336', 'VAT', 'VA', '바티칸 시국')
INSERT INTO country VALUES ('204', 'BEN', 'BJ', '베냉')
INSERT INTO country VALUES ('862', 'VEN', 'VE', '베네수엘라')
INSERT INTO country VALUES ('704', 'VNM', 'VN', '베트남')
INSERT INTO country VALUES ('112', 'BLR', 'BY', '벨라루스')
INSERT INTO country VALUES ('108', 'BDI', 'BI', '부룬디')
INSERT INTO country VALUES ('854', 'BFA', 'BF', '부르키나파소')
INSERT INTO country VALUES ('580', 'MNP', 'MP', '북마리아나 제도')
INSERT INTO country VALUES ('100', 'BGR', 'BG', '불가리아')
INSERT INTO country VALUES ('882', 'WSM', 'WS', '사모아')
INSERT INTO country VALUES ('682', 'SAU', 'SA', '사우디아라비아')
INSERT INTO country VALUES ('239', 'SGS', 'GS', '사우스조지아 사우스샌드위치 제도')
INSERT INTO country VALUES ('674', 'SMR', 'SM', '산마리노')
INSERT INTO country VALUES ('678', 'STP', 'ST', '상투메 프린시페')
INSERT INTO country VALUES ('666', 'SPM', 'PM', '생피에르 미클롱')
INSERT INTO country VALUES ('732', 'ESH', 'EH', '서사하라')
INSERT INTO country VALUES ('686', 'SEN', 'SN', '세네갈')
INSERT INTO country VALUES ('688', 'SRB', 'RS', '세르비아')
INSERT INTO country VALUES ('690', 'SYC', 'SC', '세이셸')
INSERT INTO country VALUES ('662', 'LCA', 'LC', '세인트루시아')
INSERT INTO country VALUES ('670', 'VCT', 'VC', '세인트빈센트 그레나딘')
INSERT INTO country VALUES ('659', 'KNA', 'KN', '세인트키츠 네비스')
INSERT INTO country VALUES ('654', 'SHN', 'SH', '세인트헬레나')
INSERT INTO country VALUES ('706', 'SOM', 'SO', '소말리아')
INSERT INTO country VALUES ('736', 'SDN', 'SD', '수단')
INSERT INTO country VALUES ('740', 'SUR', 'SR', '수리남')
INSERT INTO country VALUES ('144', 'LKA', 'LK', '스리랑카')
INSERT INTO country VALUES ('744', 'SJM', 'SJ', '스발바르 얀마옌')
INSERT INTO country VALUES ('748', 'SWZ', 'SZ', '스와질란드')
INSERT INTO country VALUES ('752', 'SWE', 'SE', '스웨덴')
INSERT INTO country VALUES ('756', 'CHE', 'CH', '스위스')
INSERT INTO country VALUES ('724', 'ESP', 'ES', '스페인')
INSERT INTO country VALUES ('703', 'SVK', 'SK', '슬로바키아')
INSERT INTO country VALUES ('705', 'SVN', 'SI', '슬로베니아')
INSERT INTO country VALUES ('760', 'SYR', 'SY', '시리아')
INSERT INTO country VALUES ('694', 'SLE', 'SL', '시에라리온')
INSERT INTO country VALUES ('702', 'SGP', 'SG', '싱가포르')
INSERT INTO country VALUES ('784', 'ARE', 'AE', '아랍에미리트')
INSERT INTO country VALUES ('352', 'ISL', 'IS', '아이슬란드')
INSERT INTO country VALUES ('332', 'HTI', 'HT', '아이티')
INSERT INTO country VALUES ('372', 'IRL', 'IE', '아일랜드')
INSERT INTO country VALUES ('660', 'AIA', 'AI', '앵귈라')
INSERT INTO country VALUES ('232', 'ERI', 'ER', '에리트레아')
INSERT INTO country VALUES ('233', 'EST', 'EE', '에스토니아')
INSERT INTO country VALUES ('218', 'ECU', 'EC', '에콰도르')
INSERT INTO country VALUES ('231', 'ETH', 'ET', '에티오피아')
INSERT INTO country VALUES ('222', 'SLV', 'SV', '엘살바도르')
INSERT INTO country VALUES ('826', 'GBR', 'GB', '영국')
INSERT INTO country VALUES ('887', 'YEM', 'YE', '예멘')
INSERT INTO country VALUES ('512', 'OMN', 'OM', '오만')
INSERT INTO country VALUES ('340', 'HND', 'HN', '온두라스')
INSERT INTO country VALUES ('248', 'ALA', 'AX', '올란드 제도')
INSERT INTO country VALUES ('876', 'WLF', 'WF', '왈리스 퓌튀나')
INSERT INTO country VALUES ('400', 'JOR', 'JO', '요르단')
INSERT INTO country VALUES ('800', 'UGA', 'UG', '우간다')
INSERT INTO country VALUES ('858', 'URY', 'UY', '우루과이')
INSERT INTO country VALUES ('860', 'UZB', 'UZ', '우즈베키스탄')
INSERT INTO country VALUES ('804', 'UKR', 'UA', '우크라이나')
INSERT INTO country VALUES ('368', 'IRQ', 'IQ', '이라크')
INSERT INTO country VALUES ('364', 'IRN', 'IR', '이란')
INSERT INTO country VALUES ('376', 'ISR', 'IL', '이스라엘')
INSERT INTO country VALUES ('818', 'EGY', 'EG', '이집트')
INSERT INTO country VALUES ('380', 'ITA', 'IT', '이탈리아')
INSERT INTO country VALUES ('356', 'IND', 'IN', '인도')
INSERT INTO country VALUES ('360', 'IDN', 'ID', '인도네시아')
INSERT INTO country VALUES ('392', 'JPN', 'JP', '일본')
INSERT INTO country VALUES ('388', 'JAM', 'JM', '자메이카')
INSERT INTO country VALUES ('894', 'ZMB', 'ZM', '잠비아')
INSERT INTO country VALUES ('832', 'JEY', 'JE', '저지 섬')
INSERT INTO country VALUES ('226', 'GNQ', 'GQ', '적도 기니')
INSERT INTO country VALUES ('408', 'PRK', 'KP', '조선민주주의인민공화국')
INSERT INTO country VALUES ('268', 'GEO', 'GE', '조지아')
INSERT INTO country VALUES ('140', 'CAF', 'CF', '중앙아프리카 공화국')
INSERT INTO country VALUES ('158', 'TWN', 'TW', '중화민국')
INSERT INTO country VALUES ('156', 'CHN', 'CN', '중화인민공화국')
INSERT INTO country VALUES ('262', 'DJI', 'DJ', '지부티')
INSERT INTO country VALUES ('292', 'GIB', 'GI', '지브롤터')
INSERT INTO country VALUES ('716', 'ZWE', 'ZW', '짐바브웨')
INSERT INTO country VALUES ('148', 'TCD', 'TD', '차드')
INSERT INTO country VALUES ('203', 'CZE', 'CZ', '체코')
INSERT INTO country VALUES ('152', 'CHL', 'CL', '칠레')
INSERT INTO country VALUES ('120', 'CMR', 'CM', '카메룬')
INSERT INTO country VALUES ('132', 'CPV', 'CV', '카보베르데')
INSERT INTO country VALUES ('398', 'KAZ', 'KZ', '카자흐스탄')
INSERT INTO country VALUES ('634', 'QAT', 'QA', '카타르')
INSERT INTO country VALUES ('116', 'KHM', 'KH', '캄보디아')
INSERT INTO country VALUES ('124', 'CAN', 'CA', '캐나다')
INSERT INTO country VALUES ('404', 'KEN', 'KE', '케냐')
INSERT INTO country VALUES ('136', 'CYM', 'KY', '케이맨 제도')
INSERT INTO country VALUES ('174', 'COM', 'KM', '코모로')
INSERT INTO country VALUES ('188', 'CRI', 'CR', '코스타리카')
INSERT INTO country VALUES ('166', 'CCK', 'CC', '코코스 제도')
INSERT INTO country VALUES ('384', 'CIV', 'CI', '코트디부아르')
INSERT INTO country VALUES ('170', 'COL', 'CO', '콜롬비아')
INSERT INTO country VALUES ('178', 'COG', 'CG', '콩고 공화국')
INSERT INTO country VALUES ('180', 'COD', 'CD', '콩고 민주 공화국')
INSERT INTO country VALUES ('192', 'CUB', 'CU', '쿠바')
INSERT INTO country VALUES ('414', 'KWT', 'KW', '쿠웨이트')
INSERT INTO country VALUES ('184', 'COK', 'CK', '쿡 제도')
INSERT INTO country VALUES ('191', 'HRV', 'HR', '크로아티아')
INSERT INTO country VALUES ('162', 'CXR', 'CX', '크리스마스 섬')
INSERT INTO country VALUES ('417', 'KGZ', 'KG', '키르기스스탄')
INSERT INTO country VALUES ('296', 'KIR', 'KI', '키리바시')
INSERT INTO country VALUES ('196', 'CYP', 'CY', '키프로스')
INSERT INTO country VALUES ('764', 'THA', 'TH', '타이')
INSERT INTO country VALUES ('762', 'TJK', 'TJ', '타지키스탄')
INSERT INTO country VALUES ('834', 'TZA', 'TZ', '탄자니아')
INSERT INTO country VALUES ('796', 'TCA', 'TC', '터크스 케이커스 제도')
INSERT INTO country VALUES ('792', 'TUR', 'TR', '터키')
INSERT INTO country VALUES ('768', 'TGO', 'TG', '토고')
INSERT INTO country VALUES ('772', 'TKL', 'TK', '토켈라우')
INSERT INTO country VALUES ('776', 'TON', 'TO', '통가')
INSERT INTO country VALUES ('795', 'TKM', 'TM', '투르크메니스탄')
INSERT INTO country VALUES ('798', 'TUV', 'TV', '투발루')
INSERT INTO country VALUES ('788', 'TUN', 'TN', '튀니지')
INSERT INTO country VALUES ('780', 'TTO', 'TT', '트리니다드 토바고')
INSERT INTO country VALUES ('591', 'PAN', 'PA', '파나마')
INSERT INTO country VALUES ('600', 'PRY', 'PY', '파라과이')
INSERT INTO country VALUES ('586', 'PAK', 'PK', '파키스탄')
INSERT INTO country VALUES ('598', 'PNG', 'PG', '파푸아 뉴기니')
INSERT INTO country VALUES ('585', 'PLW', 'PW', '팔라우')
INSERT INTO country VALUES ('275', 'PSE', 'PS', '팔레스타인')
INSERT INTO country VALUES ('234', 'FRO', 'FO', '페로 제도')
INSERT INTO country VALUES ('604', 'PER', 'PE', '페루')
INSERT INTO country VALUES ('620', 'PRT', 'PT', '포르투갈')
INSERT INTO country VALUES ('238', 'FLK', 'FK', '포클랜드 제도')
INSERT INTO country VALUES ('616', 'POL', 'PL', '폴란드')
INSERT INTO country VALUES ('630', 'PRI', 'PR', '푸에르토리코')
INSERT INTO country VALUES ('250', 'FRA', 'FR', '프랑스')
INSERT INTO country VALUES ('254', 'GUF', 'GF', '프랑스령 기아나')
INSERT INTO country VALUES ('260', 'ATF', 'TF', '프랑스령 남부와 남극 지역')
INSERT INTO country VALUES ('258', 'PYF', 'PF', '프랑스령 폴리네시아')
INSERT INTO country VALUES ('242', 'FJI', 'FJ', '피지')
INSERT INTO country VALUES ('246', 'FIN', 'FI', '핀란드')
INSERT INTO country VALUES ('608', 'PHL', 'PH', '필리핀')
INSERT INTO country VALUES ('612', 'PCN', 'PN', '핏케언 제도')
INSERT INTO country VALUES ('334', 'HMD', 'HM', '허드 맥도널드 제도')
INSERT INTO country VALUES ('348', 'HUN', 'HU', '헝가리')
INSERT INTO country VALUES ('344', 'HKG', 'HK', '홍콩')

