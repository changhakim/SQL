-- SQL_TEST_001
-- ��ü �౸�� ���. �̸� ��������
SELECT TEAM_NAME
FROM TEAM
ORDER BY TEAM_NAME;
-- SQL_TEST_002
-- ������ ����(�ߺ�����,������ �����
SELECT DISTINCT POSITION
FROM PLAYER;


-- SQL_TEST_003
-- ������ ����(�ߺ�����,������ �������� ����)
-- nvl2()���
SELECT DISTINCT NVL2(POSITION,POSITION,'����') POSITION
FROM PLAYER;
-- SQL_TEST_004
-- ������(ID: K02)��Ű��
SELECT PLAYER_NAME
FROM PLAYER
WHERE PLAYER_NAME IN (SELECT PLAYER_NAME
        FROM PLAYER
        WHERE TEAM_ID LIKE 'K02' AND POSITION LIKE 'GK');


-- SQL_TEST_005
-- ������(ID: K02)Ű�� 170 �̻� ����
-- �̸鼭 ���� ���� ����
SELECT POSITION,PLAYER_NAME
FROM PLAYER       
WHERE PLAYER_NAME IN (SELECT PLAYER_NAME
                 FROM PLAYER
                 WHERE HEIGHT >=170 AND PLAYER_NAME LIKE '��%' AND TEAM_ID LIKE 'K02');
                 
                 
-- SQL_TEST_006
-- ������(ID: K02) ������ �̸�,
-- Ű�� ������ ����Ʈ (���� cm �� kg ����)
-- Ű�� �����԰� ������ "0" ǥ��
-- Ű ��������
SELECT PLAYER_NAME||'����',NVL2(HEIGHT,HEIGHT,0)||'cm' Ű,NVL2(WEIGHT,WEIGHT,0)||'kg' ������
FROM PLAYER
WHERE TEAM_ID LIKE 'K02'
ORDER BY Ű DESC;


-- SQL_TEST_007
-- ������(ID: K02) ������ �̸�,
-- Ű�� ������ ����Ʈ (���� cm �� kg ����)
-- Ű�� �����԰� ������ "0" ǥ��
-- BMI���� 
-- Ű ��������
SELECT PLAYER_NAME|| '����' ������,NVL2(HEIGHT,HEIGHT,0)||'cm' Ű,NVL2(WEIGHT,WEIGHT,0)||'kg' ������,ROUND(((WEIGHT/(HEIGHT*HEIGHT))*10000),2) BMI
FROM PLAYER
WHERE TEAM_ID LIKE 'K02'
ORDER BY Ű DESC;


-- SQL_TEST_008
-- ������(ID: K02) �� ������(ID: K10)������ �� 
--  �������� GK ��  ����
-- ����, ����� ��������
SELECT T.TEAM_NAME,P.PLAYER_NAME
FROM (SELECT TEAM_NAME,TEAM_ID
      FROM TEAM
      WHERE TEAM_ID IN('K02','K10')) T
        JOIN PLAYER P ON T.TEAM_ID LIKE P.TEAM_ID
WHERE P.POSITION LIKE 'GK'        
ORDER BY T.TEAM_NAME,P.PLAYER_NAME
;

-- SQL_TEST_009
-- ������(ID: K02) �� ������(ID: K10)������ �� ��
-- Ű�� 180 �̻� 183 ������ ������
-- Ű, ����, ����� ��������
SELECT P.HEIGHT Ű,T.TEAM_NAME ����,P.PLAYER_NAME ������
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
-- ��� ������ ��
-- �������� �������� ���� �������� ���� �̸�
-- ����, ����� ��������
SELECT TEAM_NAME,PLAYER_NAME
FROM (SELECT PLAYER_NAME,TEAM_ID
      FROM PLAYER
      WHERE POSITION IS NULL) P 
      JOIN TEAM T ON T.TEAM_ID LIKE P.TEAM_ID

ORDER BY TEAM_NAME,PLAYER_NAME;

-- SOCCER_SQL_011
-- ���� ��Ÿ����� �����Ͽ�
-- ���̸�, ��Ÿ��� �̸� ���
SELECT TEAM_NAME,STADIUM_NAME
FROM TEAM T
JOIN STADIUM S ON S.STADIUM_ID LIKE T.STADIUM_ID
ORDER BY TEAM_NAME;
-- SOCCER_SQL_012
-- ���� ��Ÿ���, �������� �����Ͽ�
-- 2012�� 3�� 17�Ͽ� ���� �� ����� 
-- ���̸�, ��Ÿ���, ������� �̸� ���
-- �������̺� join �� ã�Ƽ� �ذ��Ͻÿ�
SELECT * FROM TEAM;
SELECT TEAM_NAME,STADIUM_NAME,(SELECT TEAM_NAME
                               FROM TEAM
                               WHERE TEAM_ID LIKE D.AWAYTEAM_ID) �������,SCHE_DATE ��¥
FROM (SELECT SCHE_DATE,STADIUM_ID,AWAYTEAM_ID
      FROM SCHEDULE
      WHERE SCHE_DATE LIKE '20120317') D
      JOIN STADIUM S ON S.STADIUM_ID LIKE D.STADIUM_ID
      JOIN TEAM T ON T.STADIUM_ID LIKE S.STADIUM_ID
      ORDER BY TEAM_NAME;
      
-- SOCCER_SQL_013
-- 2012�� 3�� 17�� ��⿡ 
-- ���� ��ƿ���� �Ҽ� ��Ű��(GK)
-- ����, ������,���� (����������), 
-- ��Ÿ���, ��⳯¥�� ���Ͻÿ�
-- �������� ���̸��� ������ ���ÿ�

SELECT PLAYER_NAME ����,POSITION ������,CONCAT(T.REGION_NAME,T.TEAM_NAME) ���̸�,STADIUM_NAME,SCHE_DATE
FROM (SELECT STADIUM_ID,SCHE_DATE
      FROM SCHEDULE
      WHERE SCHE_DATE LIKE '20120317') D
        JOIN STADIUM S 
            ON S.STADIUM_ID LIKE D.STADIUM_ID
        JOIN TEAM T 
            ON S.STADIUM_ID LIKE T.STADIUM_ID
        JOIN PLAYER P 
            ON P.TEAM_ID LIKE T.TEAM_ID 
      WHERE T.TEAM_NAME LIKE '��ƿ����' AND POSITION LIKE 'GK'; 
    
 
SELECT (SELECT TEAM_NAME
        FROM TEAM
        WHERE TEAM_NAME LIKE '��ƿ����' AND P.POSITION LIKE 'GK') ����,POSITION ������,CONCAT(T.REGION_NAME,T.TEAM_NAME) ���̸�,STADIUM_NAME,SCHE_DATE
FROM (SELECT STADIUM_ID,SCHE_DATE
      FROM SCHEDULE
      WHERE SCHE_DATE LIKE '20120317') D
        JOIN STADIUM S 
            ON S.STADIUM_ID LIKE D.STADIUM_ID
        JOIN TEAM T 
            ON S.STADIUM_ID LIKE T.STADIUM_ID
        JOIN PLAYER P 
            ON P.TEAM_ID LIKE T.TEAM_ID ;
     
     

-- SOCCER_SQL_014
-- Ȩ���� 3���̻� ���̷� �¸��� ����� 
-- ����� �̸�, ��� ����
-- Ȩ�� �̸��� ������ �̸���
-- ���Ͻÿ�

SELECT STADIUM_NAME �����,SCHE_DATE "��� ����",(SELECT TEAM_NAME
                                                    FROM TEAM
                                                    WHERE D.HOMETEAM_ID LIKE TEAM_ID)Ȩ��,(SELECT TEAM_NAME
                                                    FROM TEAM
                                                    WHERE D.AWAYTEAM_ID LIKE TEAM_ID) ������ 
    FROM (SELECT HOMETEAM_ID,AWAYTEAM_ID,SCHE_DATE,STADIUM_ID
          FROM SCHEDULE
          WHERE (HOME_SCORE - AWAY_SCORE) >=3) D
          JOIN STADIUM S ON S.STADIUM_ID LIKE D.STADIUM_ID
          JOIN TEAM T ON T.STADIUM_ID LIKE S.STADIUM_ID;

          
-- SOCCER_SQL_015
-- STADIUM �� ��ϵ� ��� �߿���
-- Ȩ���� ���� �������� ���� ��������
-- ī��Ʈ ���� 20
SELECT S.STADIUM_NAME ,S.STADIUM_ID,S.SEAT_COUNT,S.HOMETEAM_ID,T.E_TEAM_NAME
FROM  (SELECT STADIUM_NAME,HOMETEAM_ID,STADIUM_ID,SEAT_COUNT
       FROM STADIUM) S
       FULL OUTER JOIN TEAM 
       T ON T.STADIUM_ID LIKE S.STADIUM_ID
ORDER BY HOMETEAM_ID; 
          
-- SOCCER_SQL_016
-- ���Ű�� ��õ ������Ƽ������ ���Ű ���� ���� ���� 
-- ��ID, ����, ���Ű ����
SELECT T.TEAM_ID,T.TEAM_NAME,ROUND(AVG(P.HEIGHT),2) ���Ű
    FROM (SELECT HEIGHT,TEAM_ID
          FROM PLAYER) P
    JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
    GROUP BY T.TEAM_ID,T.TEAM_NAME
    HAVING ROUND(AVG(P.HEIGHT),2)<180.51 ;
    


SELECT T.TEAM_ID �����̵�,T.TEAM_NAME ����,ROUND(AVG(P.HEIGHT),2) ���Ű
FROM (SELECT HEIGHT,TEAM_ID
      FROM PLAYER) P 
    JOIN TEAM T ON P.TEAM_ID = T.TEAM_ID
GROUP BY T.TEAM_ID,T.TEAM_NAME
HAVING ROUND(AVG(P.HEIGHT),2) < (SELECT ROUND(AVG(HEIGHT),2)
                        FROM PLAYER
                        GROUP BY TEAM_ID
                        HAVING TEAM_ID LIKE 'K04'
                        ) 
ORDER BY ���Ű ;                    



    
    
SELECT T.TEAM_ID,T.TEAM_NAME,(SELECT ROUND(AVG(HEIGHT),2)
                              FROM PLAYER P
                              WHERE T.TEAM_ID=P.TEAM_ID) ���Ű
FROM TEAM T;          
        
    
-- SOCCER_SQL_017
-- �������� MF �� ��������  �Ҽ����� �� ������, ��ѹ� ���
SELECT POSITION ������,TEAM_NAME "�Ҽ� ����",PLAYER_NAME ������,BACK_NO ��ѹ�
FROM (SELECT POSITION,TEAM_ID,BACK_NO,PLAYER_NAME
      FROM PLAYER
      WHERE POSITION LIKE 'MF') P
            JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
ORDER BY ������ ;    
      
-- SOCCER_SQL_018
-- ���� Űū ���� 5 ����, ����Ŭ, �� Ű ���� ������ ����
SELECT PLAYER_NAME ������,BACK_NO ��ѹ�,POSITION ������,HEIGHT Ű
FROM (SELECT PLAYER_NAME,BACK_NO,POSITION,HEIGHT
       FROM PLAYER
       WHERE HEIGHT IS NOT NULL 
       ORDER BY HEIGHT DESC
       ) P
WHERE ROWNUM <= 5;        

-- SOCCER_SQL_019
-- ���� �ڽ��� ���� ���� ���Ű���� ���� ���� ���� ���
SELECT TEAM_NAME ����,PLAYER_NAME ������,POSITION ������,BACK_NO ��ѹ�,HEIGHT Ű
FROM (SELECT PLAYER_NAME,POSITION,BACK_NO,AVG(HEIGHT) ,HEIGHT, TEAM_ID
      FROM PLAYER )P
    JOIN TEAM T ON T.TEAM_ID LIKE P.TEAM_ID
    GROUP BY T.TEAM_ID,T.TEAM_NAME,PLAYER_NAME,POSITION,BACK_NO,HEIGHT
    
     ;
      
  SELECT TEAM_NAME ����,PLAYER_NAME ������,POSITION ������,BACK_NO ��ѹ�,HEIGHT Ű   
  FROM PLAYER P    
  WHERE P.HEIGHT <= (SELECT AVG(P.HEIGHT)
      FROM TEAM
      GROUP BY TEAM_ID);
-- SOCCER_SQL_020
-- 2012�� 5�� �Ѵް� ��Ⱑ �ִ� ����� ��ȸ
-- EXISTS ������ �׻� ���������� ����Ѵ�.
-- ���� �ƹ��� ������ �����ϴ� ���� ���� ���̶�
-- ������ �����ϴ� 1�Ǹ� ã���� �߰����� �˻��� �������� �ʴ´�.

SELECT STADIUM_ID,STADIUM_NAME
FROM STADIUM S
WHERE EXISTS(SELECT 1
      FROM SCHEDULE D
      WHERE D.STADIUM_ID = S.STADIUM_ID AND D.SCHE_DATE BETWEEN '20120501' AND '20120531'
      );
      
      SELECT S.STADIUM_ID,S.STADIUM_NAME,D.SCHE_DATE
      FROM STADIUM S
      JOIN SCHEDULE D ON D.STADIUM_ID = S.STADIUM_ID;     