--循环
DECLARE
	v_num number(16, 4);

BEGIN

	v_num := 1;
	loop
		dbms_output.put_line(v_num);
		v_num := v_num + 1;
		exit when v_num > 100;
	end loop;

END;
----------
/*

上面的
exit when v_num>100
可以换成if判断

*/
DECLARE
	v_num number(16, 4);

BEGIN

	v_num := 1;
	loop
		dbms_output.put_line(v_num);
		v_num := v_num + 1;
	
		if v_num > 100 then
			exit;
		end if;
	
	end loop;

END;

-------------------------------------------------------------

--符合条件的循环:while循环
DECLARE
	v_num number(16, 4);

BEGIN

	v_num := 1;
	while v_num <= 100
	loop
		dbms_output.put_line(v_num);
		v_num := v_num + 1;
	end loop;

END;

-------------------------------------------------

-- for 循环
DECLARE
	v_num number(16, 4);

BEGIN

	v_num := 1;
	for i in 1 .. 100
	loop
		dbms_output.put_line(i);
	end loop;

END;
