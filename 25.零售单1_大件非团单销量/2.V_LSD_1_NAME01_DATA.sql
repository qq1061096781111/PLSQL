/*�������ƣ���������ŵ���Ա����������ų��˸ߵµ꣩*/   

CREATE OR REPLACE VIEW V_LSD_1_NAME01_DATA AS

select a.name01, sum(a.not_td_sale_num01) sale_num01 --�ų��ŵ��󣬽���������������
  from V_LSD_1 a
 group by a.name01

