
SELECT P.BIRTH_DATE 생년월일,P.PLAYER_NAME 선수
FROM PLAYER P
WHERE P.BIRTH_DATE IS NOT NULL AND ROWNUM BETWEEN 1 AND 5
ORDER BY P.BIRTH_DATE DESC;


SELECT P.BIRTH_DATE 생년월일,P.PLAYER_NAME 선수
FROM (SELECT BIRTH_DATE,PLAYER_NAME
      FROM PLAYER
      WHERE BIRTH_DATE IS NOT NULL
      ORDER BY BIRTH_DATE DESC) P
WHERE ROWNUM BETWEEN 1 AND 5;




SELECT rnum no, BIRTH_DATE 생년월일,PLAYER_NAME 선수 
FROM (SELECT BIRTH_DATE ,PLAYER_NAME , ROWNUM rnum 
      FROM (SELECT BIRTH_DATE ,PLAYER_NAME
            FROM PLAYER
            WHERE BIRTH_DATE IS NOT NULL
            ORDER BY BIRTH_DATE DESC))
WHERE rnum BETWEEN 6 AND 10;

select * from player;



