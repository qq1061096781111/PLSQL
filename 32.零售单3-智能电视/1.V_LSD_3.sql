-- * 智慧屏销售的一个明细数据 * --

CREATE OR REPLACE VIEW V_LSD_3 AS

 select a.*,
				b.ppid_tc_price01, --5. 匹配PPID的提成单价
        
				a.num01 * b.ppid_tc_price01 TvEmp01 --6. 计算提成金额
 
	 from lsd a
 
	 LEFT JOIN zhp_product b
		 on a.ppid01 = b.ppid01
 
	where area01 != 'GD_hw7' -- 4. 排除高德店
  
		and date01 >= TRUNC(ADD_MONTHS(SYSDATE, -1), 'month')  --1.筛选零售单, 上个月第一天到最后一天
		and date01 <= TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) 
			 
		and exists (select *
					 from spfl e1
					where a.spfl01 = e1.spfl01
						and e1.spfl01 = '智能电视') --2.筛选产品分类为智能电视的
            
		and exists (select s.area01
					 from areafl s
					where a.area01 = s.area01
						and s.area_brand01 = '华为零售') --3.只使用华为零售门店
