--ѭ��
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

�����
exit when v_num>100
���Ի���if�ж�

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

--����������ѭ��:whileѭ��
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

-- for ѭ��
DECLARE
	v_num number(16, 4);

BEGIN

	v_num := 1;
	for i in 1 .. 100
	loop
		dbms_output.put_line(i);
	end loop;

END;
