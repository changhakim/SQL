-- SQL_TEST_001
-- 전체 축구팀 목록. 이름 오름차순
SELECT TEAM_NAME
FROM TEAM
ORDER BY TEAM_NAME;
-- SQL_TEST_002
-- 포지션 종류(중복제거,없으면 빈공간
SELECT DISTINCT POSITION
FROM PLAYER;


-- SQL_TEST_003
-- 포지션 종류(중복제거,없으면 신입으로 기재)
-- nvl2()사용
SELECT DISTINCT NVL2(POSITION,POSITION,'신입') POSITION
FROM PLAYER;
-- SQL_TEST_004
-- 수원팀(ID: K02)골키퍼
SELECT PLAYER_NAME
FROM PLAYER
WHERE PLAYER_NAME IN (SELECT PLAYER_NAME
        FROM PLAYER
        WHERE TEAM_ID LIKE 'K02' AND POSITION LIKE 'GK');


-- SQL_TEST_005
-- 수원팀(ID: K02)키가 170 이상 선수
-- 이면서 성이 고씨인 선수
SELECT POSITION,PLAYER_NAME
FROM PLAYER       
WHERE PLAYER_NAME IN (SELECT PLAYER_NAME
                 FROM PLAYER
                 WHERE HEIGHT >=170 AND PLAYER_NAME LIKE '고%' AND TEAM_ID LIKE 'K02');
                 
                 
-- SQL_TEST_006
-- 수원팀(ID: K02) 선수들 이름,
-- 키와 몸무게 리스트 (단위 cm 와 kg 삽입)
-- 키와 몸무게가 없으면 "0" 표시
-- 키 내림차순
SELECT PLAYER_NAME||'선수',NVL2(HEIGHT,HEIGHT,0)||'cm' 키,NVL2(WEIGHT,WEIGHT,0)||'kg' 몸무게
FROM PLAYER
WHERE TEAM_ID LIKE 'K02'
ORDER BY 키 DESC;


-- SQL_TEST_007
-- 수원팀(ID: K02) 선수들 이름,
-- 키와 몸무게 리스트 (단위 cm 와 kg 삽입)
-- 키와 몸무게가 없으면 "0" 표시
-- BMI지수 
-- 키 내림차순
SELECT PLAYER_NAME|| '선수' 선수명,NVL2(HEIGHT,HEIGHT,0)||'cm' 키,NVL2(WEIGHT,WEIGHT,0)||'kg' 몸무게,ROUND(((WEIGHT/(HEIGHT*HEIGHT))*10000),2) BMI
FROM PLAYER
WHERE TEAM_ID LIKE 'K02'
ORDER BY 키 DESC;


-- SQL_TEST_008
-- 수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중 
--  포지션이 GK 인  선수
-- 팀명, 사람명 오름차순
SELECT T.TEAM_NAME,P.PLAYER_NAME
FROM (SELECT TEAM_NAME,TEAM_ID
      FROM TEAM
      WHERE TEAM_ID IN('K02','K10')) T
        JOIN PLAYER P ON T.TEAM_ID LIKE P.TEAM_ID
WHERE P.POSITION LIKE 'GK'        
ORDER BY T.TEAM_NAME,P.PLAYER_NAME
;

-- SQL_TEST_009
-- 수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중 이
-- 키가 180 이상 183 이하인 선수들
-- 키, 팀명, 사람명 오름차순
SELECT P.HEIGHT 키,T.TEAM_NAME 팀명,P.PLAYER_NAME 선수명
FROM PLAYER P
JOIN TEAM T ON T.TEAM_ID LIKE P.TEAM_ID
WHERE P.HEIGHT IN (SELECT P.HEIGHT
                          FROM PLAYER P
                          WHERE P.HEIGHT BETWEEN 180 AND 183)
ORDER BY P.HEIGHT,T.TEAM_NAME,P.PLAYER_NAME ;


SELECT P.HEIGHT,T.TEAM_NAME,P.PLAYER_NAME
FROM (SELECT TEAM_ID ,TEAM_NAME
      FROM TEAM
      WHERE TEAM_ID IN('K02','K10')) T
      JOIN PLAYER P ON T.TEAM_ID LIKE P.TEAM_ID
WHERE P.HEIGHT BETWEEN 180 AND 183
ORDER BY HEIGHT,PLAYER_NAME;
-- SOCCER_SQL_010
-- 모든 선수들 중
-- 포지션을 배정받지 못한 선수들의 팀과 이름
-- 팀명, 사람명 오름차순
SELECT TEAM_NAME,PLAYER_NAME
FROM (SELECT PLAYER_NAME,TEAM_ID
      FROM PLAYER
      WHERE POSITION IS NULL) P 
      JOIN TEAM T ON T.TEAM_ID LIKE P.TEAM_ID

ORDER BY TEAM_NAME,PLAYER_NAME;

-- SOCCER_SQL_011
-- 팀과 스타디움을 조인하여
-- 팀이름, 스타디움 이름 출력
SELECT TEAM_NAME,STADIUM_NAME
FROM TEAM T
JOIN STADIUM S ON S.STADIUM_ID LIKE T.STADIUM_ID
ORDER BY TEAM_NAME;
-- SOCCER_SQL_012
-- 팀과 스타디움, 스케줄을 조인하여
-- 2012년 3월 17일에 열린 각 경기의 
-- 팀이름, 스타디움, 어웨이팀 이름 출력
-- 다중테이블 join 을 찾아서 해결하시오
SELECT * FROM TEAM;
SELECT TEAM_NAME,STADIUM_NAME,(SELECT TEAM_NAME
                               FROM TEAM
                               WHERE TEAM_ID LIKE D.AWAYTEAM_ID) 어웨이팀,SCHE_DATE 날짜
FROM (SELECT SCHE_DATE,STADIUM_ID,AWAYTEAM_ID
      FROM SCHEDULE
      WHERE SCHE_DATE LIKE '20120317') D
      JOIN STADIUM S ON S.STADIUM_ID LIKE D.STADIUM_ID
      JOIN TEAM T ON T.STADIUM_ID LIKE S.STADIUM_ID
      ORDER BY TEAM_NAME;
      
-- SOCCER_SQL_013
-- 2012년 3월 17일 경기에 
-- 포항 스틸러스 소속 골키퍼(GK)
-- 선수, 포지션,팀명 (연고지포함), 
-- 스타디움, 경기날짜를 구하시오
-- 연고지와 팀이름은 간격을 띄우시오

SELECT PLAYER_NAME 선수,POSITION 포지션,CONCAT(T.REGION_NAME,T.TEAM_NAME) 팀이름,STADIUM_NAME,SCHE_DATE
FROM (SELECT STADIUM_ID,SCHE_DATE
      FROM SCHEDULE
      WHERE SCHE_DATE LIKE '20120317') D
     JOIN STADIUM S ON S.STADIUM_ID LIKE D.STADIUM_ID
     JOIN TEAM T ON S.STADIUM_ID LIKE T.STADIUM_ID
     JOIN PLAYER P ON P.TEAM_ID LIKE T.TEAM_ID 
     
    WHERE T.TEAM_NAME LIKE '스틸러스' AND POSITION LIKE 'GK';

-- SOCCER_SQL_014
-- 홈팀이 3점이상 차이로 승리한 경기의 
-- 경기장 이름, 경기 일정
-- 홈팀 이름과 원정팀 이름을
-- 구하시오

SELECT STADIUM_NAME 경기장,SCHE_DATE "경기 일정",(SELECT TEAM_NAME
                                                    FROM TEAM
                                                    WHERE D.HOMETEAM_ID LIKE TEAM_ID)홈팀,(SELECT TEAM_NAME
                                                    FROM TEAM
                                                    WHERE D.AWAYTEAM_ID LIKE TEAM_ID) 원정팀 
    FROM (SELECT HOMETEAM_ID,AWAYTEAM_ID,SCHE_DATE,STADIUM_ID
          FROM SCHEDULE
          WHERE HOME_SCORE - AWAY_SCORE LIKE 3) D
          JOIN STADIUM S ON S.STADIUM_ID LIKE D.STADIUM_ID
          JOIN TEAM T ON T.STADIUM_ID LIKE S.STADIUM_ID;
          
 -- SOCCER_SQL_015
-- STADIUM 에 등록된 운동장 중에서
-- 홈팀이 없는 경기장까지 전부 나오도록
-- 카운트 값은 20

          
-- SOCCER_SQL_016
-- 평균키가 인천 유나이티스팀의 평균키 보다 작은 팀의 
-- 팀ID, 팀명, 평균키 추출
SELECT TEAM_ID,TEAM_NAME,(SELECT AVG(HEIGHT)
                          FROM TEAM
                          )
FROM (SELECT TEAM_ID,AVG(HEIGHT)
      FROM PLAYER
      ) P
      JOIN TEAM T ON T.TEAM_ID LIKE P.TEAM_ID ;


SELECT * FROM TEAM;
          
          
          
        
    
      
      