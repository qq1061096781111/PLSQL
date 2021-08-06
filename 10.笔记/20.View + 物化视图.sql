视图的基本结构

CREATE OR REPLACE VIEW VIEW_视图名称 AS
select


---------------------------------------

标题: 物化视图

第一步: 用dba帐户给当前用户授权
 grant create materialized view to gzscm; 

第二步: 开始编写物化视图  
 create materialized view  mv_name
 refresh force
 on demand
 start with sysdate   --创建后立即执行第一次查询
 
 --下面这行语句不能在后面增加注释,否则执行不了,下面语句意思是以后每天凌晨1点执行查询
 next to_date(concat(to_char(sysdate+1,'dd-mm-yyyy'),'01:00:00'),'dd-mm-yyyy hh24:mi:ss') 
 as 
 
select * from lsd; --后面不加分号也可以,物化视图的字段中不能用子查询

------------------------

删除物化视图：

drop materialized view mv_name





