	---------------------------------------------------------------------------------------------update member_complaint.office_info_id start
-----------------------------------------------------------------------------------------------------------------------------------------
/*
cis.member_complaint as omc
inner join cis.member_complaint_activity as omca on (omc.id=omca.member_complaint_id)
inner join member_complaint as mc on (omc.track_no=mc.track_no)
inner join member_complaint_activity as mca on (mc.id=mca.member_complaint_id)
*/
----------------pull these table to erp.public

select * from complaint_category limit 10;
select * from complaint_sub_category limit 10;
select * from complaint limit 10;
select * from member_complaint where track_no='CIS-AO340-000002';
select * from member_complaint_activity where complaint_status_id=370;
select * from member_complaint_document limit 10;


SELECT column_name FROM information_schema.columns as iscc WHERE iscc.table_schema='public'
AND iscc.table_name='member_complaint' and iscc.table_catalog=current_database() order by iscc.ordinal_position;


select * from physical_office_info where office_name='Uttar Khan';

drop table excel.member_complaint;

create table excel.member_complaint as
select
 id
,complaint_id
,(select username from application_user where id=created_by_id) as created_by_id
,member_mobile_no
,member_name
,member_no
,(select office_name from physical_office_info where id=office_info_id) as office_info_id
,(select office_type_id from physical_office_info where id=office_info_id) as office_info_id_type
,(select project_name from project_info where id=project_info_id) as project_info_id
,track_no
,(select username from application_user where id=user_assigned_by_id) as user_assigned_by_id
,(select username from application_user where id=user_raised_by_id) as user_raised_by_id
,(select office_name from physical_office_info where id=branch_office_id) as branch_office_id
,(select office_type_id from physical_office_info where id=branch_office_id) as branch_office_id_type
,(select office_name from physical_office_info where id=area_office_id) as area_office_id
,(select office_type_id from physical_office_info where id=area_office_id) as area_office_id_type
,(select office_name from physical_office_info where id=region_office_id) as region_office_id
,(select office_type_id from physical_office_info where id=region_office_id) as region_office_id_type
,(select office_name from physical_office_info where id=division_office_id) as division_office_id
,(select office_type_id from physical_office_info where id=division_office_id) as division_office_id_type
from member_complaint order by member_name; -- track_no='CIS-AO340-000002' 



-------------------------------

select * from public.member_complaint limit 10;
select * from bracdb.member_complaint limit 10;

select * from public.member_complaint where track_no='CIS-AO340-000002';



select * from application_user limit 10;
select id from application_user where full_name='MD. SAJEDUL ISLAM';
select * from application_user where id=179;
select * from physical_office_info where id=6968;
select * from employee_core_info where pin_no='00145504';
select * from bracdb.member_complaint where created_by_id='00145504';
select * from member_complaint where created_by_id='00145504';


update bracdb.member_complaint u set 
u.created_by_id=lpad(u.created_by_id,8,'0')
,u.user_assigned_by_id=lpad(u.user_assigned_by_id,8,'0')
,u.user_raised_by_id=lpad(u.user_assigned_by_id,8,'0')
; --189

select count(a.office_name),a.office_name,a.office_type_id

from physical_office_info as a
inner join (select distinct office_info_id,office_info_id_type from bracdb.member_complaint) as b 
on (a.office_name=b.office_info_id and a.office_type_id=b.office_info_id_type)
group by a.office_name,a.office_type_id having count(a.office_name)>1 order by a.office_name;




update public.member_complaint as u set 
 u.created_by_id=(select id from application_user where username=vt.created_by_id)
,u.office_info_id=(select id from physical_office_info where office_name=vt.office_info_id and office_type_id=vt.office_info_id_type and mf_ref_code is not null)
,u.user_assigned_by_id=(select id from application_user where username=vt.user_assigned_by_id)
,u.user_raised_by_id=(select id from application_user where username=vt.user_raised_by_id)
,u.project_info_id=(select id from project_info where project_name=vt.project_info_id)
,u.branch_office_id=(select id from physical_office_info where office_name=vt.branch_office_id and office_type_id=vt.branch_office_id_type and mf_ref_code is not null)
,u.area_office_id=(select id from physical_office_info where office_name=vt.area_office_id and office_type_id=vt.area_office_id_type and mf_ref_code is not null)
,u.region_office_id=(select id from physical_office_info where office_name=vt.region_office_id and office_type_id=vt.region_office_id_type and mf_ref_code is not null)
,u.division_office_id=(select id from physical_office_info where office_name=vt.division_office_id and office_type_id=vt.division_office_id_type and mf_ref_code is not null)

from 
(

select
 pmc.id as nid
,bmc.id as oid
,bmc.created_by_id
,bmc.office_info_id
,bmc.office_info_id_type
,bmc.project_info_id
,bmc.user_assigned_by_id
,bmc.user_raised_by_id
,bmc.branch_office_id
,bmc.branch_office_id_type
,bmc.area_office_id
,bmc.area_office_id_type
,bmc.region_office_id
,bmc.region_office_id_type
,bmc.division_office_id
,bmc.division_office_id_type
from 
public.member_complaint as pmc
inner join bracdb.member_complaint as bmc on (pmc.id=bmc.id)

where bmc.office_info_id not in 
( 'Adampur'
,'Baliadanga'
,'Baniachong'
,'Comilla Sadar'
,'Fultola'
,'Jamalgonj'
,'Lalpur'
,'Munshirhat'
,'Paharpur'
,'Sarail'
,'Shibgonj'
,'Uttara')

) as vt where u.id=vt.nid; -- update 171 out of 189
-- and u.track_no='CIS-AO340-000002';




-----------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------update member_complaint.office_info_id end
--################################################################################################################################################
---------------------------------------------------------------------------------------------update member_complaint_activity.office_info_id start
-----------------------------------------------------------------------------------------------------------------------------------------
select * from member_complaint_activity limit 10; 


update bracdb.member_complaint_activity u set 
u.user_assign_id=lpad(u.user_assign_id,8,'0')
,u.user_assign_by_id=lpad(u.user_assign_by_id,8,'0')
,u.user_comment_by_id=lpad(u.user_comment_by_id,8,'0')
;--340



create table excel.member_complaint_activity as

select
 id
,comments
,complaint_status_id
,date_assign
,date_change_status
,date_comments
,member_complaint_id
,(select office_name from physical_office_info where id=office_info_id) as office_info_id
,(select office_type_id from physical_office_info where id=office_info_id) as office_info_id_type
,(select username from application_user where id=user_assign_id) as user_assign_id
,(select username from application_user where id=user_assign_by_id) as user_assign_by_id
,(select username from application_user where id=user_comment_by_id) as user_comment_by_id
,is_member_insert
from member_complaint_activity;



---------------------
select * from public.member_complaint_activity where id=473;
Burichang

select * from physical_office_info where office_name='Shayestagonj' and office_type_id=5;

Adampur
Comilla Sadar
Fultola
Jamalgonj
Munshirhat
Paharpur
Shibgonj



select * from bracdb.member_complaint_activity where office_info_id='Adampur';





select count(a.office_name),a.office_name,a.office_type_id

from physical_office_info as a
inner join (select distinct office_info_id,office_info_id_type from bracdb.member_complaint_activity) as b 
on (a.office_name=b.office_info_id and a.office_type_id=b.office_info_id_type)
group by a.office_name,a.office_type_id having count(a.office_name)>1 order by a.office_name;


select count(a.office_name),a.office_name

from physical_office_info as a
inner join (select distinct office_info_id,office_info_id_type from bracdb.member_complaint_activity) as b 
on (a.office_name=b.office_info_id and a.office_type_id=b.office_info_id_type)
group by a.office_name having count(a.office_name)>1 order by a.office_name;



update public.member_complaint_activity u set 

u.office_info_id=(select distinct id from physical_office_info where office_name=vt.office_info_id and office_type_id=vt.office_info_id_type and mf_ref_code is not null)

,u.user_assign_id=(select id from application_user where username=vt.user_assign_id)
,u.user_assign_by_id=(select id from application_user where username=vt.user_assign_by_id)
,u.user_comment_by_id=(select id from application_user where username=vt.user_comment_by_id)
from
(

	select 
	 m.id as mid
	,o.id as oid
	,o.office_info_id
	,o.office_info_id_type
	,o.user_assign_id
	,o.user_assign_by_id
	,o.user_comment_by_id

	from
	public.member_complaint_activity as m
	inner join bracdb.member_complaint_activity o on (m.id=o.id)
	where o.office_info_id not in 
	('Adampur'
,'Bajitpur'
,'Bancharampur'
,'Baniachong'
,'Brahmanpara'
,'Chunarughat'
,'Comilla Sadar'
,'Daudkandi'
,'Debidwar'
,'Fultola'
,'Jamalgonj'
,'Munshirhat'
,'Nabigonj'
,'Paharpur'
,'Rangunia'
,'Sarail'
,'Senbag'
,'Shibgonj'
,'Uttara')

) as vt where u.id=vt.mid; --update 286 out of 340


-----------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------update member_complaint_activity.office_info_id end

