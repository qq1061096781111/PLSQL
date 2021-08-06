/*功能名称：销售人员智慧屏提成*/

CREATE OR REPLACE VIEW V_NAME01_TvEmp01_EMP AS

select h.NAME01,
			 h.NUM01,
			 h.TVEMP01,
			 h.WM_LSD01,
			 
			 null area_num01,
			 null area_zhp_task01,
			 null is_area_dabiao01,
			 null emp_tc01

	from V_LSD_3_NAME01_DATA h
 where h.NUM01 != 0

union all

select j.name01, j.num01, j.koufa01, null wm_lsd01, null, null, null, null
	from V_LSD_3_NAME01_KOUFA01 j
