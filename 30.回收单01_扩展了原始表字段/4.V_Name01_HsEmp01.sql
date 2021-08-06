

CREATE OR REPLACE VIEW V_Name01_HsEmp01 AS  

select a.*, a.tc HsEmp01 -- hsemp01这个字段,取的就是tc这个字段,主要因为程序之前有这个字段 

from V_HSD_1_NAME01_Gjl01 a  
