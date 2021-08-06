--计算地区运营商的指标

CREATE OR REPLACE VIEW V_YYS_AREA01_DATA AS

--第一步:计算出地区的粘性完成率, 地区的青春卡完成率,  地区的粘性匹配率, 地区的副卡搭载率
with T1 AS
 (select a.*,
 
         c.group01, --门店分为体验店,专卖店,综合店这样
 
         b.area_yys_task01, --粘性任务
         
         --地区的粘性完成率 = （电信＋移动）的粘性完成 / 地区的运营商任务          
         round((CASE
                 WHEN b.area_yys_task01 = 0 THEN
                  1
                 ELSE
                  telecom_and_mobile_nx_num01 / b.area_yys_task01
               END),
               4) area_nx_wcl01,
                         
         --地区青春卡任务
         b.area_yuang_task01,  
         
         --地区青春卡完成率 = 青春卡销量 / 地区青春卡任务
         round((CASE
                 WHEN b.area_yuang_task01 = 0 THEN
                  1
                 ELSE
                  young_SALES01 / b.area_yuang_task01
               END),
               4) area_young_wcl01, 
         
          --地区粘性匹配率=(电信+移动)的粘性销量 / 主机销量
         round((CASE
                 WHEN d.sale_num01 = 0 THEN
                  0
                 ELSE
                  telecom_and_mobile_nx_num01 / d.sale_num01
               END),
               4) area_yys_ppl01,
         
         --副卡搭载率=副卡销量/凡是备注了购机补贴的移动卡数量
         round((CASE
                 WHEN new_old_num01 = 0 THEN
                  0
                 ELSE
                  a.TWO_SALES01 / new_old_num01
               END),
               4) two_per01, 
         
         --地区考核的运营商,也就是说指定地区是做移动还是联通
         c.area_kh_yys01, 
         
         --门店主机销量
         d.sale_num01 
  
    from V_LSD_2_AREA01_DATA a -- 按地区汇总了运营商的销售数据
  
    left join area_yys_task b -- 运营商任务表,有粘性任务和青春卡任务,计算粘性完成率,青春卡完成率
      on a.AREA01 = b.area01
  
    left join areafl c --地区和地区要考核的运营商做对照,用来计算移动的副卡搭载率
      on a.AREA01 = c.area01
  
    left join V_LSD_1_AREA01_DATA d -- 地区大件销量,排除了团单的,用来计算匹配率的
      on a.AREA01 = d.area01)



--第二步:根据门店考核某个运营商,加入移动副卡的搭载率, 因为电信也卖副卡
select T1.*,
       (CASE
         WHEN area_kh_yys01 = '移动' THEN
          two_per01
         ELSE
          0
       END) moble_two_per01 --移动副卡搭载率

  FROM T1
