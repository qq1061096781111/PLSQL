--地区的回收任务和地区的回收量进行比较,确定是否达标
CREATE OR REPLACE VIEW V_PK_HS_TASK_AREA AS

SELECT a.area01,
			 
			 a.area_hs_task01, -- 回收任务
			 
			 b.hs_num01, -- 回收数量
			 
			 (CASE
				 WHEN b.hs_num01 >= a.area_hs_task01 THEN -- 比较回收数量和回收任务
					1 --赢了就是1
				 ELSE
					0
			 END) is_area_hs_dabiao01

	FROM area_hs_task a
	LEFT JOIN V_HSD_1_AREA01_DATA b
		ON a.area01 = b.area01
