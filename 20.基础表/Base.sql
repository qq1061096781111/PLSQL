测试
*查询零售单*
6月份查询76974条
7月份查询94803条
select * from lsd
 where date01 >= to_date('2021-08-01', 'yyyy-mm-dd')
	 and date01 <= to_date('2021-08-31', 'yyyy-mm-dd ');
   
-------------------------------

*查询回收单*
7月份2758条   
select * from hsd
 where date01 >= to_date('2021-08-01', 'yyyy-mm-dd')
	 and date01 <= to_date('2021-08-31', 'yyyy-mm-dd '); 
   
------------------------------- 

*人员信息*
select * from ryxx where date01=to_date('2021-07-31','yyyy-mm-dd')
-------------------------------

*地区信息*
select * from OA_area; --OA传入进来的地区
select * from areafl;  --手动维护的地区信息

-------------------------------

--商品大类的表
select * from spfl; --商品大类表
select * from areafl; --地区分类表,以及地区是做电信还是移动

--回收提成相关基表
select * from hs_param; --政策参数设置表: 信息的修改,必须在每月的某某号之前,否则不生效
select * from zcxx_no_hsd; --政策与排除的单号对照

--智慧屏提成相关基表
select * from zhp_product for update; -- 智慧屏型号提成方案
select * from zhp_area_task; --店长锁定: 按地区绑定店长  智慧屏区域任务表

--运营商相关基表
select * from area_yys_task; --地区的运营商粘性任务:前端菜单,运营商管理,门店任务
select * from group_data;    --组别的粘性任务和青春卡任务
SELECT * FROM name_yys_task; --人员业务数据
select * from product_data; -- 运营商产品相关数据,是0.3还是1的系数

--综合达成系数相关基表
select * from rysd_low; --垫底人员名单:根据系数查询,管理人员自行确定
select * from area_hs_task; --地区的回收任务:前端菜单在回收管理,门店回收任务




--统计表汇总

--用存储过程:V_Name01_HsEmp01_WRITE , 对视图 V_Name01_HsEmp01_WRITE 写表, 任务计划21
select * from TC_Name01_HsEmp01; --回收提成业绩表: 回收管理----->业绩统计

--用存储过程:V_NAME01_TvEmp01_EMP_WRITE 对视图:V_NAME01_TvEmp01_EMP  写表, 任务计划3-①
select * from TC_NAME01_EMPTv01; --智慧屏店员业绩表: 智慧屏管理--->店员业绩统计

--用存储过程: 用存储过程:V_NAME01_TvEmp01_MANAGE_WRITE 对视图:V_NAME01_TvEmp01_MANAGE写的表, 任务计划3-②
select * from TC_NAME01_MANAGETv01; --智慧屏店长业绩表:智慧屏管理---->店长业绩统计

--用存储过程V_YYS_NAME01_DATA_WRITE 对视图: V_Name01_Coeffi01写的表,  任务计划42
select * from TC_Name01_Coeffi01; --人员系数表: 系数管理--->系数查询

--用存储过程V_Name01_Commission_WRITE 对视图: V_Name01_Commission 写的表, 任务计划44
select * from TC_Name01_Commission; -- 上面的汇总表: 全局配置---->业绩汇总


/*运营商写表*/

--用存储过程V_YYS_NAME01_DATA_WRITE 对视图:V_YYS_NAME01_DATA 写的表,  任务计划41-①
select * from TC_YYS_NAME01_DATA; --运营商人员数据表: 运营管理---->数据统计

--用存储过程V_YYS_AREA01_DATA_WRITE 对视图:V_YYS_AREA01_DATA 写的表, 任务计划41-②
select * from TC_YYS_AREA01_DATA; --运营商地区数据表: 运营商管理----->数据统计

--用存储过程V_YYS_GROUP01_DATA_WRITE 对视图:V_YYS_GROUP01_DATA 写的表, 任务计划41-②
select * from TC_YYS_GROUP01_DATA; --- 运营商组别数据表: 运营商管理----->数据统计


