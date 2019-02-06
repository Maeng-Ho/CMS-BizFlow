DROP TABLE  ERLR_EMPLOYEE_CASE;
/

CREATE TABLE ERLR_EMPLOYEE_CASE
(
	"CASEID" NUMBER(10,0), 
	"HHSID" VARCHAR2(64 BYTE), 
	"FROM_CASEID" NUMBER(10,0), 
	"CASE_TYPE_ID" NUMBER(10,0),
	"CASE_TYPE_NAME" VARCHAR2(100 BYTE), 
	"EMP_FIRST_NAME" VARCHAR2(100 BYTE), 
	"EMP_LAST_NAME" VARCHAR2(100 BYTE), 
	"M_DT" DATE, 
	"M_MEMBER_ID" VARCHAR2(10 BYTE), 
	"M_MEMBER_NAME" NVARCHAR2(100) 
);

CREATE OR REPLACE FORCE VIEW VW_ERLR_EMPLOYEE_CASE AS 
  SELECT * 
    FROM ERLR_EMPLOYEE_CASE     
  ORDER BY CASEID;
/
