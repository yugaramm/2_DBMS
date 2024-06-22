-- 자판기 프로그램
/*
커피 메뉴 VO, TABLE
메뉴 고유 번호
메뉴 이름
메뉴 가격
 */
CREATE TABLE TBL_MENU(
	MENU_NUMBER NUMBER PRIMARY KEY,
	MENU_NAME VARCHAR2(100),
	MENU_PRICE NUMBER
);
SELECT * FROM TBL_MENU;

INSERT INTO TBL_MENU
VALUES(3, '자몽허니블랙티', 6000);

SELECT MENU_NAME, MENU_PRICE FROM TBL_MENU;

UPDATE TBL_MENU
SET MENU_PRICE=0
WHERE MENU_NUMBER=0;

DELETE FROM HR.TBL_MENU
WHERE MENU_NUMBER=0;
