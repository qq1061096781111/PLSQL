CREATE OR REPLACE VIEW V_LSD_3_NAME01_KOUFA01 AS

select a.area01,
			 a.group01, --体验店还是...
			 a.group02, --A  B店
			 a.area_zhp_task01, --智慧屏任务
			 
			 b.name01, --姓名
			 b.zhiwu01, --职务
			 b.OFFDATA01, --离职日期
			 b.ondata01, --入职日期
			 b.newname01, --是否新员工
			 
			 nvl(c.NUM01, 0) num01, -- 人员智慧屏销量
			 
			 (CASE
				 WHEN a.group02 = 'A' THEN --8.没有销售,A店的话扣200
					-200
				 WHEN group02 = 'B' THEN -- 9.没有销售, B店的话扣100
					-100
				 ELSE
					0 --否则的话就不扣
			 END) koufa01

	from zhp_area_task a --1. 门店先有任务,有任务的门店才会考核1台的量

	left join ryxx_upmonth b --2. 看这个地区下面有哪些人, 视图在下面,里面已经对人员的基本信息进行了筛选
		on a.area01 = b.area01

	left join V_LSD_3_NAME01_DATA c --3. 这些人的智慧屏销售数量是多少
		on b.name01 = c.NAME01

 where a.area01 in
			 (select area01 from V_LSD_3_AREA01_diff01 r where diff01 > 0) --4. 首先只有没有达成目标的地区才会有扣罚
       
	 and (c.NUM01 is null or c.num01 = 0) --5.0. 然后是只有销量为空的或者销售为 <= 0人员才扣罚(销售1台,退1台,销量就是0)
			
	 and b.name01 is not null; --7. 可能门店设置了任务,但是没有人员

--==========================================================================    

-- * 上个月最后一天的人员表 * --
CREATE OR REPLACE VIEW ryxx_upmonth AS
	select a.*, b.area_brand01
		from ryxx a
	
		left join areafl b -- 1. 地区和地区品牌对照
			on a.area01 = b.area01
	
	 where date01 = TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) --2. 取上个月最后一天的通讯录
				
		 and b.area_brand01 = '华为零售'    --3. 筛选华为零售的门店 
		 and a.zhiwu01 in ('专员', '主管/组长') --4.  专员主管才会扣罚
		 and a.newname01 = 0  --5. 且是老员工
