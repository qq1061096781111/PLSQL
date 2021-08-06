--1.新建一个名字为  视图名称_WRITE 的Sql文件
--2.要写表的视图是: V_YYS_AREA01_DATA
--3.查找替换:查找"视图名称"替换为第2步的视图
--4.查找替换:查找"新起的表名"替换为把视图名称前面的V修改为TC
--5.增加视图中其他字段
--6.添加任务计划



第一步: 创建表
create table 新起的表名 as

select TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) date01,
       to_char(add_months(trunc(sysdate), -1), 'yyyy-mm') || '月' date02,
       
       --视图中的字段

  from 视图名称 a


第二步:创建存出过程
CREATE OR REPLACE PROCEDURE 视图名称_WRITE AS -- 存出过程名称

BEGIN

	--1.本月计算上月数据,如果上月有数据,先清空一下上月的数据
	DELETE from 新起的表名
	 WHERE date01 >= TRUNC(ADD_MONTHS(SYSDATE, -1), 'month')
		 AND date01 <= TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1)));
	commit;

	--2.写表
	INSERT INTO 新起的表名
		(date01,
		 date02,
		 
		 --新起的表中其他字段
		 
		 )
	
		select TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) date01,
					 to_char(add_months(trunc(sysdate), -1), 'yyyy-mm') || '月' date02,
		
		--视图中的字段
		
			from 视图名称 a;

	COMMIT;

END;

	--测试查询
select * from 新起的表名;

	--调用测试
DECLARE

BEGIN

视图名称_WRITE;

END;
