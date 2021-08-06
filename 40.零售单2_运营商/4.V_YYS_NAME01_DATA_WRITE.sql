--����ƻ�:41.  ����:TC_YYS_NAME01_DATA

  --�ڶ���:�����������
CREATE OR REPLACE PROCEDURE V_YYS_NAME01_DATA_WRITE AS -- �����������

BEGIN

  --1.���¼�����������,�������������,�����һ�����µ�����
  DELETE from TC_YYS_NAME01_DATA
   WHERE date01 >= TRUNC(ADD_MONTHS(SYSDATE, -1), 'month')
     AND date01 <= TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1)));
  commit;

  --2.д��
  INSERT INTO TC_YYS_NAME01_DATA
    (date01,
     date02,
     
     NAME01,
     RYXX_NX_TASK01,
     TELECOM_AND_MOBILE_NX_NUM01,
     SALE_NUM01,
     RYXX_YYS_PPL01,
     RYXX_NX_WCL01,
     PK_PPL01)
  
    select TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))-1) date01,
           to_char(add_months(trunc(sysdate), -1), 'yyyy-mm') || '��' date02,
           
           a.NAME01,
           a.RYXX_NX_TASK01,
           a.TELECOM_AND_MOBILE_NX_NUM01,
           a.SALE_NUM01,
           a.RYXX_YYS_PPL01,
           a.RYXX_NX_WCL01,
           a.PK_PPL01
    
      from V_YYS_NAME01_DATA a;

  COMMIT;

END;
