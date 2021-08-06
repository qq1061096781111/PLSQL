--功能名称：运营商销售明细表

--门店分为广州和佛山(其他地区也定义为佛山),广州和佛山事先定义好对应产品的系数如, 如 a产品,广州的销量系数是0.3,
--当广州的门店在销售a产品的时候,会把a产品的号码写到备注里面, 使用的销量系数为0.3, 佛山的门店销售a产品销量系数可能是另外一个
--0.3的叫法我们叫做粘性0.3  也就是说要卖3个多这样的产品,算1个粘性销量


CREATE OR REPLACE VIEW V_LSD_2 AS

--第一步: 提取零售单备注当中的不同类别的号码
--包括三列: 1.phone01指开了号码就算； 2.yuang_phone01指phone01当中的青春卡；  3.two_phone01独立于前两个的副卡

with T1 AS
 (select a.*,
				 
				 b.Group01, --门店的大区: 如体验店, 专卖店这样的
				 b.is_old01, --店面是广州店还是佛山店(其他地区也标识为佛山了),后面的代码会根据他判断,如果是广州店,销量系数用的是广州的系数,如果是其他的用的是佛山的系数
				 
				 c.ppid_class01, --产品类型,是电信还是联通还是移动,和商品类别要区分开来,商品类别是 大类,配件的一些分类
				 c.ppid_gz_nx01, --广州的店铺适用的粘性:理解为销售数量的系数,用来给销售数量打折,例如销售了1个卡,但是这个卡粘性为0.3,那么相当于销售了0.3个卡
				 c.ppid_fs_nx01, --佛山地区适用的粘性
				 
				 --以11位数字写在备注当中的
				 regexp_substr(translate(a.bz01, '- ', '-'), '^[1][1-9]\d{9}', 1, 1) phone01, -- 只要是开了卡的号码,这里统计的是所有运营商只要销售了卡就会出现这里,这里面包含了青春卡,不包含副卡,也就是说青春卡字段有数据,这里一定有数据
				 
				 --在phone01产品中,限定下列ppid的就是青春卡
				 (CASE
					 WHEN a.ppid01 in ('1016522', '1025170', '1025161') THEN
						regexp_substr(translate(a.bz01, '- ', '-'),
													'^[1][1-9]\d{9}',
													1,
													1)
					 ELSE
						null
				 END) young_phone01, --青春卡销量
				 
				 --备注中以副卡二字开头,且ppid为1016697的产品,确定为副卡
				 regexp_replace((CASE
													WHEN a.ppid01 = '1016697' THEN
													 regexp_substr(translate(a.bz01, '- ', '-'),
																				 '副卡[1][1-9]\d{9}',
																				 1,
																				 1)
													ELSE
													 null
												END),
												'副卡') two_phone01 --副卡销量
	
		from lsd a --对零售单进行日期筛选,并筛选商品分类为运营商的数据出来
	
		left join areafl b --店面分类表,全局配置地区分类维护:地区代码area01,地区属于广州还是佛山is_old01.为基础数据表,标识为佛山的可能有其他店面
			on a.area01 = b.area01
	
		left join product_data c -- 产品数据表,运营商管理中产品配置维护 :ppid----->所属的class01,是移动还是电信,--->广州的粘性系数是多少ppid_gz_nx01,佛山的粘性系数是多少ppid_fs_nx01是多少,用来给销量打折用的,名字叫粘性
			on a.ppid01 = c.ppid01
	
	 where a.date01 >= TRUNC(ADD_MONTHS(SYSDATE, -1), 'month')
		 and a.date01 <= TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) --筛选日期
				
		 and exists (select r.spfl01
						from spfl r
					 where a.spfl01 = r.spfl01
						 and r.spfl02 = '运营商') --筛选三大运营商的产品
				
		 and exists (select s.area01
						from areafl s
					 where a.area01 = s.area01
						 and s.area_brand01 = '华为零售') --只使用华为零售门店
	),

--第二步: 上面提取出号码了，因此根据号码，把对应的销量进行分离计算 ，
--需要计算出移动购机补贴的销量; 计算副卡销量；计算青春卡销量；计算粘性销量
T2 AS
 (select t1.*,
				 
				 (CASE
					 WHEN ppid_name01 like '%购机补贴%' and ppid_class01 = '移动' THEN
						num01
					 ELSE
						0
				 END) new_old_num01, --统计移动的, 购机补贴产品 销售量:商品名称包含购机补贴, 并且ppid属于移动的号码,销售1台算1台的量      
				 ----分割线----              
				 (CASE
					 WHEN two_phone01 is not null THEN
						num01
					 ELSE
						0
				 END) two_SALES01, --统计副卡的销量,对应的two_phone01这个字段,里面就是副号的号码,卖1个算1个
				 ----分割线----    
				 (CASE
					 WHEN young_phone01 is not null THEN
						num01
					 ELSE
						0
				 END) young_SALES01, --统计青春卡的销量,卖一个算1个
				 ----分割线----          
				 (CASE
					 WHEN phone01 is null THEN --首先必须销售了运营商的号码类产品
						0
					 ELSE
						(CASE
							WHEN is_old01 = '广州' THEN -- 然后判断是否为广州销售的
							 ppid_gz_nx01 --如果是广州店面销售的,那么就用广州的卡销售系数(事先定义好ppid和系数关系,销售此ppid给开出去的卡对应的就是这个系数) ,也就是广州粘性
							ELSE
							 ppid_fs_nx01 --否则用佛山销售系数
						END)
				 END) * num01 nx_num01 --统计粘性销量:只要卖的是卡类产品(phone01字段不为空那就是说明卖了卡的产品) 
	
	--*看这个店面是否属于广州,是广州的话,就匹配广州的定义的ppid对应的系数,其他区域就匹配佛山的系数
	--*弄出来了系数之后,然后乘以销量,得到的销量叫粘性销量
	--*和下面的phone01字段是对应的
	
		from T1
	
	)

--第三步:增加3列,把粘性销量按电信、移动、联通进行分离
SELECT T2.*,
			 
			 --电信粘性销量
			 (CASE
				 WHEN ppid_class01 = '电信' THEN
					NX_NUM01
				 ELSE
					0
			 END) telecom_nx_num01,
			 
			 ----移动粘性销量
			 (CASE
				 WHEN ppid_class01 = '移动' THEN
					NX_NUM01
				 ELSE
					0
			 END) mobile_nx_num01,
			 
			 --联通粘性销量
			 (CASE
				 WHEN ppid_class01 = '联通' THEN
					NX_NUM01
				 ELSE
					0
			 END) unicom_nx_num01

	FROM T2
