CREATE OR REPLACE VIEW V_LSD_1_GROUP01_DATA AS

select A.group01, sum(a.not_td_sale_num01) sale_num01 --�ų��ŵ��󣬽���������������
  from V_LSD_1 a
 group by A.group01
