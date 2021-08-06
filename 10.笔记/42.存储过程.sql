创建存储过程基本语法

create or replace procedure pro_name(Name in out type,
																		 Name in out type,
																		 ..   .) is --传出参数必须加out
begin

	--编写业务逻辑中间可以有异常处理  

end;
------------------------------------------------------------

调用方法1

begin
过程名称(实参1, 实参2 .. .);
end;

调用方法2 call 过程名称(实参1, 实参2 .. .); --没有测试通过

	---------------------------------------------------------------------------------------------------

不带返回值的存储过程, 例子, 例子可以参考"存储过程写表"

java中调用 :1.先建一个方法 2.然后在里面调用 3.设置数据, 弄个对象出来, 然后用方法把对象添加到数据库

	--------------------------------------------------------------------------------------------

带返回参数的存储过程例子

CREATE or replace procedure pro_getarea(p_name varchar2, p_out_area out varchar2) is
BEGIN
select area01 into p_out_area from ryxx where name01 = p_name;
END;

调用 1.不能用call这种方式 2.用下面的方式 declare p_out_area varchar2(64);

begin
pro_getarea('李锋平', p_out_area); dbms_output.put_line(p_out_area);
end;

java中调用 :1.先建一个带返回值的方法 2.然后在里面调用, 有多少个传入参数用 ? 替代 3.然后注册传出参数需要指明是第几个参数 作用表明第几个参数设定为返回值, 和参数类型, 然后这个值就能拿出来 3.设置数据, 弄个对象出来, 然后用方法把对象添加到数据库
