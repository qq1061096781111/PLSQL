--1.�½�һ������Ϊ  ��ͼ����_WRITE ��Sql�ļ�
--2.Ҫд�����ͼ��: V_YYS_AREA01_DATA
--3.�����滻:����"��ͼ����"�滻Ϊ��2������ͼ
--4.�����滻:����"����ı���"�滻Ϊ����ͼ����ǰ���V�޸�ΪTC
--5.������ͼ�������ֶ�
--6.�������ƻ�

--����ƻ�:41


CREATE OR REPLACE PROCEDURE V_YYS_GROUP01_DATA_WRITE AS -- �����������

BEGIN

  --1.���¼�����������,�������������,�����һ�����µ�����
  DELETE from TC_YYS_GROUP01_DATA
   WHERE date01 >= TRUNC(ADD_MONTHS(SYSDATE, -1), 'month')
     AND date01 <= TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1)));
  commit;

  --2.д��
  INSERT INTO TC_YYS_GROUP01_DATA(
     date01,
     date02,
     
            GROUP01,
       TELECOM_AND_MOBILE_NX_NUM01,
       TELECOM_NX_NUM01,
       MOBILE_NX_NUM01,
       UNICOM_NX_NUM01,
       TWO_SALES01,
       NEW_OLD_NUM01,
       YOUNG_SALES01,
       SALE_NUM01,
       group_nx_task01,
       group_nx_wcl01,
       group_yys_ppl01,
       group_yuang_task01,
       group_young_wcl01,
       two_per01

     
     )
  
    select TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))-1) date01,
           to_char(add_months(trunc(sysdate), -1), 'yyyy-mm') || '��' date02,
           
a.GROUP01,
a.TELECOM_AND_MOBILE_NX_NUM01,
a.TELECOM_NX_NUM01,
a.MOBILE_NX_NUM01,
a.UNICOM_NX_NUM01,
a.TWO_SALES01,
a.NEW_OLD_NUM01,
a.YOUNG_SALES01,
a.SALE_NUM01,
a.group_nx_task01,
a.group_nx_wcl01,
a.group_yys_ppl01,
a.group_yuang_task01,
a.group_young_wcl01,
a.two_per01

    
      from V_YYS_GROUP01_DATA a;

  COMMIT;

END;
