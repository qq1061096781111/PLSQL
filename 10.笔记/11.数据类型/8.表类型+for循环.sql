Ҳ�м�¼��¼��������
------------------------------------------------------------------------------------------------------

��һ��: ��ѯ���ʱ��,��ָ���ֶε����
DECLARE
	type type_lsd is table of lsd%rowtype index by binary_integer;  --��������type_lsd

	v_lsd type_lsd;  --��������

BEGIN
	select * bulk collect into v_lsd from lsd where rownum <= 55; --��ѯ������ά��������

	for i in 1 .. v_lsd.count  --ѭ�����м�¼:  1Ҳ���Ի��� v_lsd.first    v_lsd.count���Ի���v_lsd.last
	loop	
		dbms_output.put_line('���۵��ţ�' || v_lsd(i).lsd01 || ' ppid��' || v_lsd(i).ppid01 ||
												 ' ��Ʒ���ƣ�' || v_lsd(i).ppid_name01);
	end loop;
END;
------------------------------------------------------------------------------------------------

�ڶ���:��ѯ���ʱ��, ָ���ֶε����, ������һЩ
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

	/*�����Ա��Ϣ*/
	for v_index in v_lsd01.first .. v_lsd01.last
	loop
		dbms_output.put_line('���۵��ţ�' || v_lsd01(v_index) || ' ppid��' ||
												 v_ppid01(v_index) || ' ��Ʒ���ƣ�' ||
												 v_ppid_name01(v_index));
	end loop;

END;
------------------------------------------------------------------------------------------------
