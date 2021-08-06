--����ƻ�:44  ����:select * from tc_Name01_Commission

CREATE OR REPLACE PROCEDURE V_Name01_Commission_WRITE AS -- �����������

BEGIN

  --1.���¼�����������,�������������,�����һ�����µ�����
  DELETE from tc_Name01_Commission
   WHERE date01 >= TRUNC(ADD_MONTHS(SYSDATE, -1), 'month')
     AND date01 <= TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1)));
  commit;

  --2.д��
  INSERT INTO tc_Name01_Commission(
     date01,
     date02,
       name01,
       hsemp01,
       emp_tvemp01,
       coeffi01
     
     
     )
  
select TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1)) - 1) date01,
			 to_char(add_months(trunc(sysdate), -1), 'yyyy-mm') || '��' date02,
			 
			 a.name01,
			 a.hsemp01,
			 a.emp_tvemp01,
			 a.coeffi01

	from V_Name01_Commission a;

COMMIT;

END;
