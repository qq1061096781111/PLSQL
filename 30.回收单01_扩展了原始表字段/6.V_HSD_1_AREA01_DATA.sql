-- �ŵ������������ͳ��

CREATE OR REPLACE VIEW V_HSD_1_AREA01_DATA AS 
select area01, sum(hs_num01) hs_num01
 from V_HSD_1 a
 group by area01
 
