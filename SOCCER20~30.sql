-- SOCCER_SQL_021
-- 이현 선수 소속팀의 선수명단 출력
SELECT PLAYER_NAME 선수이름,POSITION 포지션,BACK_NO 백넘버
FROM (SELECT TEAM_ID,PLAYER_NAME,POSITION,BACK_NO
      FROM PLAYER
      WHERE TEAM_ID LIKE(SELECT TEAM_ID
                         FROM PLAYER
                         WHERE PLAYER_NAME LIKE '이현')
      ORDER BY PLAYER_NAME);
                         
SELECT PLAYER_NAME
FROM PLAYER
WHERE TEAM_ID LIKE 'K04';

-- SOCCER_SQL_022
-- NULL 처리에 있어
-- SUM(NVL(SAL,0)) 로 하지말고
-- NVL(SUM(SAL),0) 으로 해야 자원낭비가 줄어든다
 
-- 팀별 포지션별 인원수와 팀별 전체 인원수 출력
 
-- Oracle, Simple Case Expr 

SELECT TEAM_ID,NVL(SUM(CASE WHEN POSITION = 'FW' THEN 1 END),0) FW,
               NVL(SUM(CASE WHEN POSITION = 'MF' THEN 1 END),0) MF,
               NVL(SUM(CASE WHEN POSITION = 'DF' THEN 1 END),0) DF,
               NVL(SUM(CASE WHEN POSITION = 'GK' THEN 1 END),0) GK,
               COUNT(*) SUM
FROM PLAYER        
GROUP BY TEAM_ID;


SELECT TEAM_ID,PLAYER_NAME
FROM PLAYER
WHERE TEAM_ID LIKE 'K12';

SELECT (SELECT COUNT(POSITION)
        FROM PLAYER
        GROUP BY TEAM_ID
        HAVING POSITION LIKE 'FW')
FROM PLAYER        ;


-- SOCCER_SQL_023
-- GROUP BY 절 없이 전체 선수들의 포지션별 평균 키 및 전체 평균 키 출력
SELECT DISTINCT(SELECT ROUND(AVG(HEIGHT),2)
               FROM PLAYER
               WHERE POSITION LIKE 'FW') 포워드,
               (SELECT ROUND(AVG(HEIGHT),2)
               FROM PLAYER
               WHERE POSITION LIKE 'MF') 미드필더,
               (SELECT ROUND(AVG(HEIGHT),2)
               FROM PLAYER
               WHERE POSITION LIKE 'DF') 수비수,
               (SELECT ROUND(AVG(HEIGHT),2)
               FROM PLAYER
               WHERE POSITION LIKE 'GK') 골키퍼,
               (SELECT ROUND(AVG(HEIGHT),2)
                FROM PLAYER
                ) "전체 평균 키"
 FROM PLAYER;
 
 
 