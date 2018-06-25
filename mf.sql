SELECT DISTINCT eom.office_info_id as  "officeInfoId" FROM
(SELECT employee_info_id,office_info_id FROM employee_office_mapping WHERE employee_info_id=${employeeInfo.id}) as eom
INNER JOIN
(

SELECT id,office_name,office_ref_code,office_type_id,mf_branch_id FROM public.physical_office_info 
	WHERE mf_branch_id not like 'MF%' and office_ref_code not like 'MF%' and mf_branch_id is not null --1941
intersect 
SELECT id,office_name,office_ref_code,office_type_id,mf_branch_id FROM public.physical_office_info 
	WHERE office_ref_code not like 'MF%' and mf_branch_id is null --2888

union
SELECT id,office_name,office_ref_code,office_type_id,mf_branch_id FROM public.physical_office_info 
WHERE office_ref_code like 'MF%' and mf_branch_id like 'MF%'
) as o on (eom.office_info_id=o.id) ORDER BY office_info_id;


SELECT id,office_name,office_ref_code,office_type_id,mf_branch_id,mf_ref_code FROM public.physical_office_info WHERE mf_ref_code='Common Branch' and office_type_id=5;
SELECT id,office_name,office_ref_code,office_type_id,mf_branch_id,mf_ref_code FROM public.physical_office_info WHERE office_type_id=5;
SELECT id,office_name,office_ref_code,office_type_id,mf_branch_id,mf_ref_code FROM public.physical_office_info WHERE office_type_id=4;
SELECT id,office_name,office_ref_code,office_type_id,mf_branch_id,mf_ref_code FROM public.physical_office_info WHERE office_type_id=3;
SELECT id,office_name,office_ref_code,office_type_id,mf_branch_id,mf_ref_code FROM public.physical_office_info WHERE office_type_id=2;
SELECT id,office_name,office_ref_code,office_type_id,mf_branch_id,mf_ref_code FROM public.physical_office_info WHERE office_type_id=1;

SELECT count(mf_branch_id) FROM public.physical_office_info WHERE mf_ref_code='Common Branch';--1940
SELECT distinct mf_branch_id FROM public.physical_office_info WHERE mf_ref_code='Common Branch';
SELECT id,office_name,office_ref_code,office_type_id,mf_branch_id,mf_ref_code FROM public.physical_office_info 
WHERE mf_ref_code='Common Branch' and mf_branch_id is null; --2314
select * from bracdb.hr_and_mf_branch_code where branchid='2326';
select * from bracdb.hr_and_mf_branch_code where branchid='18';

--------------------------

select * from feature_controller_mapping where feature_action_id in (select id from feature_action  where feature_info_id in (select id from feature_info where module_info_id = 2))
select * from feature_action  where feature_info_id in (select id from feature_info where module_info_id = 2)
select * from feature_info where module_info_id = 2


SELECT id,office_name,office_ref_code,office_type_id,mf_branch_id FROM public.physical_office_info 
	WHERE mf_branch_id not like 'MF%' and office_ref_code not like 'MF%' and mf_branch_id is not null --1941


SELECT id,office_name,office_ref_code,office_type_id,mf_branch_id,mf_ref_code FROM public.physical_office_info where office_ref_code like 'MF%'
union
SELECT id,office_name,office_ref_code,office_type_id,mf_branch_id,mf_ref_code FROM public.physical_office_info where office_ref_code not like 'MF%'
	

SELECT id FROM public.physical_office_info where office_ref_code like 'MF%'
union all
SELECT id FROM public.physical_office_info where office_ref_code not like 'MF%'



SELECT id,office_name,office_ref_code,office_type_id,mf_branch_id,mf_ref_code FROM public.physical_office_info where office_ref_code not like 'MF%' and id not in
(
SELECT id FROM public.physical_office_info 
	WHERE mf_branch_id not like 'MF%' and office_ref_code not like 'MF%'
)	

id	office_name	office_ref_code	office_type_id	mf_branch_id	mf_ref_code
2487	Sherpur HR Office	4078	3		
3127	Madarsi		2326		5				Common Branch
