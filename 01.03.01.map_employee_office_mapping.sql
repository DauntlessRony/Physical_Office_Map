	-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- start: insert into employee_office_mapping_branch -->

	PROCEDURE hr_insert_into_employee_office_mapping(OUT p_exe_status integer)
	IS
			v_last_id BIGINT:=0;
			v_user_id BIGINT:=1;
			v_class_name varchar(100):='EmployeeOfficeMapping';
			v_errorcode TEXT:='';
			v_errortext TEXT='Successful';
			v_source VARCHAR(100):='hr_insert_into_employee_office_mapping';

	BEGIN

	INSERT INTO public.procedure_log(start_table_name,start_proc_name,start_time,start_message) VALUES (v_class_name,v_source,current_timestamp::timestamp without time zone,SUBSTR(SQLERRM,1,200));

			p_exe_status:=-1;


/*

--single insert

INSERT INTO public.employee_office_mapping
(
id
,version
,domain_status_id
,employee_info_id
,office_country_id
,office_info_id
)
SELECT

(row_number() OVER( ORDER BY eci.id) + (SELECT COALESCE(max(t.id),0) FROM public.employee_office_mapping as t)) AS id
,0 as version
,1 as domain_status_id
,38861 as employee_info_id
,2 as office_country_id
,7734 as office_info_id

from 
dual;

*/



--##################### branch start

--select count(*) from public.employee_office_mapping; --62113

		INSERT INTO public.employee_office_mapping
			(
			 id
			,version
			,domain_status_id
			,employee_info_id
			,office_country_id
			,office_info_id
			)
		SELECT

			 (row_number() OVER( ORDER BY eci.id) + (SELECT COALESCE(max(t.id),0) FROM public.employee_office_mapping as t)) AS id
			,0 as version
			,1 as domain_status_id
			,eci.id as employee_info_id
			,2 as office_country_id
			,poi.id as office_info_id--<physical_office_info (id)
/*
select * from bracdb.physical_office_info limit 10;
select * from employee_designation where name like '%Manager%';
name
Branch Manager#5
*/

	-- select count(*)
	from 
	(select distinct branch_code,pin from bracdb.physical_office_info where designation='BM') as brn_proj--2606
	--inner join (select distinct branchid,mf_branchid from bracdb.hr_and_mf_branch_code) as m on (brn_proj.branch_code=m.mf_branchid)--2574
	inner join (select * from physical_office_info where office_type_id=5) as poi on (brn_proj.branch_code=poi.mf_branch_id)--1823
	inner join (select * from employee_core_info) as eci on (eci.pin_no=brn_proj.pin)--1758
	WHERE not exists (select 1 from public.employee_office_mapping eom where eom.employee_info_id=eci.id
			and eom.office_info_id=eci.office_info_id and eom.office_info_id=poi.id)
	and eci.domain_status_id<>2 order by office_info_id;--97


--##################### branch end

--##################### area start

		INSERT INTO public.employee_office_mapping
			(
			 id
			,version
			,domain_status_id
			,employee_info_id
			,office_country_id
			,office_info_id
			)
		SELECT

			 (row_number() OVER( ORDER BY eci.id) + (SELECT COALESCE(max(t.id),0) FROM public.employee_office_mapping as t)) AS id
			,0 as version
			,1 as domain_status_id
			,eci.id as employee_info_id
			,2 as office_country_id
			,poi.id as office_info_id--<physical_office_info (id)
/*
select * from bracdb.physical_office_info limit 10;
select id,name from employee_designation where name like '%Manager%' order by name;
id	name
6	Area Manager
*/

-- select count(*)
from 
(select distinct regexp_replace(area, '\r|\n', '', 'g') as office_name,pin from bracdb.physical_office_info where designation='AM') as brn_proj--990
inner join (select * from physical_office_info where office_type_id=4) as poi on (lower(brn_proj.office_name)=lower(poi.office_name))--995
inner join (select * from employee_core_info) as eci on (eci.pin_no=brn_proj.pin)--962
WHERE not exists (select 1 from public.employee_office_mapping eom where eom.employee_info_id=eci.id
		and eom.office_info_id=eci.office_info_id and eom.office_info_id=poi.id)
and eci.domain_status_id<>2;--993


--##################### area end

--##################### region start

		INSERT INTO public.employee_office_mapping
			(
			 id
			,version
			,domain_status_id
			,employee_info_id
			,office_country_id
			,office_info_id
			)
		SELECT

			 (row_number() OVER( ORDER BY eci.id) + (SELECT COALESCE(max(t.id),0) FROM public.employee_office_mapping as t)) AS id
			,0 as version
			,1 as domain_status_id
			,eci.id as employee_info_id
			,2 as office_country_id
			,poi.id as office_info_id--<physical_office_info (id)
/*
select * from bracdb.physical_office_info limit 10;
select distinct designation from bracdb.physical_office_info;
select id,name from employee_designation where name like '%Manager%' order by name;
id	name
9	Regional Manager
*/

-- select count(*)
from 
(select distinct regexp_replace(region, '\r|\n', '', 'g') as office_name,pin from bracdb.physical_office_info where designation='RM') as brn_proj--168
inner join (select * from physical_office_info where office_type_id=3) as poi on (lower(brn_proj.office_name)=lower(poi.office_name))--168
inner join (select * from employee_core_info) as eci on (eci.pin_no=brn_proj.pin)--168
WHERE not exists (select 1 from public.employee_office_mapping eom where eom.employee_info_id=eci.id
		and eom.office_info_id=eci.office_info_id and eom.office_info_id=poi.id)
and eci.domain_status_id<>2;--168


--##################### region end
--##################### div start

		INSERT INTO public.employee_office_mapping
			(
			 id
			,version
			,domain_status_id
			,employee_info_id
			,office_country_id
			,office_info_id
			)
		SELECT

			 (row_number() OVER( ORDER BY eci.id) + (SELECT COALESCE(max(t.id),0) FROM public.employee_office_mapping as t)) AS id
			,0 as version
			,1 as domain_status_id
			,eci.id as employee_info_id
			,2 as office_country_id
			,poi.id as office_info_id--<physical_office_info (id)
/*
select * from bracdb.physical_office_info limit 10;
select id,name from employee_designation where name like '%Manager%' order by name;
id	name
40	Divisional Manager
*/

-- select count(*)
from 
(select distinct regexp_replace(division, '\r|\n', '', 'g') as office_name,pin from bracdb.physical_office_info where designation='DM') as brn_proj--19
inner join (select * from physical_office_info where office_type_id=2) as poi on (lower(brn_proj.office_name)=lower(poi.office_name))--19
inner join (select * from employee_core_info) as eci on (eci.pin_no=brn_proj.pin)--19
WHERE not exists (select 1 from public.employee_office_mapping eom where eom.employee_info_id=eci.id
	and eom.office_info_id=eci.office_info_id and eom.office_info_id=poi.id)
and eci.domain_status_id<>2;--19


--##################### div end

	insert into public.row(table_name,row_effected) values (v_class_name,SQL%ROWCOUNT);
	INSERT INTO public.procedure_log(end_table_name,end_proc_name,end_time,end_message) VALUES (v_class_name,v_source,current_timestamp::timestamp without time zone,SUBSTR(SQLERRM,1,200));




		EXCEPTION
			WHEN OTHERS THEN
			v_errorcode := SQLCODE;
			v_errortext := SUBSTR(SQLERRM, 1, 200);
			INSERT INTO error_log(generated_time, error_code, msg, source ,is_error)
			VALUES( current_timestamp,v_errorcode, v_errortext, v_source, 1::bit);




	end hr_insert_into_employee_office_mapping;

	-- end: insert into employee_office_mapping --<
	-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
