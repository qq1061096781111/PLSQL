--��������������,Ȼ��ſ���ʹ��
---------------------------------------------------------------------------------------
DECLARE

	--�������ͱ�������
	v_name01    varchar2(64);
	v_iswork01  number(1);
	v_offdata01 date;

	new_iswork01 number(11); --����ͨ�����ֵ��ֵ�ı���

BEGIN

	--ֱ�Ӹ�ֵ
	v_name01    := '����';
	v_iswork01  := 1;
	v_offdata01 := to_date('2020-01-01', 'yyyy-mm-dd'); --��������ǵ�ǰ����,ֱ���� sysdate

	/*������ֵ���Խ��м���*/
	--1.���������ĵط�����ñ���
	--2.Ȼ��ͨ�����ʽ��ֵ
	--3.�ٴ�ӡ���
	new_iswork01 := 100 + v_iswork01;

	--��ӡͨ�� := ��ֵ���Ÿ�ֵ�ı���
	dbms_output.put_line('����: ' || v_name01 || '�Ƿ���ְ' || v_iswork01 ||
											 '��ְ����' || v_offdata01); --��ӡ����ֵ��ı���

	--ͨ����ѯ��丳ֵ
	select name01, iswork01, offdata01
		into v_name01, v_iswork01, v_offdata01
		from ryxx
	 where name01 = '��ʢ��';

	--��ӡͨ��select .. into .. ��ֵ��ȥ�ı���
	dbms_output.put_line('����: ' || v_name01 || '�Ƿ���ְ' || v_iswork01 ||
											 '��ְ����' || v_offdata01);
	--��ӡ���� new_iswork01
	dbms_output.put_line('�µ�����: ' || new_iswork01);

END;
