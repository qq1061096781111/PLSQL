--任务计划:21 表名:TC_Name01_HsEmp01

--功能:对回收提成进行写表
CREATE OR REPLACE PROCEDURE V_Name01_HsEmp01_WRITE AS

BEGIN

  --本月计算上月数据,如果上月有数据,先清空一下上月的数据
  delete from TC_NAME01_HSEMP01
   WHERE date01 >= TRUNC(ADD_MONTHS(SYSDATE, -1), 'month')
     AND date01 <= TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1)));
  commit;

  --把计算出来的回收提成写入目标表
  INSERT INTO TC_Name01_HsEmp01
    (date01,
     date02,
     name01,
     Hsemp01,
     Hs_Num01,
     Amount01,
     Sale_Num01,
     Gjl01,
     Hsd01)
    select TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))-1) date01,
           to_char(add_months(trunc(sysdate), -1), 'yyyy-mm') || '月' date02,
           
           a.NAME01,
           a.HsEmp01,
           a.HS_NUM01,
           a.AMOUNT01,
           a.SALE_NUM01,
           a.GJL01,
           a.HSD01
    
      from V_Name01_HsEmp01 a;

  COMMIT;

END;
