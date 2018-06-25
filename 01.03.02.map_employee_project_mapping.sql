	-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- start: insert into employee_project_mapping -->
	PROCEDURE hr_insert_into_employee_project_mapping(OUT p_exe_status integer)
	IS
			v_last_id BIGINT:=0;
			v_country_id bigint:=2;
			v_user_id BIGINT:=1;
			v_class_name varchar(100):='EmployeeProjectMapping';
			v_errorcode TEXT:='';
			v_errortext TEXT='Successful';
			v_source VARCHAR(100):='hr_insert_into_employee_project_mapping';

	BEGIN

	INSERT INTO public.procedure_log(start_table_name,start_proc_name,start_time,start_message) VALUES (v_class_name,v_source,current_timestamp::timestamp without time zone,SUBSTR(SQLERRM,1,200));

			p_exe_status:=-1;





--################# branch start


		INSERT INTO public.employee_project_mapping
			(
			id
			,version
			,created_by
			,date_created
			,domain_status_id
			,employee_info_id
			,employee_project_id
			,last_updated
			,start_date
			,tentative_finish_date
			,updated_by
			,is_core_project
			)

		SELECT
			 (row_number() OVER (ORDER BY eci.id,eci.office_info_id )+(SELECT COALESCE(MAX(id),0) FROM employee_project_mapping)) as  id
			,0 as version
			,1 as created_by--v_user_id
			,current_timestamp::timestamp without time zone as date_created
			,1 as domain_status_id
			,eci.id as employee_info_id
			,eci.core_project_id as employee_project_id
			,current_timestamp::timestamp without time zone as last_updated
			,current_timestamp::timestamp without time zone as start_date
			,current_timestamp::timestamp without time zone as tentative_finish_date
			,1 as updated_by--v_user_id
			,true as is_core_projec


	-- select count(*)
	FROM (select distinct pin,project_name from bracdb.physical_office_info) as beapm --3935
		inner JOIN public.employee_core_info as eci ON (eci.pin_no=beapm.pin)--3928
		INNER join public.project_info as pi on (lower(pi.project_name)=lower(beapm.project_name))--3928
		WHERE NOT EXISTS (SELECT 1 FROM employee_project_mapping as epm
				WHERE eci.id=epm.employee_info_id and epm.employee_project_id=eci.core_project_id)
		and eci.domain_status_id<>2;

--################# branch end


	insert into public.row(table_name,row_effected) values (v_class_name,SQL%ROWCOUNT);
	INSERT INTO public.procedure_log(end_table_name,end_proc_name,end_time,end_message) VALUES (v_class_name,v_source,current_timestamp::timestamp without time zone,SUBSTR(SQLERRM,1,200));





		EXCEPTION
			WHEN OTHERS THEN
			v_errorcode := SQLCODE;
			v_errortext := SUBSTR(SQLERRM, 1, 200);
			INSERT INTO error_log(generated_time, error_code, msg, source ,is_error)
			VALUES( current_timestamp,v_errorcode, v_errortext, v_source, 1::bit);





	end hr_insert_into_employee_project_mapping;
	-- end: insert into employee_project_mapping table --<
	-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

