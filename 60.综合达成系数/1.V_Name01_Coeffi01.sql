--计算人员的综合达成系数

CREATE OR REPLACE VIEW V_Name01_Coeffi01 AS 

--拼接成要人员要考核的指标相关的字段: 人员姓名,垫底人员名单,所属地区,人员笔算赦免, 人员跟机率跟机率,人员的加单率, 地区的粘性完成率,地区的回收完成率
with t2 as
 (select a.name01,
				 a.area01, --人员所在地区  
				 
				 c.pk_gjl01, -- 匹配跟机率是否达标(1,0)
				 h.PK_PPL01, -- 匹配人员匹配率是否达标(1,0)
				 
				 g.is_area_hs_dabiao01, -- 地区的回收量是否达标(1,0)
				 b.is_area_yys_dabiao01, -- 地区的运营商是否达标(1,0)
				 
				 k.name01 low_name01, -- 垫底人员名单,业务部维护, 可以考虑算出写表
         
				 --综合完成率的计算                              
				 ROUND(nvl((CASE
										 WHEN h.RYXX_YYS_PPL01 > 0.3 THEN
											0.3
										 ELSE
											h.ryxx_yys_ppl01
									 END),
									 0) * 0.5 / 0.25 +
							 nvl((CASE
										 WHEN c.GJL01 > 0.324 THEN
											0.324
										 ELSE
											c.GJL01
									 END),
									 0) * 0.5 / 0.27,
							 4) ZH_WCL01
	
		from ryxx_emp a -- 要核算系数的人员
	
		left join V_HSD_1_NAME01_GJL01 c -- 匹配个人跟机率是否达到要求:跟机率>=0.28,则达到要求
			on a.NAME01 = c.NAME01
	
		left join V_YYS_NAME01_DATA h    -- 匹配个人运营商匹配率是否达标:匹配率>=0.22
			on a.name01 = h.NAME01
	
		left join V_PK_HS_TASK_AREA g    --匹配门店是否完回收任务:用门店的回收量和设置的门店回收任务做比较
			on a.area01 = g.area01
	
		left join V_PK_YYS_TASK_AREA b   --匹配门店是否完成运营商任务
			on a.area01 = b.area01
	
		LEFT JOIN RYSD_LOW k -- 匹配是否为垫底人员
			on a.name01 = k.name01
	
	)

--计算垫底人员和非垫底人员的系数: 对于垫底人员,判断的指标是笔算赦免 和 加单率, 对于非垫底人员,考核的是人员的运营商匹配率和地区的粘性完成率    
select t2.*,
			 
			 (CASE
				 WHEN low_name01 is null THEN
					(CASE
						WHEN (is_area_hs_dabiao01 = 1 and pk_gjl01 = 1) and
								 (is_area_yys_dabiao01 = 1 and PK_PPL01 = 1) THEN
						 1.2
					
						ELSE
						
						 (CASE
							 WHEN (is_area_hs_dabiao01 = 1 and pk_gjl01 = 1) or
										(is_area_yys_dabiao01 = 1 and PK_PPL01 = 1) THEN
								1.1
							 ELSE
								1
						 END)
					
					END)
				 ELSE
					(CASE
						WHEN low_name01 is not null THEN
						 0.8
						ELSE
						 1
					
					END)
			 END)
			 
			 coeffi01

	from t2;

--==================================================================================           

--华为零售,上上个月最后一天未离职的所有人员: 用在综合达成系数上面
CREATE OR REPLACE VIEW ryxx_emp AS
	select a.*, b.area_brand01
		from ryxx a
		left join areafl b
			on a.area01 = b.area01
	
	 where date01 = TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) --上月最后一天人员所在店面
		 and b.area_brand01 = '华为零售'
