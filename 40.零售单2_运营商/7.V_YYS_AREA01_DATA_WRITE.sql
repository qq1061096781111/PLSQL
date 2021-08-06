CREATE OR REPLACE PROCEDURE V_YYS_AREA01_DATA_WRITE AS -- 存出过程名称

BEGIN

  --1.本月计算上月数据,如果上月有数据,先清空一下上月的数据
  DELETE from TC_YYS_AREA01_DATA
   WHERE date01 >= TRUNC(ADD_MONTHS(SYSDATE, -1), 'month')
     AND date01 <= TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1)));
  commit;

  --2.写表
  INSERT INTO TC_YYS_AREA01_DATA
    (date01,
     date02,
     
     AREA01,
     NX_NUM01,
     TELECOM_NX_NUM01,
     MOBILE_NX_NUM01,
     UNICOM_NX_NUM01,
     TELECOM_AND_MOBILE_NX_NUM01,
     TWO_SALES01,
     NEW_OLD_NUM01,
     YOUNG_SALES01,
     GROUP01,
     AREA_YYS_TASK01,
     AREA_NX_WCL01,
     AREA_YUANG_TASK01,
     AREA_YOUNG_WCL01,
     AREA_YYS_PPL01,
     TWO_PER01,
     AREA_KH_YYS01,
     SALE_NUM01,
     moble_two_per01
     
     )
  
    select TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))-1) date01,
           to_char(add_months(trunc(sysdate), -1), 'yyyy-mm') || '月' date02,
           
           a.AREA01,
           a.NX_NUM01,
           a.TELECOM_NX_NUM01,
           a.MOBILE_NX_NUM01,
           a.UNICOM_NX_NUM01,
           a.TELECOM_AND_MOBILE_NX_NUM01,
           a.TWO_SALES01,
           a.NEW_OLD_NUM01,
           a.YOUNG_SALES01,
           a.GROUP01,
           a.AREA_YYS_TASK01,
           a.AREA_NX_WCL01,
           a.AREA_YUANG_TASK01,
           a.AREA_YOUNG_WCL01,
           a.AREA_YYS_PPL01,
           a.TWO_PER01,
           a.AREA_KH_YYS01,
           a.SALE_NUM01,
           a.moble_two_per01
    
      from V_YYS_AREA01_DATA a;

  COMMIT;

END;
