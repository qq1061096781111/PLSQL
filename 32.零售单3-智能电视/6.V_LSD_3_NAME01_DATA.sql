-- * ����Ա��������, ���,  �Լ�����Ӧ�ĵ��Ż��� * --
CREATE OR REPLACE VIEW V_LSD_3_NAME01_DATA AS

SELECT NAME01,
       SUM(NUM01) num01, 
       sum(tvemp01) tvemp01,  --Ӧ��������
       (listagg(lsd01, ',') within group(order by lsd01)) wm_lsd01  --���ܵ���
       
  FROM V_LSD_3

 GROUP BY NAME01

