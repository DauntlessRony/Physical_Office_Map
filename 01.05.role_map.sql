-------------------------------------------------------------------------------------------------------------
--========================================================= ba role start

select * from user_authority where id=61;
select * from data_test;
select distinct user_authority_id from data_test;


--update data_test dt set dt.pin = RIGHT(CONCAT('00000000',dt.pin),8)
--update data_test dt set dt.application_user_id = (select au.id from application_user au where au.username = dt.pin)
--update data_test dt set dt.user_authority_id = (select ua.id from user_authority ua where ua.role=dt.role)

select * from application_user_authority limit 1;
select max(id) from application_user_authority;--50199

create table application_user_authority_bak_before_ba as select * from application_user_authority;

INSERT INTO application_user_authority (id, application_user_id, user_authority_id)

SELECT (row_number() OVER(ORDER BY dt.id)+(select max(id) from application_user_authority)) as id
, application_user_id
, user_authority_id
FROM data_test as dt where dt.id != 1 and dt.application_user_id is not null order by 1;

--========================================================= ba role end

-------------------------------------------------------------------------------------------------------------


-- find out role list from cis start

select * from user_authority limit 10;
select * from application_user limit 10;
select * from application_user_authority limit 10;

select * from excel.role_map;

create table excel.role_map as 
select
application_user_id
,(select a.username from application_user as a where a.id=application_user_id) as application_user_id_pin
,(select b.full_name from application_user as b where b.id=application_user_id) as application_user_id_name
,user_authority_id
,(select c.authority from user_authority as c where c.id=user_authority_id) as user_authority_id_auth
,(select d.role from user_authority as d where d.id=user_authority_id) as user_authority_id_role
from application_user_authority order by 3;

-- find out role list from cis end




