/*功能名称：人员跟机率对照表+  */

-- * 计算跟机率,以及是否跟机率>=28% 是的话就说明达标了 * --
CREATE OR REPLACE VIEW V_HSD_1_NAME01_GJL01 AS

WITH T1 AS
 (select a.*,
         
         b.sale_num01, --人员对应的主机销量
         
         round(a.hs_num01 / (case
                 when b.sale_num01 = 0 then
                  a.hs_num01 / 0.28
                 else
                  b.sale_num01
               end),
               2) gjl01 -- 回收数量/主机销量，当主机数量为0，跟机率默认28%
  
    FROM V_HSD_1_NAME01_DATA a --回收单人员数据
  
    LEFT JOIN V_LSD_1_NAME01_DATA b --零售单人员主机销量表
      on a.name01 = b.name01
  
  
  )

------------------------------------------------------------------------------------------------------------------
select t1.*,
       (case
         when gjl01 >= 0.28 then
          1
         else
          0
       end) pk_gjl01 --pk跟几率，个人跟机率>=28%为1,表示达标，否则为0
  from t1
