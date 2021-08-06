一: 普通类型的数据类型定义
DECLARE

	v_name01    varchar2(64);
	v_iswork01  number(1);
	v_offdata01 date;

BEGIN

	select name01, iswork01, offdata01
		into v_name01, v_iswork01, v_offdata01
		from ryxx
	 where name01 = '吴盛健';

	dbms_output.put_line('姓名: ' || v_name01 || '是否在职' || v_iswork01 ||
											 '离职日期' || v_offdata01);

END;

------------------------------------------------

二:由于上面三种数据类型是从表里面取出来的, 因此我们可以用引用类型
 
DECLARE

--修改下面3行
v_name01 ryxx.name01%type;
v_iswork01 ryxx.iswork01%type;
v_offdata01 ryxx.offdata01%type;

BEGIN

	select name01, iswork01, offdata01
		into v_name01, v_iswork01, v_offdata01
		from ryxx
	 where name01 = '吴盛健';

	dbms_output.put_line('姓名: ' || v_name01 || '是否在职' || v_iswork01 ||
											 '离职日期' || v_offdata01);

END;

-----------------------------------------------------

三: 上面是一个字段一个字段的定义, 我们可以合并在一行进行定义

DECLARE

v_ryxx ryxx%rowtype;

BEGIN

	select * into v_ryxx from ryxx where name01 = '吴盛健';

	dbms_output.put_line('姓名: ' || v_ryxx.name01 || '是否在职' ||
											 v_ryxx.iswork01 || '离职日期' || v_ryxx.offdata01);

END;
