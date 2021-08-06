--变量必须先声明,然后才可以使用
---------------------------------------------------------------------------------------
DECLARE

	--基本类型变量声明
	v_name01    varchar2(64);
	v_iswork01  number(1);
	v_offdata01 date;

	new_iswork01 number(11); --测试通过表达值赋值的变量

BEGIN

	--直接赋值
	v_name01    := '张三';
	v_iswork01  := 1;
	v_offdata01 := to_date('2020-01-01', 'yyyy-mm-dd'); --如果日期是当前日期,直接用 sysdate

	/*变量赋值可以进行计算*/
	--1.先在声明的地方定义好变量
	--2.然后通过表达式赋值
	--3.再打印输出
	new_iswork01 := 100 + v_iswork01;

	--打印通过 := 赋值符号赋值的变量
	dbms_output.put_line('姓名: ' || v_name01 || '是否在职' || v_iswork01 ||
											 '离职日期' || v_offdata01); --打印出赋值后的变量

	--通过查询语句赋值
	select name01, iswork01, offdata01
		into v_name01, v_iswork01, v_offdata01
		from ryxx
	 where name01 = '吴盛健';

	--打印通过select .. into .. 赋值进去的变量
	dbms_output.put_line('姓名: ' || v_name01 || '是否在职' || v_iswork01 ||
											 '离职日期' || v_offdata01);
	--打印变量 new_iswork01
	dbms_output.put_line('新的数字: ' || new_iswork01);

END;
