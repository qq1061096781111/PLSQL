*ʲôʱ����*:
select into �и������� Ҫ������һ�м�¼,�����ôҪ�Խ�������д���,���ʱ������Ҫ�õ��α�,

�����õ�ÿһ�м�¼�洢һ������,Ȼ��ȥʵ��һЩ�߼� 

����ͱ�����+forѭ���е���


--1.for ѭ����д�α�
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

--2.һ�㷽����д�α�
DECLARE
	--�����α�
	cursor cur is
		select * from ryxx where rownum<=5; -- error:�������̫��,�ᱨ��

	--�α���м�¼
	v_r cur%rowtype;

BEGIN
	open cur; --1.���α�

	loop
		--�ٿ�ʼѭ�� 
		fetch cur into v_r; --��ȡ�α굽�����м�¼��
		exit when cur%notfound;
	
		--��дҵ���߼�
		dbms_output.put_line(v_r.name01||v_r.area01); --error: ����ֶ�̫��,���ܻᱨ��,�����������޶�����
	
	end loop; --�ڽ���ѭ��  

	close cur; --2.�ر��α�

END;

---------------------------------------------------------------------------------------------------------

--3. while�жϺ���ѭ���α�
DECLARE
	--�����α�
	cursor cur is
		select * from ryxx;

	--�α���м�¼
	v_r cur%rowtype;

BEGIN
	open cur;
	fetch cur
		into v_r;
	while cur%Found
	loop
	
		--��дҵ���߼�
		dbms_output.put_line(v_r.name01);
	
		fetch cur
			into v_r; --WHILEѭ�����滹Ҫ������һ��
	
	end loop;

	close cur; --�ر��α�
END;


-----------------------------------------------------------------------------------------------------------

/*�������α�*/

DECLARE
  --�����α�
  cursor cur(p_number number) is
    select * from ryxx where rownum<=p_number; -- error:�������̫��,�ᱨ��

  --�α���м�¼
  v_r cur%rowtype;

BEGIN
  open cur(10); --1.���α�

  loop
    --�ٿ�ʼѭ�� 
    fetch cur into v_r; --��ȡ�α굽�����м�¼��
    exit when cur%notfound;
  
    --��дҵ���߼�
    dbms_output.put_line(v_r.name01||v_r.area01); --error: ����ֶ�̫��,���ܻᱨ��,�����������޶�����
  
  end loop; --�ڽ���ѭ��  

  close cur; --2.�ر��α�

END;


