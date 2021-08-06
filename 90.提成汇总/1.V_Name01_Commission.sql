CREATE OR REPLACE VIEW V_Name01_Commission AS 

WITH W1 AS
 (
	
	select a.name01, a.hsemp01, 0 emp_tvemp01
		from TC_Name01_HsEmp01 a --������Աҵ����:(ͨ����ͼ:V_Name01_HsEmp01_WRITE  �ô洢����:V_Name01_HsEmp01_WRITE д�ı�)
	 WHERE date01 >= TRUNC(ADD_MONTHS(SYSDATE, -1), 'month')
		 AND date01 <= TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1)))
	
	union all
	
	select b.name01, 0, b.tvemp01
		from tc_NAME01_EMPTv01 b --�ǻ�����Աҵ����:(ͨ����ͼ:V_NAME01_TvEmp01_EMP  �ô洢����:V_NAME01_TvEmp01_EMP_WRITE д�ı�)
	 WHERE date01 >= TRUNC(ADD_MONTHS(SYSDATE, -1), 'month')
		 AND date01 <= TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1)))


	
	),

--------------------------------

w2 as
 (
	
	SELECT NAME01,
					SUM(HSEMP01) hsemp01,
					SUM(EMP_TVEMP01) emp_tvemp01
	
		FROM W1
	 GROUP BY NAME01
	
	)
  
-----------------------------------

select a.*, NVL(b.coeffi01,1) coeffi01
	from w2 a
	left join V_Name01_Coeffi01 b
		on a.name01 = b.name01
