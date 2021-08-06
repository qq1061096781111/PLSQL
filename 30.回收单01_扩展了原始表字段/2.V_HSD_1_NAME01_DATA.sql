/*功能：透视回收单，维度：姓名，组别跟随；数据：4%提成，2%提成，数量汇总**************

业务逻辑：把组别为空的筛选掉，里面的人都要算回收提成

***********************************************************************/


CREATE OR REPLACE VIEW V_HSD_1_NAME01_DATA AS 
select name01,sum(AMOUNT01) amount01, sum(hs_num01) hs_num01, sum(tc) tc, (listagg( HSD01, ',') within group(order by HSD01)) hsd01
  from V_HSD_1 a
 group by name01
 
 

