--1.�½�һ������Ϊ  ��ͼ����_WRITE ��Sql�ļ�
--2.Ҫд�����ͼ��: V_YYS_AREA01_DATA
--3.�����滻:����"��ͼ����"�滻Ϊ��2������ͼ
--4.�����滻:����"����ı���"�滻Ϊ����ͼ����ǰ���V�޸�ΪTC
--5.������ͼ�������ֶ�
--6.�������ƻ�



��һ��: ������
create table ����ı��� as

select TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) date01,
       to_char(add_months(trunc(sysdate), -1), 'yyyy-mm') || '��' date02,
       
       --��ͼ�е��ֶ�

  from ��ͼ���� a


�ڶ���:�����������
CREATE OR REPLACE PROCEDURE ��ͼ����_WRITE AS -- �����������

BEGIN

	--1.���¼�����������,�������������,�����һ�����µ�����
	DELETE from ����ı���
	 WHERE date01 >= TRUNC(ADD_MONTHS(SYSDATE, -1), 'month')
		 AND date01 <= TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1)));
	commit;

	--2.д��
	INSERT INTO ����ı���
		(date01,
		 date02,
		 
		 --����ı��������ֶ�
		 
		 )
	
		select TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) date01,
					 to_char(add_months(trunc(sysdate), -1), 'yyyy-mm') || '��' date02,
		
		--��ͼ�е��ֶ�
		
			from ��ͼ���� a;

	COMMIT;

END;

	--���Բ�ѯ
select * from ����ı���;

	--���ò���
DECLARE

BEGIN

��ͼ����_WRITE;

END;
