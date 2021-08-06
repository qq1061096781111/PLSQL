-- * 功能名称：查询大件的非团单的无高德店的销售明细表 * --

--TODO: 还需要剔除京东到家的主机,剔除方法业务部还要确认


CREATE OR REPLACE VIEW V_LSD_1 AS
select a.*,
       b.group01, --地区组别:分为专卖店,体验店等...
       -----------
       (case
         when (sum(a.num01) over(partition by a.lsd01)) >= 5 then
          0
         else
          a.num01
       end) not_td_sale_num01 --剔除团单销售数量

  from lsd a
  
  left join areafl b -- 关联地区组别,如专卖店,体验店等,不是回收组别,在全局配置中配置
  on a.area01 = b.area01

 where a.area01 != 'GD_hw7' -- 排除高德店
      
     and a.date01 >= TRUNC(ADD_MONTHS(SYSDATE, -1), 'month')
     and a.date01 <= TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) --筛选日期
      
   and exists (select r.spfl01
          from spfl r
         where a.spfl01 = r.spfl01
           and r.spfl02 = '大件') --筛选主产品:表spfl中定义了大件的具体类别,在全局配置中配置
   
   and exists (select S.AREA01 from areafl s where a.area01=s.area01 and s.area_brand01='华为零售')
