--任务计划:3 表名:tc_NAME01_EMPTv01

CREATE OR REPLACE PROCEDURE V_NAME01_TvEmp01_EMP_WRITE AS

BEGIN

  --本月计算上月数据,如果上月有数据,先清空一下上月的数据
  delete from tc_NAME01_EMPTv01
   WHERE date01 >= TRUNC(ADD_MONTHS(SYSDATE, -1), 'month')
     AND date01 <= TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1)));
  commit;

  --把计算出来的回收提成写入目标表
  INSERT INTO tc_NAME01_EMPTv01
    (date01,
     date02,
     name01,
     TVemp01,
     Num01,
     AREA_NUM01,
     AREA_ZHP_TASK01,
     is_area_dabiao01,
     EMP_TC01,
     WM_LSD01)
  
    select TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))-1) DATE01,
           to_char(add_months(trunc(sysdate), -1), 'yyyy-mm') || '月' DATE02,
           name01, --姓名
           tvemp01,--销量提成
           num01,  --智慧屏销量
           area_num01,
           area_zhp_task01,
           is_area_dabiao01,
           emp_tc01,
           wm_lsd01 --零售单号
      from V_NAME01_TvEmp01_EMP a;

  COMMIT;

END;
