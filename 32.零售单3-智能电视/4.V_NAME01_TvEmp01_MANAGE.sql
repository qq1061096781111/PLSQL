
-- * 计算店长智慧屏的业绩  * --

CREATE OR REPLACE VIEW V_NAME01_TvEmp01_MANAGE AS


WITH W1 AS
 (
	
	select a.*, diff01 * (-50) koufa01 --2.  计算未达标的扣罚, 按50一台扣罚金额
	
		from V_LSD_3_AREA01_diff01 a
	
	)

-------------------------------

select a.*,
			 
			 a.jiangli01 + a.koufa01 manage_tc01, --1. 门店奖励＋扣罚=门店提成
			 
			 t.name01 --3. 要看下门店对应店长是谁

	from W1 a

	left JOIN ryxx_hwmanage t --4. 关联华为店长的视图,华为店长的视图在下面
		ON a.area01 = t.area01

 where name01 is not null;

--=======================================================================================================

-- * 华为零售的店长视图 * --
CREATE OR REPLACE VIEW ryxx_hwmanage AS

--第一步:把华为的在职店长筛选出来,使用的是上个月最后一天的通讯录
	with w1 as
	 (
		
		select a.*, b.area_brand01
			from ryxx a
		
			left join areafl b -- 1. 地区和地区品牌对照
				on a.area01 = b.area01
		
		 where date01 = TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) --2. 取上个月最后一天的通讯录
					
			 and b.area_brand01 = '华为零售' --3. 筛选华为零售的门店
					
			 and zhiwu01 = '店长' --4. 职位是店长
			 and iswork01 = 1 --5. 在职的华为店面店长
		)
	--第二步: 一个点存在多个在职店长, 取在职日期比较早的店长
	select a.*
		from w1 a
	 where not exists (select *
						from w1 b
					 where b.AREA01 = a.AREA01 --如果地区重复
						 --and a.zhiwu01 = b.zhiwu01
						 and b.ONDATA01 < a.ONDATA01); --6. 取入职日期早的店长



--------------------------------------------
 

























