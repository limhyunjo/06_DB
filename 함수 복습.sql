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









