也叫记录记录集合类型
------------------------------------------------------------------------------------------------------

第一种: 查询表的时候,不指定字段的情况
DECLARE
	type type_lsd is table of lsd%rowtype index by binary_integer;  --定义类型type_lsd

	v_lsd type_lsd;  --变量声明

BEGIN
	select * bulk collect into v_lsd from lsd where rownum <= 55; --查询整个二维表到变量中

	for i in 1 .. v_lsd.count  --循环所有记录:  1也可以换成 v_lsd.first    v_lsd.count可以换成v_lsd.last
	loop	
		dbms_output.put_line('零售单号：' || v_lsd(i).lsd01 || ' ppid：' || v_lsd(i).ppid01 ||
												 ' 商品名称：' || v_lsd(i).ppid_name01);
	end loop;
END;
------------------------------------------------------------------------------------------------

第二种:查询表的时候, 指定字段的情况, 代码会多一些
DECLARE

	type type_lsd01 is table of lsd.lsd01%type;
	type type_ppid01 is table of lsd.ppid01%type;
	type type_ppid_name01 is table of lsd.ppid_name01%type;

	v_lsd01       type_lsd01 := type_lsd01();
	v_ppid01      type_ppid01 := type_ppid01();
	v_ppid_name01 type_ppid_name01 := type_ppid_name01();

BEGIN

	select lsd01, ppid01, ppid_name01
		bulk collect
		into v_lsd01, v_ppid01, v_ppid_name01
		from lsd
	 where rownum <= 10;

	/*输出雇员信息*/
	for v_index in v_lsd01.first .. v_lsd01.last
	loop
		dbms_output.put_line('零售单号：' || v_lsd01(v_index) || ' ppid：' ||
												 v_ppid01(v_index) || ' 商品名称：' ||
												 v_ppid_name01(v_index));
	end loop;

END;
------------------------------------------------------------------------------------------------
