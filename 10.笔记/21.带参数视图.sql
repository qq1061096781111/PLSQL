第一步:创建包
--定义包:包名自己定义
create or replace package pack_par is

	--定义设置开始日期和获取开始日期的函数
	function set_startdate(p_startdate varchar2) return VARCHAR2; --定义函数set_cs1
	function get_startdate return date; --定义函数get_cs1

	--定义设置结束日期和获取结束日期的函数
	function set_enddate(p_enddate VARCHAR2) return VARCHAR2;
	function get_enddate return date;

end;

----------------------------------------------------------------

第二步 :创建包体
--创建包体:包名要和上面的一样
create or replace package body pack_par is

--定义返回值变量及类型,如果是其他类型,需要指定长度
startdate date; enddate date;
---------------------------
--开始日期的设置函数
function set_startdate(p_startdate varchar2) return VARCHAR2 is
begin
startdate := to_date(p_startdate, 'YYYY-MM-DD'); return p_startdate;
end;
--开始日期的获取函数
function get_startdate return date is
begin
return startdate;
end;
---------------------------
--结束日期的设置函数
function set_enddate(p_enddate VARCHAR2) return VARCHAR2 is
begin
enddate := to_date(p_enddate, 'YYYY-MM-DD'); return p_enddate;
end;
--结束日期的获取函数
function get_enddate return date is
begin
return enddate;
end;

end;
----------------------------------------------------------------

第三步 :创建视图, 使用函数获取日期 create or replace view v_test_lsd as --v_get_sphf 这个是视图的名称,不需要和包的名称一样,自己定义的
select * from lsd where
--date01 >= to_date('2021-06-01', 'YYYY-MM-DD') and
--date01 <= to_date('2021-06-01', 'YYYY-MM-DD')
--注释上面2行,换成下面的两个函数获取
date01 >= pack_par.get_startdate() and date01 <= pack_par.get_enddate()
-------------------------------------------------------------------

第四步 :查询视图, 同时调用set函数进行赋值 select * from v_test_lsd where pack_par.set_startdate('2021-06-01') = '2021-06-01' and pack_par.set_enddate('2021-06-02') = '2021-06-02'

网上参考的文章 https :/
/
www.cnblogs.com
/
siyunianhua
/
p
/
7205536.html

下面是根据上面的文字, 之前写的参考实例, 可以不看, 直接看PL
/
sql重新写的参考示例

create or replace package p_view_param2 is --包名自己定义
--第一对参数前面set和get不用变，只需要修改后面的名称，注意一下数据类型，一般都是文本类型
function set_CS1(sss varchar2) return varchar2; function get_CS1 return varchar2;

--第二对参数，名称不能和第一对参数相同，注意一下数据类型
function set_CS2(sss2 varchar2) return varchar2; function get_CS2 return varchar2;

--第三对参数：这里是用来测试的，由于是复制第二个参数，需要把sss2修改为sss3
function set_CS3(sss3 varchar2) return varchar2; function get_CS3 return varchar2;

--结束的时候，也要一个包名，名称要一样
end p_view_param2;

create or replace package body p_view_param2 is --包名要和上面的一样

paramValue varchar2(50); paramValue2 varchar2(50);
--如果需要增加参数，这里也要增加一个参数，这里需要增加一个参数3，因为我们增加了一个参数
paramValue3 varchar2(50);

--修改第一对参数的名称，名称和上面的第一对参数名称一样
function set_CS1(sss varchar2) return varchar2 is
begin
paramValue := sss; return sss;
end;

function get_CS1 return varchar2 is
begin
return paramValue;
end;

--修改第二对参数的名称，名称和上面的第二对参数名称一样
function set_CS2(sss2 varchar2) return varchar2 is
begin
paramValue2 := sss2; return sss2;
end;

function get_CS2 return varchar2 is
begin
return paramValue2;
end;

--复制参数2的语句快，把CS2修改为CS3，SSS2 修改为sss3，paramValue2修改为paramValue3
function set_CS3(sss3 varchar2) return varchar2 is
begin
paramValue3 := sss3; return sss3;
end;

function get_CS3 return varchar2 is
begin
return paramValue3;
end;

end p_view_param2; --包名要和上面的一样

create or replace view v_get_sphf2 as --v_get_sphf 这个是视图的名称,不需要和包的名称一样,自己定义的
NULL;

--把NULL用sql语句替换
--把语句中可变文本'可变文本'(单引号也要替换掉)用函数代替：函数格式为  包名.get_参数1名称()
/*
如某当sql语句有如下2个条件语句，需要把'2018-10-01'和'2018-10-07'用参数代替
and lsd.lsd07 >= to_date('2018-10-01', 'YYYY-MM-DD')
and lsd.lsd07 <= to_date('2018-10-07', 'YYYY-MM-DD')

'2018-10-01' 用前面的参数1代替,因此替换成  p_view_param.get_CS1()  其中p_view_param为包名get_CS1()为我们定义函数的第一对函数
'2018-10-07' 用前面的参数2代替,因此替换成  p_view_param.get_CS2() 其中p_view_param为包名get_CS2()为我们定义函数的第二对函数

2条语句变为如下代码
and lsd.lsd07 >= to_date(p_view_param.get_CS1(), 'YYYY-MM-DD')
and lsd.lsd07 <= to_date(p_view_param.get_CS2(), 'YYYY-MM-DD')

*/

--对视图进行查询
select * from v_get_sphf2 --v_get_sphf2这个名称就是创建视图时候自定义的名称

-- p_view_param2修改为包名
-- cs1和cs3 这两个名称需要和创建视图用到的名称一致
--2018-10-01为要传入的实际参数，需要有单引号，前后内容要一样  
where p_view_param2.set_CS1('2018-11-18') = '2018-11-18' and p_view_param2.set_CS3('2018-11-24') = '2018-11-24'

--注意，这里演示用到了CS1和cs3参数，没有用cs2参数
/*
 WHERE 包名.set_参数1名称('文本值') = '文本值'  --两个文本值要一样
  and  包名.set_参数2名称('文本值2') = '文本值2'    
  如果还有其他参数，继续添加
 */

--当然，这样你就可以把该查询放到自定义报表进行查询了
