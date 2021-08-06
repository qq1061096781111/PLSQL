--����ƻ�:  42  ����:SELECT * FROM TC_Name01_Coeffi01

CREATE OR REPLACE PROCEDURE V_Name01_Coeffi01_WRITE AS

BEGIN

  --���¼�����������,�������������,�����һ�����µ�����
  delete from TC_Name01_Coeffi01
   WHERE date01 >= TRUNC(ADD_MONTHS(SYSDATE, -1), 'month')
     AND date01 <= TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1)));
  commit;

  --�Ѽ�������Ļ������д��Ŀ���
  INSERT INTO TC_Name01_Coeffi01
    (date01,
     date02,
     NAME01,
     LOW_NAME01,
     
     PK_GJL01,
     IS_AREA_HS_DABIAO01,
     
     PK_PPL01,
     IS_AREA_YYS_DABIAO01,
     
     ZH_WCL01,
     
     coeffi01)
  
    select TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) DATE01,
           to_char(add_months(trunc(sysdate), -1), 'yyyy-mm') || '��' DATE02,
           a.NAME01,
           a.LOW_NAME01,
           a.PK_GJL01,
           a.IS_AREA_HS_DABIAO01,
           
           a.PK_PPL01,
           a.IS_AREA_YYS_DABIAO01,
           
           a.ZH_WCL01,
           
           a.coeffi01
      from V_Name01_Coeffi01 a;

  COMMIT;

END;
