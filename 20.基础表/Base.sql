����
*��ѯ���۵�*
6�·ݲ�ѯ76974��
7�·ݲ�ѯ94803��
select * from lsd
 where date01 >= to_date('2021-08-01', 'yyyy-mm-dd')
	 and date01 <= to_date('2021-08-31', 'yyyy-mm-dd ');
   
-------------------------------

*��ѯ���յ�*
7�·�2758��   
select * from hsd
 where date01 >= to_date('2021-08-01', 'yyyy-mm-dd')
	 and date01 <= to_date('2021-08-31', 'yyyy-mm-dd '); 
   
------------------------------- 

*��Ա��Ϣ*
select * from ryxx where date01=to_date('2021-07-31','yyyy-mm-dd')
-------------------------------

*������Ϣ*
select * from OA_area; --OA��������ĵ���
select * from areafl;  --�ֶ�ά���ĵ�����Ϣ

-------------------------------

--��Ʒ����ı�
select * from spfl; --��Ʒ�����
select * from areafl; --���������,�Լ������������Ż����ƶ�

--���������ػ���
select * from hs_param; --���߲������ñ�: ��Ϣ���޸�,������ÿ�µ�ĳĳ��֮ǰ,������Ч
select * from zcxx_no_hsd; --�������ų��ĵ��Ŷ���

--�ǻ��������ػ���
select * from zhp_product for update; -- �ǻ����ͺ���ɷ���
select * from zhp_area_task; --�곤����: �������󶨵곤  �ǻ������������

--��Ӫ����ػ���
select * from area_yys_task; --��������Ӫ��ճ������:ǰ�˲˵�,��Ӫ�̹���,�ŵ�����
select * from group_data;    --����ճ��������ഺ������
SELECT * FROM name_yys_task; --��Աҵ������
select * from product_data; -- ��Ӫ�̲�Ʒ�������,��0.3����1��ϵ��

--�ۺϴ��ϵ����ػ���
select * from rysd_low; --�����Ա����:����ϵ����ѯ,������Ա����ȷ��
select * from area_hs_task; --�����Ļ�������:ǰ�˲˵��ڻ��չ���,�ŵ��������




--ͳ�Ʊ����

--�ô洢����:V_Name01_HsEmp01_WRITE , ����ͼ V_Name01_HsEmp01_WRITE д��, ����ƻ�21
select * from TC_Name01_HsEmp01; --�������ҵ����: ���չ���----->ҵ��ͳ��

--�ô洢����:V_NAME01_TvEmp01_EMP_WRITE ����ͼ:V_NAME01_TvEmp01_EMP  д��, ����ƻ�3-��
select * from TC_NAME01_EMPTv01; --�ǻ�����Աҵ����: �ǻ�������--->��Աҵ��ͳ��

--�ô洢����: �ô洢����:V_NAME01_TvEmp01_MANAGE_WRITE ����ͼ:V_NAME01_TvEmp01_MANAGEд�ı�, ����ƻ�3-��
select * from TC_NAME01_MANAGETv01; --�ǻ����곤ҵ����:�ǻ�������---->�곤ҵ��ͳ��

--�ô洢����V_YYS_NAME01_DATA_WRITE ����ͼ: V_Name01_Coeffi01д�ı�,  ����ƻ�42
select * from TC_Name01_Coeffi01; --��Աϵ����: ϵ������--->ϵ����ѯ

--�ô洢����V_Name01_Commission_WRITE ����ͼ: V_Name01_Commission д�ı�, ����ƻ�44
select * from TC_Name01_Commission; -- ����Ļ��ܱ�: ȫ������---->ҵ������


/*��Ӫ��д��*/

--�ô洢����V_YYS_NAME01_DATA_WRITE ����ͼ:V_YYS_NAME01_DATA д�ı�,  ����ƻ�41-��
select * from TC_YYS_NAME01_DATA; --��Ӫ����Ա���ݱ�: ��Ӫ����---->����ͳ��

--�ô洢����V_YYS_AREA01_DATA_WRITE ����ͼ:V_YYS_AREA01_DATA д�ı�, ����ƻ�41-��
select * from TC_YYS_AREA01_DATA; --��Ӫ�̵������ݱ�: ��Ӫ�̹���----->����ͳ��

--�ô洢����V_YYS_GROUP01_DATA_WRITE ����ͼ:V_YYS_GROUP01_DATA д�ı�, ����ƻ�41-��
select * from TC_YYS_GROUP01_DATA; --- ��Ӫ��������ݱ�: ��Ӫ�̹���----->����ͳ��


