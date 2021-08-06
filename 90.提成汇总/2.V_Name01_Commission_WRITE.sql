--任务计划:44  表名:select * from tc_Name01_Commission

CREATE OR REPLACE PROCEDURE V_Name01_Commission_WRITE AS -- 存出过程名称

BEGIN

  --1.本月计算上月数据,如果上月有数据,先清空一下上月的数据
  DELETE from tc_Name01_Commission
   WHERE date01 >= TRUNC(ADD_MONTHS(SYSDATE, -1), 'month')
     AND date01 <= TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1)));
  commit;

  --2.写表
  INSERT INTO tc_Name01_Commission(
     date01,
     date02,
       name01,
       hsemp01,
       emp_tvemp01,
       coeffi01
     
     
     )
  
select TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1)) - 1) date01,
			 to_char(add_months(trunc(sysdate), -1), 'yyyy-mm') || '月' date02,
			 
			 a.name01,
			 a.hsemp01,
			 a.emp_tvemp01,
			 a.coeffi01

	from V_Name01_Commission a;

COMMIT;

END;
