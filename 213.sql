---페이징예제--

select p.BIRTH_DATE 생년월일, p.PLAYER_NAME
from player p
where p.BIRTH_DATE is not null;

select count(10)
from player p
where p.BIRTH_DATE is not null;
--1단계
select p.BIRTH_DATE 생년월일,p.PLAYER_NAME 이름
from player p
where p.BIRTH_DATE is not null
order by p.BIRTH_DATE desc;

--2단계  rownum으로 사용해봄
select rownum 순위,
       p.BIRTH_DATE 생년월일,
       p.PLAYER_NAME 이름
from (select p.BIRTH_DATE,p.PLAYER_NAME
       from player p
       where p.BIRTH_DATE is not null
       order by p.BIRTH_DATE desc) p
where rownum between 1 and 5;

--3단계

select rnum 순위,BIRTH_DATE,PLAYER_NAME
from (select rownum rnum,BIRTH_DATE,PLAYER_NAME
       from ( select BIRTH_DATE,PLAYER_NAME
               from player
               where BIRTH_DATE is not null
               order by BIRTH_DATE desc))
where rnum between 6 and 10;