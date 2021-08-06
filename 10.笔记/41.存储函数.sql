*存储过程和函数的区别*  
1.返回值: 存储函数只能返回一个,而存储过程可以返回多个
2.业务场景: 
存储函数:用来查询的比较多,给你一个参数,你给我一个结果
存储过程:①.存储过程偏重业务逻辑的处理，一个业务功能，需要写那些表，存储过程通过游标的形式，取出相应的数据，写入业务相关的表，有返回值的情况不多            
         ②.存储过程偏重对表的增删改，查是为了进行增删改，查询不是重点
         
3.存储过程不能直接在sql语句中调用,一般给引用程序调用, 存储过程本质是对业务逻辑的封装, 而存储函数封装的是一个查询结果


--存储函数基本语法结构
create or replace function fun_name(Name in type,
																		Name in type,
																		..   .) return number is
	FunctionResult number(16); --有返回值就需要声明返回变量

begin

	--编写业务逻辑

	return(FunctionResult); --最后要返回该变量
end;
-------------------------------------------------------------------------------

	--需求∶创建一个函数，可以根据人员姓名，返回人员所在地区商品名称
CREATE or replace function fun_getarea(p_name varchar2) return varchar2 is
v_out_area varchar2(30);

BEGIN

select area01 into v_out_area from ryxx where name01 = p_name;

return v_out_area;
END;

	--调用

begin
fun_get_area('李锋平');
end;

	--在子查询中使用函数,多数情况是在sql语句中使用, 都是用来查询的比较多,给你一个参数,你给我一个结果
select name01, fun_getarea(name01) from ryxx

	--------------------------------------------------------------------------------------------
