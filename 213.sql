---����¡����--

select p.BIRTH_DATE �������, p.PLAYER_NAME
from player p
where p.BIRTH_DATE is not null;

select count(10)
from player p
where p.BIRTH_DATE is not null;
--1�ܰ�
select p.BIRTH_DATE �������,p.PLAYER_NAME �̸�
from player p
where p.BIRTH_DATE is not null
order by p.BIRTH_DATE desc;

--2�ܰ�  rownum���� ����غ�
select rownum ����,
       p.BIRTH_DATE �������,
       p.PLAYER_NAME �̸�
from (select p.BIRTH_DATE,p.PLAYER_NAME
       from player p
       where p.BIRTH_DATE is not null
       order by p.BIRTH_DATE desc) p
where rownum between 1 and 5;

--3�ܰ�

select rnum ����,BIRTH_DATE,PLAYER_NAME
from (select rownum rnum,BIRTH_DATE,PLAYER_NAME
       from ( select BIRTH_DATE,PLAYER_NAME
               from player
               where BIRTH_DATE is not null
               order by BIRTH_DATE desc))
where rnum between 6 and 10;