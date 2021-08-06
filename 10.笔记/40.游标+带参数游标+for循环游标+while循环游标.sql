*什么时候用*:
select into 有个局限性 要求结果有一行记录,如果我么要对结果集进行处理,这个时候我们要用到游标,

可以拿到每一行记录存储一个变量,然后去实现一些逻辑 

好像和表类型+for循环有点像


--1.for 循环编写游标
DECLARE
	cursor cur is
		select * from ryxx;

BEGIN

	for v_r in cur
	loop
		dbms_output.put_line(v_r.name01);
	end loop;

END;

------------------------------------------------------------------------------------------------------

--2.一般方法编写游标
DECLARE
	--声明游标
	cursor cur is
		select * from ryxx where rownum<=5; -- error:如果行数太多,会报错

	--游标的行记录
	v_r cur%rowtype;

BEGIN
	open cur; --1.打开游标

	loop
		--①开始循环 
		fetch cur into v_r; --读取游标到变量中记录中
		exit when cur%notfound;
	
		--编写业务逻辑
		dbms_output.put_line(v_r.name01||v_r.area01); --error: 如果字段太多,可能会报错,因此在语句中限定行数
	
	end loop; --②结束循环  

	close cur; --2.关闭游标

END;

---------------------------------------------------------------------------------------------------------

--3. while判断后再循环游标
DECLARE
	--声明游标
	cursor cur is
		select * from ryxx;

	--游标的行记录
	v_r cur%rowtype;

BEGIN
	open cur;
	fetch cur
		into v_r;
	while cur%Found
	loop
	
		--编写业务逻辑
		dbms_output.put_line(v_r.name01);
	
		fetch cur
			into v_r; --WHILE循环后面还要加上这一句
	
	end loop;

	close cur; --关闭游标
END;


-----------------------------------------------------------------------------------------------------------

/*带参数游标*/

DECLARE
  --声明游标
  cursor cur(p_number number) is
    select * from ryxx where rownum<=p_number; -- error:如果行数太多,会报错

  --游标的行记录
  v_r cur%rowtype;

BEGIN
  open cur(10); --1.打开游标

  loop
    --①开始循环 
    fetch cur into v_r; --读取游标到变量中记录中
    exit when cur%notfound;
  
    --编写业务逻辑
    dbms_output.put_line(v_r.name01||v_r.area01); --error: 如果字段太多,可能会报错,因此在语句中限定行数
  
  end loop; --②结束循环  

  close cur; --2.关闭游标

END;


