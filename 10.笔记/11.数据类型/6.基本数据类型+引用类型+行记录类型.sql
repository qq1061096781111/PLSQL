һ: ��ͨ���͵��������Ͷ���
DECLARE

	v_name01    varchar2(64);
	v_iswork01  number(1);
	v_offdata01 date;

BEGIN

	select name01, iswork01, offdata01
		into v_name01, v_iswork01, v_offdata01
		from ryxx
	 where name01 = '��ʢ��';

	dbms_output.put_line('����: ' || v_name01 || '�Ƿ���ְ' || v_iswork01 ||
											 '��ְ����' || v_offdata01);

END;

------------------------------------------------

��:���������������������Ǵӱ�����ȡ������, ������ǿ�������������
 
DECLARE

--�޸�����3��
v_name01 ryxx.name01%type;
v_iswork01 ryxx.iswork01%type;
v_offdata01 ryxx.offdata01%type;

BEGIN

	select name01, iswork01, offdata01
		into v_name01, v_iswork01, v_offdata01
		from ryxx
	 where name01 = '��ʢ��';

	dbms_output.put_line('����: ' || v_name01 || '�Ƿ���ְ' || v_iswork01 ||
											 '��ְ����' || v_offdata01);

END;

-----------------------------------------------------

��: ������һ���ֶ�һ���ֶεĶ���, ���ǿ��Ժϲ���һ�н��ж���

DECLARE

v_ryxx ryxx%rowtype;

BEGIN

	select * into v_ryxx from ryxx where name01 = '��ʢ��';

	dbms_output.put_line('����: ' || v_ryxx.name01 || '�Ƿ���ְ' ||
											 v_ryxx.iswork01 || '��ְ����' || v_ryxx.offdata01);

END;
