--1.新建一个名字为  视图名称_WRITE 的Sql文件
--2.要写表的视图是: V_YYS_AREA01_DATA
--3.查找替换:查找"视图名称"替换为第2步的视图
--4.查找替换:查找"新起的表名"替换为把视图名称前面的V修改为TC
--5.增加视图中其他字段
--6.添加任务计划

--任务计划:41


CREATE OR REPLACE PROCEDURE V_YYS_GROUP01_DATA_WRITE AS -- 存出过程名称

BEGIN

  --1.本月计算上月数据,如果上月有数据,先清空一下上月的数据
  DELETE from TC_YYS_GROUP01_DATA
   WHERE date01 >= TRUNC(ADD_MONTHS(SYSDATE, -1), 'month')
     AND date01 <= TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1)));
  commit;

  --2.写表
  INSERT INTO TC_YYS_GROUP01_DATA(
     date01,
     date02,
     
            GROUP01,
       TELECOM_AND_MOBILE_NX_NUM01,
       TELECOM_NX_NUM01,
       MOBILE_NX_NUM01,
       UNICOM_NX_NUM01,
       TWO_SALES01,
       NEW_OLD_NUM01,
       YOUNG_SALES01,
       SALE_NUM01,
       group_nx_task01,
       group_nx_wcl01,
       group_yys_ppl01,
       group_yuang_task01,
       group_young_wcl01,
       two_per01

     
     )
  
    select TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))-1) date01,
           to_char(add_months(trunc(sysdate), -1), 'yyyy-mm') || '月' date02,
           
a.GROUP01,
a.TELECOM_AND_MOBILE_NX_NUM01,
a.TELECOM_NX_NUM01,
a.MOBILE_NX_NUM01,
a.UNICOM_NX_NUM01,
a.TWO_SALES01,
a.NEW_OLD_NUM01,
a.YOUNG_SALES01,
a.SALE_NUM01,
a.group_nx_task01,
a.group_nx_wcl01,
a.group_yys_ppl01,
a.group_yuang_task01,
a.group_young_wcl01,
a.two_per01

    
      from V_YYS_GROUP01_DATA a;

  COMMIT;

END;
