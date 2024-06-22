SELECT * FROM EMPLOYEES;

--테이블 생성
CREATE TABLE TBL_MEMBER(
	MEMBER_NAME VARCHAR2(1000),
	MEMBER_AGE NUMBER
);

--컬럼 이름을 직접 명시한 INSERT
--내가 원하는 컬럼에 값만 넣을 수 있다
--순서 중요!
INSERT INTO TBL_MEMBER(MEMBER_NAME, MEMBER_AGE)
VALUES ('유가람', 25);

INSERT INTO TBL_MEMBER (MEMBER_NAME) 
VALUES ('홍길동');

--모든 컬럼에 값을 넣고 싶을 때
--순서대로가 중요!
INSERT INTO TBL_MEMBER
VALUES ('김철수', 15);

SELECT *
FROM TBL_MEMBER;

--==========================================================

--UPDATE
--이 상태로 실행하면, 모든 행의 해당 열을 전부 수정
UPDATE TBL_MEMBER 
SET MEMBER_AGE  = 30;

--WHERE을 사용해서 원하는 행에 컬럼만 수정 가능
UPDATE TBL_MEMBER 
SET MEMBER_AGE = 25			--대입 연산자
WHERE MEMBER_NAME = '유가람'; -- 비교연산자

--==========================================================

--DELETE
--모든 행을 삭제
DELETE FROM TBL_MEMBER;

DELETE 
FROM TBL_MEMBER
WHERE MEMBER_AGE = 30;

--==========================================================

CREATE TABLE TBL_STUDENT(
	STUDENT_NUMBER NUMBER,
	STUDENT_NAME VARCHAR2(1000),
	STUDENT_MATH NUMBER,
	STUDENT_ENG NUMBER,
	STUDENT_KOR NUMBER,
	STUDENT_GRADE VARCHAR2(1000)
);

SELECT *
FROM TBL_STUDENT;

/*
[실습]
학생 테이블에 데이터를 추가한다.
학생번호, 이름, 수학, 영어, 국어
1, '김철수', 90, 90, 90
2, '홍길동', 70, 25, 55
3, '이유리', 89, 91, 77
4, '김웅이', 48, 100, 92
5, '신짱구', 22, 13, 9
*/
INSERT INTO TBL_STUDENT(STUDENT_NUMBER , STUDENT_NAME, STUDENT_MATH, STUDENT_ENG, STUDENT_KOR)
VALUES (5, '신짱구', 22, 13, 9);

--전체 학생들의 이름과 평균점수를 조회하기(별칭도 넣기)
SELECT STUDENT_NAME ,(STUDENT_MATH+STUDENT_ENG+STUDENT_KOR)/3 평균
FROM TBL_STUDENT;

--소수점 자르기
--ROUND(값, 자릿수)
SELECT STUDENT_NAME ,ROUND((STUDENT_MATH+STUDENT_ENG+STUDENT_KOR)/3, 2) 평균
FROM TBL_STUDENT;


/*
[실습]
학생의 평균점수를 구하고 학점을 수정하기
A : 90점 이상
B : 80점 이상 90점 미만
C : 50점 이상 80점 미만
D : 50점 미만
*/
UPDATE TBL_STUDENT
SET STUDENT_GRADE = 'D'	
WHERE (STUDENT_MATH+STUDENT_ENG+STUDENT_KOR)/3 < 50; 

/*
[실습]
학점이 잘 들어갔는지 확인하기 위해서
학생 번호, 이름, 평균, 학점 조회하기 (별칭 넣기)
*/
SELECT STUDENT_NUMBER 번호, STUDENT_NAME 이름, ROUND((STUDENT_MATH+STUDENT_ENG+STUDENT_KOR)/3, 2) 평균, STUDENT_GRADE 학점
FROM TBL_STUDENT;

--학생의 수학, 영어, 국어 점수 중 한 과목이라도 50점 미만이 아니고
--학점이 B이상인 학생만 학생 번호, 이름, 학점 출력하기
SELECT STUDENT_NUMBER , STUDENT_NAME , STUDENT_GRADE 
FROM TBL_STUDENT
WHERE NOT (STUDENT_MATH < 50 OR STUDENT_ENG < 50 OR STUDENT_KOR < 50) AND (STUDENT_GRADE = 'B' OR STUDENT_GRADE = 'A');
-- AND 가 OR 보다 우선 순위가 높다.
-- 그렇기 때문에 제일 뒤에 학점 OR 는 최우선 연산으로 묶어줘야
-- 원하는 값을 얻을 수 있다.


DELETE 
FROM TBL_STUDENT
WHERE STUDENT_MATH < 30 OR STUDENT_ENG < 30 OR STUDENT_KOR < 30;

SELECT *
FROM TBL_STUDENT;








