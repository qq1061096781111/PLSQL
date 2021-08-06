-- * 按人员汇总销量, 提成,  以及把相应的单号汇总 * --
CREATE OR REPLACE VIEW V_LSD_3_NAME01_DATA AS

SELECT NAME01,
       SUM(NUM01) num01, 
       sum(tvemp01) tvemp01,  --应该算的提成
       (listagg(lsd01, ',') within group(order by lsd01)) wm_lsd01  --汇总单号
       
  FROM V_LSD_3

 GROUP BY NAME01

