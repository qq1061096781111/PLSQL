/*功能名称：大件、非团单人员大件销量表（排除了高德店）*/   

CREATE OR REPLACE VIEW V_LSD_1_NAME01_DATA AS

select a.name01, sum(a.not_td_sale_num01) sale_num01 --排除团单后，进行销售数量汇总
  from V_LSD_1 a
 group by a.name01

