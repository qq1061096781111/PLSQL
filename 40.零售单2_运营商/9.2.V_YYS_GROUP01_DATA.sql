
CREATE OR REPLACE VIEW V_YYS_GROUP01_DATA AS


with w1 as
 (
  
  select a.GROUP01, --地区分组:体验店,专卖店....
  
          sum(a.telecom_and_mobile_nx_num01) telecom_and_mobile_nx_num01, -- 完成数量:也就是移动和联通的
          
          sum(a.telecom_nx_num01) telecom_nx_num01, -- 电信的粘性销量
          sum(a.mobile_nx_num01) mobile_nx_num01, -- 移动的粘性销量
          sum(a.unicom_nx_num01) unicom_nx_num01, --联通粘性销量
          
          sum(a.two_SALES01) two_SALES01, -- 副卡销量
          sum(a.new_old_num01) new_old_num01, --移动户数
          sum(a.young_SALES01) young_SALES01, --青春卡销量
          
          sum(a.sale_num01) sale_num01 --主机销量
  
    from V_YYS_AREA01_DATA a --运营商地区的数据
  
   group by a.GROUP01
  
  )

select a.*,
       
       b.group_nx_task01,
       
       --组别的运营商完成率 =（电信＋移动）的粘性完成量 / 粘性任务
       round((CASE
               WHEN b.group_nx_task01 = 0 THEN
                1
               ELSE
                telecom_and_mobile_nx_num01 / b.group_nx_task01
             END),
             4) group_nx_wcl01, 
       

       --组别的运营商匹配率 = （电信+移动）的粘性完成量 / 主机销量
       round((CASE
               WHEN sale_num01 = 0 THEN
                0
               ELSE
                telecom_and_mobile_nx_num01 / sale_num01
             END),
             4) group_yys_ppl01, 
             

        -- 组别的青春卡任务
       b.group_yuang_task01,
       
       -- 组别的青春卡完成率
       round((CASE
               WHEN b.group_yuang_task01 = 0 THEN
                1
               ELSE
                young_SALES01 / b.group_yuang_task01
             END),
             4) group_young_wcl01,
       
       --组别的副卡搭载率
       round((CASE
               WHEN new_old_num01 = 0 THEN
                0
               ELSE
                TWO_SALES01 / new_old_num01
             END),
             4) two_per01
       

  from w1 a
  left join group_data b --在模块运营商里面的组别任务里面维护
    on a.GROUP01 = b.group01
