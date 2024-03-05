-- 함수 : 컬럼값 | 지정된 값을 읽어 연산한 결과를 반환하는 것

-- 단일행 함수 : N개의 행의 컬럼 값을 전달하여 N개의 결과가 반환
--           ( 그룹의 수가 늘어나면 그룹의 수 만큼 결과를 반환)

-- 함수는 SELECT 절, WHERE 절, ORDER BY 절
--         GROUP BY 절, HAVING 절에서 사용 가능


/********************* 단일행 함수 *********************/

-- < 문자열 관련 함수 >

-- LENGTH(문자열|컬럼명): 문자열의 길이 반환
 SELECT 'HELLO WORLD', LENGTH( 'HELLO WORLD' ) FROM DUAL; --11
 
 -- EMPLOYEE 테이블에서 
 -- 사원명, 이메일, 이메일 길이 조회
 -- 단, 이메일 길이가 12 이하인 행만 
 -- 이메일 길이 오름차순 조회
 SELECT EMP_NAME, EMAIL, LENGTH ( EMAIL ) "이메일 길이"
 FROM EMPLOYEE 
 WHERE LENGTH ( EMAIL )<=12 -- 별칭이나 위치 번호 사용 불가 ( 2번째로 해석됨)
 ORDER BY 3;
 
---------------------------------------------------------------------------------

-- INSTR (문자열 | 컬럼명, '찾을 문자열' [, 찾을 시작 위치 [, 순번]])
-- 찾을 시작 위치부터 지정된 순번째 찾은 문자열의 시작 위치를 반환

-- 문자열에서 맨 앞에 있는 'B'의 위치를 조회
SELECT 'AABAACAABBAA', INSTR('AABAACAABBAA', 'B')
FROM DUAL; --3 (INDEX X, 몇 번째에 위치해 있는가 O)

-- 문자열에서 5번 부터 검색 시작해서 처음 찾은 'B'의 위치 조회
SELECT 'AABAACAABBAA', INSTR('AABAACAABBAA', 'B', 5) 
FROM DUAL; --9

-- 문자열에서 5번 부터 검색 시작해서 2번째로 찾은 'B'의 위치 조회
SELECT 'AABAACAABBAA', INSTR('AABAACAABBAA', 'B', 5, 2) --5번 부터 찾은 2번째 B
FROM DUAL; --10

--------------------------------------------------------------------------------------------------------

-- SUBSTR (문자열 | 컬럼명, 시작 위치 [, 길이])

-- 문자열을 시작 위치부터 지정된 길이 만큼 잘라내서 반환
-- 길이 미작성 시 시작 위치 부터 끝까지 잘라내서 반환

-- 문자열을 뺴서 잘라내기

-- 시작 위치, 자를 길이 지정
SELECT SUBSTR('ABCDEFG', 2,3) -- BCD
FROM DUAL;

-- 시작 위치, 자를 길이 미지정
SELECT SUBSTR('ABCDEFG', 4) --DEFG
FROM DUAL;

-- EMPLOYEE 테이블에서
-- 사원명, 이메일 아이디 (@ 앞에까지 문자열)을
-- 이메일 아이디 오름차순으로 조회
SELECT EMP_NAME, SUBSTR( EMAIL, 1, INSTR (EMAIL, '@')-1 ) "이메일 아이디"
FROM EMPLOYEE 
ORDER BY EMAIL;


--------------------------------------------------------------------------

-- TRIM([ [옵션] 문자열 | 컬럼명 FROM ] 문자열 | 컬럼명)
-- 주어진 문자열의 앞쪽|뒤쪽|양쪽에 존재하는 지정된 문자열을 제거

-- 옵션 : LEADING (앞쪽), TRAILING (뒤쪽), BOTH(양쪽, 기본값)

-- 문자열 공백 제거
SELECT '  기 준  ',
TRIM(LEADING ' ' FROM '  기 준  '), -- 앞쪽 공백 제거
TRIM(TRAILING ' ' FROM '  기 준  '), -- 뒤쪽 공백 제거
TRIM(BOTH ' ' FROM '  기 준  ') -- 양쪽 공백 제거
FROM DUAL;

-- 특정 문자열 제거
SELECT '###기 준###',
TRIM(LEADING '#' FROM '###기 준###'),
TRIM(TRAILING '#' FROM '###기 준###'),
TRIM(BOTH '#' FROM '###기 준###')
FROM DUAL;

---------------------------------------------------------------------------------

-- REPLACE (문자열 | 컬럼명, 찾을 문자열, 바꿀 문자열)

SELECT*FROM NATIONAL;

SELECT NATIONAL_CODE, REPLACE(NATIONAL_NAME, '한국', '대한민국')
FROM "NATIONAL";

-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------

-- < 숫자 관련 함수 >

-- MOD ( 숫자 | 컬럼명, 나눌 값 ) : 나머지
SELECT MOD(105, 100) FROM DUAL; --5

-- ABS ( 숫자 | 컬럼명 ) : 절대 값
SELECT ABS(10), ABS(-10) FROM DUAL; --10, 10

-- CEIL ( 숫자 | 컬럼명 ) : 올림
-- FLOOR ( 숫자 | 컬럼명 ) : 내림
SELECT CEIL(1.1), FLOOR(1.1) FROM DUAL; -- 2, 1


-- ROUND ( 숫자 | 컬럼명 [, 소수점 위치 ]) : 반올림
-- 소수점 위치 지정 X : 소수점 첫째 자리에서 반올림 -> 정수 표현
-- 소수점 위치 지정 O
--1) 양수 : 지정된 위치의 소수점 자리까지 표현
--2) 음수 : 지정된 위치의 정수 자리까지 표현

SELECT 123.456,
ROUND(123.456), --123
ROUND(123.456, 1), --123.5
ROUND(123.456, 2),--123.46
ROUND(123.456, -1), --120
ROUND(123.456, -2) --100
FROM DUAL;

-- TRUNC ( 숫자 | 컬럼명 [, 소수점 위치]) : 버림 (잘라내기)
SELECT  -123.5,
TRUNC( -123.5), 123( 소수점 벌림)

SELECT -123.5,
TRUNC (-123.5), -- -123(소수점 .5 버림)
 FLOOR (-123.5) -- 124( 내림 )
FROM DUAL;

---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------

--< 날짜 관련 함수 >
-- SYSDATE : 현재 시간
-- SYSTIMESTAMP : 현재 시간 (ms 포함, 표준시간대)
SELECT SYSDATE, SYSTIMESTAMP FROM DUAL;

-- MONTHS_BETWEEN ( 날짜, 날짜 ) : 두 날짜 사이의 개월 수를 반환
--> 반환 값 중 정수 부분은 차이나는 개월 수를 의미 ( 1이 한달 차이 )
SELECT MONTHS_BETWEEN( '2024-03-28', SYSDATE) FROM DUAL; 
--                           (자료형)  문자열 char ,    DATE

-- ** ORACLE 은 자료형이 맞지 않는 상황이라도
--    작성된 값의 형태가 요구하는 자료형의 형태를 띄고 있으면
--    자동으로 형변환 ( PARSING ) 을 진행한다 !!

-- ex) '2024-03-28' -> TO_DATE('2024-03-28', 'YYYY-MM-DD') 가 자동으로 실행됨


-- EMPLOYEE 테이블에서
-- 모든 사원의 사번, 이름, 입사일, N년차 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE, 
CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12)|| '년차' "N년차"
FROM EMPLOYEE;

-- MONTHS_BETWEEN( )은 윤년(2월 29일이 포함된 해) 계산이 자동으로 수행
--> YEAR, MONTH 단위 계산 시 더 정확한 값을 얻어낼 수 있다!

--------------------------------------------------------------------------------------------------

-- ADD_MONTHS(날짜, 숫자) : 날짜를 숫자만큼의 개월 수를 더하여 반환

SELECT SYSDATE, --3/03
SYSDATE + 31,   -- 4/03
SYSDATE + 31 + 30, -- 5/03

ADD_MONTHS(SYSDATE, 1), 
ADD_MONTHS(SYSDATE, 2) 
FROM DUAL;



-- LAST_DAY(날짜) : 해당 월의 마지막 날짜를 반환
SELECT LAST_DAY(SYSDATE) --  숫자가 아닌 날짜를 넣어야 함
FROM DUAL;

-- 다음 달 마지막 날짜
SELECT LAST_DAY( ADD_MONTHS(SYSDATE, 1)) FROM DUAL;

-- 다음 달 첫 번째, 마지막 날짜
SELECT LAST_DAY(SYSDATE)+1, LAST_DAY(ADD_MONTHS(SYSDATE, 1)) FROM DUAL;


-- EXTRACT(YEAR | MONTH | DAY  FROM  날짜)
-- (EXTRACT : 뽑아내다, 추출하다)
-- 지정된 날짜의 년 | 월 | 일을 추출하여 정수로 반환

SELECT EXTRACT ( YEAR FROM SYSDATE ) 년,
           EXTRACT ( MONTH FROM SYSDATE ) 월,
           EXTRACT ( DAY FROM SYSDATE ) 일
FROM DUAL;

-- EMPLOYEE 테이블에서 2000년대에 입사한 사원의
-- 사번, 이름, 입사일을 이름 오름차순으로 조회

SELECT EMP_ID, EMP_NAME , HIRE_DATE 
FROM EMPLOYEE
WHERE EXTRACT ( YEAR FROM HIRE_DATE ) >=2000
ORDER BY EMP_NAME;

-----------------------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------


-- < 형변환 ( PARSING ) 함수 >

-- 문자열 (CHAR, VARCHAR2) <-> 숫자(NUMBER)
-- 문자열 (CHAR, VARCHAR2) <-> 날짜(DATE)
-- 숫자(NUMBER) --> 날짜(DATE)
-- 날짜는 숫자가 될 수 없음



/* TO_CHAR ( 날짜 | 숫자 [, 포맷]) : 문자열로 변환
 * 
 * 숫자 -> 문자열
 * 포맷
 * 1) 9 : 숫자 한 칸을 의미, 오른쪽 정렬
 * 2) 0 : 숫자 한 칸을 의미, 오른쪽 정렬, 빈 칸에 0을 추가 
 * 3) L : 현재 시스템이나 DB에 설정된 나라의 화폐 기호
 * 4) , : 숫자의 자릿수 구분
 * */

SELECT 1234, TO_CHAR(1234) FROM DUAL; -- 데이터 타입이 숫자에서 문자로 바뀜

SELECT 1234, TO_CHAR(1234,'99999999') FROM DUAL;
-- 앞의 공백이 4칸인 오른쪽 정렬 1234

SELECT 1234, TO_CHAR(1234, '00000000' ) FROM DUAL;
-- 앞의 4칸이 0인 오른쪽 정렬 00001234

/* 숫자 -> 문자열 변환 시 문제 상황 */
--> 포맷에 지정된 칸 수가 숫자 길이보다 적으면 전부 #으로 변환되서 출력
SELECT 1234, TO_CHAR(1234,'000') FROM DUAL; -- ####

-- 화폐 기호 + 자릿수 구분
SELECT TO_CHAR (123456789, 'L999999999'), 
-- \123456789 나라에 맞춰서 자동으로 화폐 기호를 지정해줌
    TO_CHAR (123456789, '$999999999'),
    TO_CHAR (123456789, '$999,999,999')
FROM DUAL; 

SELECT EMP_NAME, TO_CHAR ( SALARY*12, 'L999,999,999')연봉
FROM EMPLOYEE;


----------------------

/* 날짜  -> 문자열
 * 
 * YY : 년도 (짧게) EX) 23
 * YYYY : 년도 (길게) EX) 2023
 * 
 * RR : 년도 (짧게) EX)23
 * RRRR : 년도 (길게) EX) 2023
 * 
 * MM : 월
 * DD : 일
 * 
 * AM/PM : 오전/ 오후
 *
 * HH : 시간 (12시간)
 * HH24 : 시간 (24시간)
 * MI : 분
 * SS : 초
 * 
 * DAY : 요일(전체), EX) 월요일, MONDY
 * DY : 요일(짧게) EX) 월, MON
 * */


-- 현재 날짜 -> '2024-02-27'
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD') -- 날짜가 지정한 형태의 문자열로 바뀜
FROM DUAL;

-- 현재 날짜 -> '2024-02-27 화요일'
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') -- 화요일이 뒤에 붙음
FROM DUAL;

-- 현재 날짜 -> '2024/02/27 (화) 오후 12 : 11: 20'
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YY/MM/DD (DY) PM HH:MI:SS')
FROM DUAL;

-- /, ( ), : , - 는 일반적으로 날짜 표기시 사용하는 기호
--> 패턴으로 인식되어 오류가 발생하지 않음!

-- 년, 월, 일 같은 한글 또는 날짜와 관련 없는 문자는 패턴 X
--> 이러한 관련 없는 문자들을 " " 감싸면 사용 가능!!!
-- ( " " 의미 : 있는 그대로 인식 )

-- 현재 날짜 -> 2024년 02월 27일 오후 12시 15분 30초
SELECT TO_CHAR (SYSDATE, 'YYYY"년" MM"월" DD"일" PM HH"시" MI"분" SS"초"')
FROM DUAL;

------------------------------------------------------------------------------

-- TO_DATE( 문자열 | 숫자 [, 포맷] )

-- 문자열 또는 숫자를 날짜 형식으로 변환
SELECT TO_DATE('2024-03-04')
-- 문자열이 날짜를 표현하는 형식이면 포맷 지정없이 바로 변경 가능
FROM DUAL;

SELECT TO_DATE('04-03-2024', 'DD-MM-YYYY')
FROM DUAL; -- 2024-03-04 00:00:00.000

SELECT TO_DATE('02월 27일 화요일 12시 24분',
                 'MM"월" DD"일" DAY HH"시" MI"분"')
FROM DUAL; -- 2024-02-27 12:24:00.000









