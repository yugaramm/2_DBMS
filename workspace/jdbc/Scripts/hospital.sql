-- MEMBERVO
CREATE TABLE TBL_OWNER(
	OWNER_NUMBER NUMBER,
	OWNER_NAME VARCHAR2(100) NOT NULL,
	OWNER_PHONE VARCHAR2(100) NOT NULL,
	CONSTRAINT PK_OWNER PRIMARY KEY(OWNER_NUMBER)
);

-- PHONE 에 제약조건 추가
ALTER TABLE TBL_OWNER ADD CONSTRAINT UK_OWNER UNIQUE(OWNER_PHONE);

-- ANIMALVO
CREATE TABLE TBL_ANIMAL(
	ANIMAL_NUMBER NUMBER,
	ANIMAL_NAME VARCHAR2(100) NOT NULL,
	ANIMAL_SPECIES VARCHAR2(100),
	OWNER_NUMBER NUMBER,
	CONSTRAINT PK_ANIMAL PRIMARY KEY(ANIMAL_NUMBER),
	CONSTRAINT FK_ANIMAL FOREIGN KEY(OWNER_NUMBER)
	REFERENCES TBL_OWNER(OWNER_NUMBER)
);

CREATE TABLE TBL_CLINIC(
	CLINIC_NUMBER NUMBER,
	ANIMAL_NUMBER NUMBER,
	CLINIC_DISEASE VARCHAR2(100),
	CLINIC_TIME DATE NOT NULL, 
	CONSTRAINT PK_CLINIC PRIMARY KEY(CLINIC_NUMBER),
	CONSTRAINT FK_CLINIC FOREIGN KEY(ANIMAL_NUMBER)
	REFERENCES TBL_ANIMAL(ANIMAL_NUMBER)
);

SELECT SEQ_PRO.NEXTVAL
FROM dual;

SELECT OWNER_NUMBER  FROM TBL_OWNER
WHERE OWNER_NAME = '유가람' AND OWNER_PHONE = '010-1111-1111';

SELECT * FROM TBL_OWNER;
SELECT * FROM TBL_ANIMAL;

INSERT INTO TBL_OWNER
(OWNER_NUMBER, OWNER_NAME, OWNER_PHONE)
VALUES(SEQ_PRO.NEXTVAL, '관리자', '0000');

SELECT OWNER_NAME , T2.ANIMAL_NAME, ANIMAL_SPECIES, CLINIC_DISEASE, CLINIC_TIME FROM
TBL_OWNER T1 JOIN
	(SELECT ANIMAL_NAME , ANIMAL_SPECIES , CLINIC_DISEASE , OWNER_NUMBER , CLINIC_TIME
	FROM TBL_ANIMAL A JOIN TBL_CLINIC B
	ON A.ANIMAL_NUMBER = B.ANIMAL_NUMBER
	WHERE TO_CHAR(CLINIC_TIME, 'YYYYMMDD') = TO_CHAR(SYSDATE, 'YYYYMMDD')) T2
ON T1.OWNER_NUMBER = T2.OWNER_NUMBER;


