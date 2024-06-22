/*SCALAR*/
--SELECT절에 서브쿼리 추가하기

-- PLAYER 테이블에서 전체 평균 키와 포지션별 평균 키 구하기
SELECT AVG(HEIGHT) 
FROM PLAYER;

SELECT "POSITION" , AVG(HEIGHT) 
FROM PLAYER
GROUP BY "POSITION";

--메인 쿼리 안에 서브 쿼리를 삽입하므로 우리가 원하는 데이터를 한 번에 조회하려고 한다.

SELECT "POSITION" , AVG(HEIGHT) "포지션별 평균 키" , 
	(SELECT AVG(HEIGHT) FROM PLAYER) "전체 평균 키"
FROM PLAYER
WHERE "POSITION" IS NOT NULL
GROUP BY "POSITION";

--====================================================================================

/*IN LINE VIEW*/
--FROM절에 서브쿼리 추가하기

-- PLAYER테이블에서 TEAM_ID가 'K01'인 선수 중
-- POSITION이 'GK'인 선수를 조회하기

-- 서브쿼리 사용하지 않고 풀어보기
SELECT * FROM PLAYER
WHERE TEAM_ID = 'K01' AND "POSITION" = 'GK';

-- 가상의 테이블
SELECT * FROM PLAYER
WHERE TEAM_ID = 'K01';

SELECT * FROM PLAYER
WHERE "POSITION" = 'GK';

-- 서브 쿼리 사용
SELECT * 
FROM
	(SELECT * FROM PLAYER
	WHERE TEAM_ID = 'K01')
WHERE "POSITION" = 'GK';
-- 서브쿼리를 안쓰는게 더 빠르지만, 써야만 하는 상황이 많다.
-- 그러므로 서브쿼리를 쓰기전에 안써도 해결되는지 먼저 생각하고 사용한다.

/*SUB QUERY*/
-- WHERE절에 추가하는 서브쿼리

--PLAYER 테이블에서 평균 몸무게보다 무게가 더 많이 나가는 선수들 검색
SELECT * FROM PLAYER
WHERE WEIGHT > AVG(WEIGHT); -- WHERE절에서 집계함수는 사용 불가능

SELECT * FROM PLAYER
WHERE WEIGHT > (
	SELECT AVG(WEIGHT)
	FROM PLAYER
);

--================================================================================

-- PLAYER 테이블에서 정남일 선수가 소속된 팀의 선수들 조회
SELECT TEAM_ID 
FROM PLAYER
WHERE PLAYER_NAME = '정남일';

SELECT *
FROM PLAYER
WHERE TEAM_ID  = (
   SELECT TEAM_ID 
   FROM PLAYER
   WHERE PLAYER_NAME = '정남일'
);

-- 특정(단일) 행을 조회할 때, 되도록이면 PK를 이용해서 조회하도록 하자.
SELECT *
FROM PLAYER
WHERE TEAM_ID  = (
   SELECT TEAM_ID 
   FROM PLAYER
   WHERE PLAYER_ID = (
      SELECT PLAYER_ID 
      FROM PLAYER
      WHERE PLAYER_NAME = '정남일'
   )
);


-- PLAYER 테이블에서 평균 키보다 작은 선수 조회
SELECT PLAYER_ID, PLAYER_NAME, HEIGHT, (SELECT AVG(HEIGHT) FROM PLAYER) 
FROM PLAYER
WHERE HEIGHT < (
   SELECT AVG(HEIGHT) 
   FROM PLAYER
)
ORDER BY HEIGHT DESC;

SELECT MAX(HEIGHT) 
FROM PLAYER
WHERE HEIGHT < (
   SELECT AVG(HEIGHT) 
   FROM PLAYER
);

-- SCHEDULE 테이블에서 경기 일정이 
-- 20120501 ~ 20120505 사이에 있는 경기장 전체 정보 조회
SELECT * FROM SCHEDULE;
SELECT * FROM STADIUM;

-- 문자 비교 가능!
SELECT *
FROM SCHEDULE
WHERE SCHE_DATE >= '20120501';

SELECT STADIUM_ID 
FROM SCHEDULE
WHERE SCHE_DATE BETWEEN '20120501' AND '20120505';

SELECT *
FROM STADIUM
WHERE STADIUM_ID IN (
   SELECT STADIUM_ID 
   FROM SCHEDULE
   WHERE SCHE_DATE BETWEEN '20120501' AND '20120505'
);

--================================================================================

-- 매뉴얼 커밋으로 바꾸고 진행!
-- 모든 실습이 다 끝나고 나서! 롤백 반드시 하기!
-- 커밋만 누르지말자!

-- PLAYER 테이블에서 NICKNAME이 NULL인 선수들을
-- 정태민 선수의 닉네임으로 바꾸기
SELECT NICKNAME 
FROM PLAYER
WHERE PLAYER_NAME = '정태민';

UPDATE PLAYER  
SET NICKNAME = (
   SELECT NICKNAME 
   FROM PLAYER
   WHERE PLAYER_NAME = '정태민'
)
WHERE NICKNAME IS NULL;

-- 424
SELECT * FROM PLAYER p 
WHERE NICKNAME IS NULL;

-- 425 <-- 정태민 선수 포함!
SELECT COUNT(NICKNAME) FROM PLAYER p 
WHERE NICKNAME = '킹카';  

-- PLAYER 테이블에서 평균 키보다 큰 선수들을 삭제

-- 평균 키보다 큰 사람은 219명
SELECT HEIGHT FROM PLAYER
WHERE HEIGHT > (
   SELECT AVG(HEIGHT) 
   FROM PLAYER
);

-- 실행할 때 UPDATED ROWS 219인 것을 확인!
DELETE FROM PLAYER
WHERE HEIGHT > (
   SELECT AVG(HEIGHT) 
   FROM PLAYER
);

--롤백 하세요!
--AUTO COMMIT 으로 다시 변경

--=================================================================================

--직원 테이블에서 부서_ID가 100인 직원들의
--풀네임과 직위와(JOB_ID) 부서_ID와 연봉을 조회하고,
--전체 직원의 평균 연봉과 자신의 연봉의 차를 구해보자

SELECT FIRST_NAME || ' ' ||LAST_NAME , JOB_ID , DEPARTMENT_ID , SALARY , (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEES) - SALARY "평균연봉과의 차"
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 100; 

SELECT AVG(SALARY)  FROM EMPLOYEES;

SELECT * FROM EMPLOYEES

--=================================================================================

--ROWNUM
-- E 는 테이블의 알리아스(AS)
-- * 를 다른 컬럼과 같이 사용하게 되면, 소속을 명시해줘야한다.
SELECT ROWNUM, E.* FROM EMPLOYEES E;

-- EMPLOYEES 테이블에서 SALARY를 내림차순으로 정렬한 후
-- ROWNUM을 붙여보자

-- ORDER BY 보다 SELECT가 먼저 실행
-- ROWNUM이 부여된 이후에 정렬이 들어가기 때문에 우리가 원하는대로 나오지 않는다.
SELECT ROWNUM, E.*
FROM EMPLOYEES E
ORDER BY SALARY DESC;

SELECT ROWNUM, E.*
FROM (
	SELECT *
	FROM EMPLOYEES
	ORDER BY SALARY DESC
)E;

-- 1등 부터 5등까지 조회해보자
-- ROWNUM은 예외적으로, WHERE에서 사용 가능!
SELECT ROWNUM, E.*
FROM (
	SELECT *
	FROM EMPLOYEES
	ORDER BY SALARY DESC
)E
WHERE ROWNUM BETWEEN 1 AND 5;