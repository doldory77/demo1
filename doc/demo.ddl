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

