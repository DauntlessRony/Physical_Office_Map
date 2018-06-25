select * from bracdb.physical_office_info where pin='00110502';
branch_name
Bahubal
branch_code
0493

select id,office_name,office_ref_code,mf_branch_id,reporting_to_id,office_type_id from physical_office_info 
	where office_name like 'Bahubal' and office_type_id=5;
id	office_name	office_ref_code	mf_branch_id	office_type_id
7014	Dhaka -1	MF7014	MF7014	3

select id,employee_name,pin_no,office_info_id from employee_core_info where pin_no='00104584';
id	employee_name	pin_no	office_info_id
19824	Abdul Kadir	00104584	1049

select id,office_name,office_ref_code,mf_branch_id,office_type_id from physical_office_info where id=1049;


select employee_info_id,office_info_id from employee_office_mapping limit 10;

select employee_info_id,office_info_id from employee_office_mapping where employee_info_id=19824 and office_info_id=1049;
select * from physical_office_info where id=7014;

---------------------------------------------------------------------------------------------------------
--################## mf_and_hr_ref_code_inconsistence,so reporting_to_id is null start

select id,office_name,office_ref_code,mf_branch_id,reporting_to_id,office_type_id,mf_ref_code from physical_office_info --comm=4254
	where mf_ref_code='Common Branch';

select id,office_name,office_ref_code,mf_branch_id,reporting_to_id,office_type_id,mf_ref_code from physical_office_info --mf=1395
	where office_ref_code like 'MF%';

select id,office_name,office_ref_code,mf_branch_id,reporting_to_id,office_type_id,mf_ref_code from physical_office_info --tot=5648
		where mf_ref_code='Common Branch' or office_ref_code like 'MF%';

select id,office_name,office_ref_code,mf_branch_id,reporting_to_id,office_type_id,mf_ref_code from physical_office_info --tot=2382
		where (mf_ref_code='Common Branch' or office_ref_code like 'MF%') and reporting_to_id is null and id=1493 order by 2 ;
		
id	office_name	office_ref_code	mf_branch_id	reporting_to_id	office_type_id	mf_ref_code
1493	Dhanpur		2052		4113				5		Common Branch	

select * from bracdb.physical_office_info where branch_code='4113';
select * from bracdb.physical_office_info where lower(branch_name) like '%dhanp%';
select * from bracdb.hr_and_mf_branch_code where branchID=2052;


select * from bracdb.physical_office_info where lower(branch_name) like '%bagatipara%';

--################## mf_and_hr_ref_code_inconsistence,so reporting_to_id is null start