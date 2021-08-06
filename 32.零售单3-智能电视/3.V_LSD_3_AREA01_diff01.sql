-- * 地区设置了任务,要计算出门店没有完成的数量 * --
CREATE OR REPLACE VIEW V_LSD_3_AREA01_diff01 AS


 SELECT a.area01,
				a.area_zhp_task01, --3. 地区任务
				nvl(b.NUM01, 0) num01, --4. 地区智慧屏销量
				
				(CASE
					WHEN (area_zhp_task01 - nvl(b.NUM01, 0)) > 0 THEN
					 (area_zhp_task01 - nvl(b.NUM01, 0))
					ELSE
					 0
				END) diff01, --5. 任务 - 销量 = 任务差量 > 0 的话,说明没有完成任务, 显示未完成数量;   否则就是0  代表完成了任务
				
				nvl(b.NUM01, 0) * 50 jiangli01 --6. 顺便算下销量对应的提成,就是店长的提成
 
	 FROM zhp_area_task a --1. 门店的智慧屏任务量(锁定门店用)
 
	 LEFT JOIN V_LSD_3_AREA01_DATA b --2. 门店的智慧屏销量
		 on a.area01 = b.AREA01
