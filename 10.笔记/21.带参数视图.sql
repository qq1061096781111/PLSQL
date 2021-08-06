��һ��:������
--�����:�����Լ�����
create or replace package pack_par is

	--�������ÿ�ʼ���ںͻ�ȡ��ʼ���ڵĺ���
	function set_startdate(p_startdate varchar2) return VARCHAR2; --���庯��set_cs1
	function get_startdate return date; --���庯��get_cs1

	--�������ý������ںͻ�ȡ�������ڵĺ���
	function set_enddate(p_enddate VARCHAR2) return VARCHAR2;
	function get_enddate return date;

end;

----------------------------------------------------------------

�ڶ��� :��������
--��������:����Ҫ�������һ��
create or replace package body pack_par is

--���巵��ֵ����������,�������������,��Ҫָ������
startdate date; enddate date;
---------------------------
--��ʼ���ڵ����ú���
function set_startdate(p_startdate varchar2) return VARCHAR2 is
begin
startdate := to_date(p_startdate, 'YYYY-MM-DD'); return p_startdate;
end;
--��ʼ���ڵĻ�ȡ����
function get_startdate return date is
begin
return startdate;
end;
---------------------------
--�������ڵ����ú���
function set_enddate(p_enddate VARCHAR2) return VARCHAR2 is
begin
enddate := to_date(p_enddate, 'YYYY-MM-DD'); return p_enddate;
end;
--�������ڵĻ�ȡ����
function get_enddate return date is
begin
return enddate;
end;

end;
----------------------------------------------------------------

������ :������ͼ, ʹ�ú�����ȡ���� create or replace view v_test_lsd as --v_get_sphf �������ͼ������,����Ҫ�Ͱ�������һ��,�Լ������
select * from lsd where
--date01 >= to_date('2021-06-01', 'YYYY-MM-DD') and
--date01 <= to_date('2021-06-01', 'YYYY-MM-DD')
--ע������2��,�������������������ȡ
date01 >= pack_par.get_startdate() and date01 <= pack_par.get_enddate()
-------------------------------------------------------------------

���Ĳ� :��ѯ��ͼ, ͬʱ����set�������и�ֵ select * from v_test_lsd where pack_par.set_startdate('2021-06-01') = '2021-06-01' and pack_par.set_enddate('2021-06-02') = '2021-06-02'

���ϲο������� https :/
/
www.cnblogs.com
/
siyunianhua
/
p
/
7205536.html

�����Ǹ������������, ֮ǰд�Ĳο�ʵ��, ���Բ���, ֱ�ӿ�PL
/
sql����д�Ĳο�ʾ��

create or replace package p_view_param2 is --�����Լ�����
--��һ�Բ���ǰ��set��get���ñ䣬ֻ��Ҫ�޸ĺ�������ƣ�ע��һ���������ͣ�һ�㶼���ı�����
function set_CS1(sss varchar2) return varchar2; function get_CS1 return varchar2;

--�ڶ��Բ��������Ʋ��ܺ͵�һ�Բ�����ͬ��ע��һ����������
function set_CS2(sss2 varchar2) return varchar2; function get_CS2 return varchar2;

--�����Բ������������������Եģ������Ǹ��Ƶڶ�����������Ҫ��sss2�޸�Ϊsss3
function set_CS3(sss3 varchar2) return varchar2; function get_CS3 return varchar2;

--������ʱ��ҲҪһ������������Ҫһ��
end p_view_param2;

create or replace package body p_view_param2 is --����Ҫ�������һ��

paramValue varchar2(50); paramValue2 varchar2(50);
--�����Ҫ���Ӳ���������ҲҪ����һ��������������Ҫ����һ������3����Ϊ����������һ������
paramValue3 varchar2(50);

--�޸ĵ�һ�Բ��������ƣ����ƺ�����ĵ�һ�Բ�������һ��
function set_CS1(sss varchar2) return varchar2 is
begin
paramValue := sss; return sss;
end;

function get_CS1 return varchar2 is
begin
return paramValue;
end;

--�޸ĵڶ��Բ��������ƣ����ƺ�����ĵڶ��Բ�������һ��
function set_CS2(sss2 varchar2) return varchar2 is
begin
paramValue2 := sss2; return sss2;
end;

function get_CS2 return varchar2 is
begin
return paramValue2;
end;

--���Ʋ���2�����죬��CS2�޸�ΪCS3��SSS2 �޸�Ϊsss3��paramValue2�޸�ΪparamValue3
function set_CS3(sss3 varchar2) return varchar2 is
begin
paramValue3 := sss3; return sss3;
end;

function get_CS3 return varchar2 is
begin
return paramValue3;
end;

end p_view_param2; --����Ҫ�������һ��

create or replace view v_get_sphf2 as --v_get_sphf �������ͼ������,����Ҫ�Ͱ�������һ��,�Լ������
NULL;

--��NULL��sql����滻
--������пɱ��ı�'�ɱ��ı�'(������ҲҪ�滻��)�ú������棺������ʽΪ  ����.get_����1����()
/*
��ĳ��sql���������2��������䣬��Ҫ��'2018-10-01'��'2018-10-07'�ò�������
and lsd.lsd07 >= to_date('2018-10-01', 'YYYY-MM-DD')
and lsd.lsd07 <= to_date('2018-10-07', 'YYYY-MM-DD')

'2018-10-01' ��ǰ��Ĳ���1����,����滻��  p_view_param.get_CS1()  ����p_view_paramΪ����get_CS1()Ϊ���Ƕ��庯���ĵ�һ�Ժ���
'2018-10-07' ��ǰ��Ĳ���2����,����滻��  p_view_param.get_CS2() ����p_view_paramΪ����get_CS2()Ϊ���Ƕ��庯���ĵڶ��Ժ���

2������Ϊ���´���
and lsd.lsd07 >= to_date(p_view_param.get_CS1(), 'YYYY-MM-DD')
and lsd.lsd07 <= to_date(p_view_param.get_CS2(), 'YYYY-MM-DD')

*/

--����ͼ���в�ѯ
select * from v_get_sphf2 --v_get_sphf2������ƾ��Ǵ�����ͼʱ���Զ��������

-- p_view_param2�޸�Ϊ����
-- cs1��cs3 ������������Ҫ�ʹ�����ͼ�õ�������һ��
--2018-10-01ΪҪ�����ʵ�ʲ�������Ҫ�е����ţ�ǰ������Ҫһ��  
where p_view_param2.set_CS1('2018-11-18') = '2018-11-18' and p_view_param2.set_CS3('2018-11-24') = '2018-11-24'

--ע�⣬������ʾ�õ���CS1��cs3������û����cs2����
/*
 WHERE ����.set_����1����('�ı�ֵ') = '�ı�ֵ'  --�����ı�ֵҪһ��
  and  ����.set_����2����('�ı�ֵ2') = '�ı�ֵ2'    
  ������������������������
 */

--��Ȼ��������Ϳ��԰Ѹò�ѯ�ŵ��Զ��屨����в�ѯ��
