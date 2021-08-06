--任务计划:61  表名:TC_NAME01_MANAGETv01

CREATE OR REPLACE PROCEDURE V_NAME01_TvEmp01_MANAGE_WRITE AS
BEGIN

  --本月计算上月数据,如果上月有数据,先清空一下上月的数据
  delete from TC_NAME01_MANAGETv01
   WHERE date01 >= TRUNC(ADD_MONTHS(SYSDATE, -1), 'month')
     AND date01 <= TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1)));
  commit;

  --把计算出来的回收提成写入目标表
  INSERT INTO TC_NAME01_MANAGETv01
    (date01,
     date02,
     name01,
     NUM01,
     JIANGLI01,
     KOUFA01,
     MANAGE_TC01,
     AREA_ZHP_TASK01,
     DIFF01)
  
    select TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))-1) DATE01,
           to_char(add_months(trunc(sysdate), -1), 'yyyy-mm') || '月' DATE02,
           a.name01,
           a.NUM01,
           a.JIANGLI01,
           a.KOUFA01,
           a.MANAGE_TC01,
           a.AREA_ZHP_TASK01,
           a.DIFF01
      from V_NAME01_TvEmp01_MANAGE a;

  COMMIT;

END;
