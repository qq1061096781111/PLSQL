--����ƻ�:3 ����:tc_NAME01_EMPTv01

CREATE OR REPLACE PROCEDURE V_NAME01_TvEmp01_EMP_WRITE AS

BEGIN

  --���¼�����������,�������������,�����һ�����µ�����
  delete from tc_NAME01_EMPTv01
   WHERE date01 >= TRUNC(ADD_MONTHS(SYSDATE, -1), 'month')
     AND date01 <= TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1)));
  commit;

  --�Ѽ�������Ļ������д��Ŀ���
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
           to_char(add_months(trunc(sysdate), -1), 'yyyy-mm') || '��' DATE02,
           name01, --����
           tvemp01,--�������
           num01,  --�ǻ�������
           area_num01,
           area_zhp_task01,
           is_area_dabiao01,
           emp_tc01,
           wm_lsd01 --���۵���
      from V_NAME01_TvEmp01_EMP a;

  COMMIT;

END;
