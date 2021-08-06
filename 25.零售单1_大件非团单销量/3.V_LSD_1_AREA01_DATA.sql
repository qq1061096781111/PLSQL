CREATE OR REPLACE VIEW V_LSD_1_AREA01_DATA AS

select A.AREA01, sum(a.not_td_sale_num01) sale_num01 
  from V_LSD_1 a
 group by a.AREA01
   
--注: 这里的数量是排除了团单后的数量, 需要注意下
