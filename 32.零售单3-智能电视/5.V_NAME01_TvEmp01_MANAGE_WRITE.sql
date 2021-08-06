--����ƻ�:61  ����:TC_NAME01_MANAGETv01

CREATE OR REPLACE PROCEDURE V_NAME01_TvEmp01_MANAGE_WRITE AS
BEGIN

  --���¼�����������,�������������,�����һ�����µ�����
  delete from TC_NAME01_MANAGETv01
   WHERE date01 >= TRUNC(ADD_MONTHS(SYSDATE, -1), 'month')
     AND date01 <= TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1)));
  commit;

  --�Ѽ�������Ļ������д��Ŀ���
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
           to_char(add_months(trunc(sysdate), -1), 'yyyy-mm') || '��' DATE02,
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
