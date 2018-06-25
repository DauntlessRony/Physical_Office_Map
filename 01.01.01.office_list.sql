select * from public.physical_office_info limit 10;

--type 2

select office_ref_code as hr_office_ref_code,office_name as hr_office_name
,(select office_ref_code from physical_office_info where id=parent_office_id) as hr_parent_office_ref_code
,(select office_name from physical_office_info where id=parent_office_id) as hr_parent_office_name
,is_hr_office,is_upazila_accounts_office
from public.physical_office_info where office_type_id=2 order by 2;


--type 3

select office_ref_code as hr_office_ref_code,office_name as hr_office_name
,(select office_ref_code from physical_office_info where id=parent_office_id) as hr_parent_office_ref_code
,(select office_name from physical_office_info where id=parent_office_id) as hr_parent_office_name
,is_hr_office,is_upazila_accounts_office
from public.physical_office_info where office_type_id=3 order by 2;

--type 4

select office_ref_code as hr_office_ref_code,office_name as hr_office_name
,(select office_ref_code from physical_office_info where id=parent_office_id) as hr_parent_office_ref_code
,(select office_name from physical_office_info where id=parent_office_id) as hr_parent_office_name
,is_hr_office,is_upazila_accounts_office
from public.physical_office_info where office_type_id=4 order by 2;

--type 5

select office_ref_code as hr_office_ref_code,office_name as hr_office_name
,(select office_ref_code from physical_office_info where id=parent_office_id) as hr_parent_office_ref_code
,(select office_name from physical_office_info where id=parent_office_id) as hr_parent_office_name
,is_hr_office,is_upazila_accounts_office
from public.physical_office_info where office_type_id=5 order by 2;