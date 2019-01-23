-- SOCCER_SQL_021
-- ���� ���� �Ҽ����� ������� ���
SELECT PLAYER_NAME �����̸�,POSITION ������,BACK_NO ��ѹ�
FROM (SELECT TEAM_ID,PLAYER_NAME,POSITION,BACK_NO
      FROM PLAYER
      WHERE TEAM_ID LIKE(SELECT TEAM_ID
                         FROM PLAYER
                         WHERE PLAYER_NAME LIKE '����')
      ORDER BY PLAYER_NAME);
                         
SELECT PLAYER_NAME
FROM PLAYER
WHERE TEAM_ID LIKE 'K04';

-- SOCCER_SQL_022
-- NULL ó���� �־�
-- SUM(NVL(SAL,0)) �� ��������
-- NVL(SUM(SAL),0) ���� �ؾ� �ڿ����� �پ���
 
-- ���� �����Ǻ� �ο����� ���� ��ü �ο��� ���
 
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
-- GROUP BY �� ���� ��ü �������� �����Ǻ� ��� Ű �� ��ü ��� Ű ���
SELECT DISTINCT(SELECT ROUND(AVG(HEIGHT),2)
               FROM PLAYER
               WHERE POSITION LIKE 'FW') ������,
               (SELECT ROUND(AVG(HEIGHT),2)
               FROM PLAYER
               WHERE POSITION LIKE 'MF') �̵��ʴ�,
               (SELECT ROUND(AVG(HEIGHT),2)
               FROM PLAYER
               WHERE POSITION LIKE 'DF') �����,
               (SELECT ROUND(AVG(HEIGHT),2)
               FROM PLAYER
               WHERE POSITION LIKE 'GK') ��Ű��,
               (SELECT ROUND(AVG(HEIGHT),2)
                FROM PLAYER
                ) "��ü ��� Ű"
 FROM PLAYER;
 
 
 