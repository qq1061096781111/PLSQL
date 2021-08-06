/**********************************************************************************
最终政策:
1.按回收金额4个点提成,100元封顶
2.回收金额>=21算一台,否则用回收金额/21 算台量
3.差异过大的单据手动录入,提成金额为0
****************************************************************************************/

create or replace view V_HSD_1 as
select a.*, --回收单据信息
			 
			 b.hsd01 no_hsd01, --要排除的回收单
			 -----------------
			 (case
				 when b.hsd01 is not null then --当存在排除的回收号的时候,提成直接为0
					0
				 else --按提成金额提成4个点,100元封顶
					(case
						when (a.amount01 * (select per01 from hs_param z1 where rownum = 1)) >=
								 (select top01 from hs_param z1 where rownum = 1) then --需要加括号作为整理判断
						 (select top01 from hs_param z1 where rownum = 1) --100元封顶: 子查询查出来的金额为100
						else
						 (a.amount01 * (select per01 from hs_param z1 where rownum = 1))
					end)
			 end) tc, --计算4个点回收提成,100元封顶
			 -----------------
			 round((case
							 when a.amount01 >= 21 then
								1
							 else
								a.amount01 / 21
						 end),
						 2) hs_num01 --回收金额>=21算1台,计算回收数量

	from hsd a

	left join (select * from zcxx_no_hsd r) b --关联排除的回收单据用于筛选
		on a.hsd01 = b.hsd01

 where a.date01 >= TRUNC(ADD_MONTHS(SYSDATE, -1), 'month') --筛选回收单日期,为上个月1号到月底  
	 and a.date01 <= TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1)))
   
	 and exists (select s.area01
					from areafl s
				 where a.area01 = s.area01
					 and s.area_brand01 = '华为零售') --只使用华为零售门店
