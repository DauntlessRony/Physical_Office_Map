	-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- start: insert into project_office_mapping table -->
	PROCEDURE hr_insert_into_project_office_mapping(OUT p_exe_status integer)
	IS
			v_last_id BIGINT:=0;
			v_country_id bigint:=2;
			v_user_id BIGINT:=1;
			v_class_name varchar(100):='ProjectOfficeMapping';
			v_errorcode TEXT:='';
			v_errortext TEXT='Successful';
			v_source VARCHAR(100):='hr_insert_into_project_office_mapping';

	BEGIN

	INSERT INTO public.procedure_log(start_table_name,start_proc_name,start_time,start_message) VALUES (v_class_name,v_source,current_timestamp::timestamp without time zone,SUBSTR(SQLERRM,1,200));

			p_exe_status:=-1;


--############# branch start

	INSERT INTO public.project_office_mapping
			(
			id
			,version
			,area_type
			,created_by
			,date_created
			,domain_status_id
			,last_updated
			,office_hierarchy_id
			,office_id
			,office_type_id
			,parent_office_id
			,project_info_id
			,updated_by
			)

	SELECT

			(row_number() OVER(ORDER BY poi.id)+(SELECT COALESCE(max(id),0) FROM public.project_office_mapping)) AS id -- 63
			,2 as version
			,poi.area_type as area_type
			,1 as created_by
			,current_date() as date_created
			,1 as domain_status_id
			,current_date() as last_updated
			,coalesce(poi.office_hierarchy_id,2) as office_hierarchy_id
			,poi.id as office_id
			,poi.office_type_id as office_type_id
			,poi.parent_office_id as parent_office_id
			,proj.id as project_info_id
			,1 as updated_by

/*
select * from bracdb.physical_office_info limit 10;
select * from bracdb.hr_and_mf_branch_code limit 10;
select * from public.project_office_mapping as pom where pom.office_id=462 and pom.project_info_id=125;

*/

-- select count(*)
from 
(select distinct branch_code,project_name from bracdb.physical_office_info where designation='BM') as brn_proj--2524
inner join (select branchid,mf_branchid from bracdb.hr_and_mf_branch_code) as m on (brn_proj.branch_code=m.mf_branchid)--2493
inner join (select * from physical_office_info where office_type_id=5) as poi on (m.branchid=poi.office_ref_code)--1771
inner join (select id,project_ref_code,project_name from public.project_info) as proj on (lower(proj.project_name)=lower(brn_proj.project_name))--1721

where not exists (select 1 from public.project_office_mapping as pom where pom.office_id=poi.id and pom.project_info_id=proj.id);--4

--############# branch end

--############# area start

	INSERT INTO public.project_office_mapping
			(
			id
			,version
			,area_type
			,created_by
			,date_created
			,domain_status_id
			,last_updated
			,office_hierarchy_id
			,office_id
			,office_type_id
			,parent_office_id
			,project_info_id
			,updated_by
			)

	SELECT

			(row_number() OVER(ORDER BY poi.id)+(SELECT COALESCE(max(id),0) FROM public.project_office_mapping)) AS id -- 63
			,2 as version
			,poi.area_type as area_type
			,1 as created_by
			,current_date() as date_created
			,1 as domain_status_id
			,current_date() as last_updated
			,coalesce(poi.office_hierarchy_id,2) as office_hierarchy_id
			,poi.id as office_id
			,poi.office_type_id as office_type_id
			,poi.parent_office_id as parent_office_id
			,proj.id as project_info_id
			,1 as updated_by

/*
select * from bracdb.physical_office_info limit 10;
select * from bracdb.hr_and_mf_branch_code limit 10;
select * from public.project_office_mapping as pom where pom.office_id=462 and pom.project_info_id=125;

*/

-- select count(*)
from 
(select distinct regexp_replace(area, '\r|\n', '', 'g') as office_name,project_name from bracdb.physical_office_info where designation='AM') as brn_proj--1184
inner join (select * from physical_office_info where office_type_id=4) as poi on (lower(brn_proj.office_name)=lower(poi.office_name))--1188
inner join (select id,project_ref_code,project_name from public.project_info) as proj on (lower(proj.project_name)=lower(brn_proj.project_name))--1188

where not exists (select 1 from public.project_office_mapping as pom where pom.office_id=poi.id and pom.project_info_id=proj.id);--1186

--############# area end

--############# region start

	INSERT INTO public.project_office_mapping
			(
			id
			,version
			,area_type
			,created_by
			,date_created
			,domain_status_id
			,last_updated
			,office_hierarchy_id
			,office_id
			,office_type_id
			,parent_office_id
			,project_info_id
			,updated_by
			)

	SELECT

			(row_number() OVER(ORDER BY poi.id)+(SELECT COALESCE(max(id),0) FROM public.project_office_mapping)) AS id -- 63
			,2 as version
			,poi.area_type as area_type
			,1 as created_by
			,current_date() as date_created
			,1 as domain_status_id
			,current_date() as last_updated
			,coalesce(poi.office_hierarchy_id,2) as office_hierarchy_id
			,poi.id as office_id
			,poi.office_type_id as office_type_id
			,poi.parent_office_id as parent_office_id
			,proj.id as project_info_id
			,1 as updated_by

/*
select * from bracdb.physical_office_info limit 10;
select * from bracdb.hr_and_mf_branch_code limit 10;
select * from public.project_office_mapping as pom where pom.office_id=462 and pom.project_info_id=125;

*/

-- select count(*)
from 
(select distinct regexp_replace(region, '\r|\n', '', 'g') as office_name,project_name from bracdb.physical_office_info where designation='RM') as brn_proj--230
inner join (select * from physical_office_info where office_type_id=3) as poi on (lower(brn_proj.office_name)=lower(poi.office_name))--230
inner join (select id,project_ref_code,project_name from public.project_info) as proj on (lower(proj.project_name)=lower(brn_proj.project_name))--230

where not exists (select 1 from public.project_office_mapping as pom where pom.office_id=poi.id and pom.project_info_id=proj.id);--230

--############# region end

--############# division start

	INSERT INTO public.project_office_mapping
			(
			id
			,version
			,area_type
			,created_by
			,date_created
			,domain_status_id
			,last_updated
			,office_hierarchy_id
			,office_id
			,office_type_id
			,parent_office_id
			,project_info_id
			,updated_by
			)

	SELECT

			(row_number() OVER(ORDER BY poi.id)+(SELECT COALESCE(max(id),0) FROM public.project_office_mapping)) AS id -- 63
			,2 as version
			,poi.area_type as area_type
			,1 as created_by
			,current_date() as date_created
			,1 as domain_status_id
			,current_date() as last_updated
			,coalesce(poi.office_hierarchy_id,2) as office_hierarchy_id
			,poi.id as office_id
			,poi.office_type_id as office_type_id
			,poi.parent_office_id as parent_office_id
			,proj.id as project_info_id
			,1 as updated_by

/*
select * from bracdb.physical_office_info limit 10;
select * from bracdb.hr_and_mf_branch_code limit 10;
select * from public.project_office_mapping as pom where pom.office_id=462 and pom.project_info_id=125;

*/

-- select count(*)
from 
(select distinct regexp_replace(division, '\r|\n', '', 'g') as office_name,project_name from bracdb.physical_office_info where designation='DM') as brn_proj--29
inner join (select * from physical_office_info where office_type_id=2) as poi on (lower(brn_proj.office_name)=lower(poi.office_name))--29
inner join (select id,project_ref_code,project_name from public.project_info) as proj on (lower(proj.project_name)=lower(brn_proj.project_name))--29

where not exists (select 1 from public.project_office_mapping as pom where pom.office_id=poi.id and pom.project_info_id=proj.id);--29

--############# division end


	insert into public.row(table_name,row_effected) values (v_class_name,SQL%ROWCOUNT);
	INSERT INTO public.procedure_log(end_table_name,end_proc_name,end_time,end_message) VALUES (v_class_name,v_source,current_timestamp::timestamp without time zone,SUBSTR(SQLERRM,1,200));






		EXCEPTION
			WHEN OTHERS THEN
			v_errorcode := SQLCODE;
			v_errortext := SUBSTR(SQLERRM, 1, 200);
			INSERT INTO error_log(generated_time, error_code, msg, source ,is_error)
			VALUES( current_timestamp,v_errorcode, v_errortext, v_source, 1::bit);





	end hr_insert_into_project_office_mapping;
	-- end: insert into project_office_mapping table --<
	-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------





























