
--��V_LSD_PLUS02 ����͸��,�����������������
CREATE OR REPLACE VIEW V_LSD_2_GROUP01_DATA AS
select A.GROUP01, --�������

       sum(a.nx_num01) nx_num01, -- ���ճ������
       
       sum(a.telecom_nx_num01) telecom_nx_num01, --���ŵ�ճ������
       sum(a.mobile_nx_num01) mobile_nx_num01, -- �ƶ���ճ������
       sum(a.unicom_nx_num01) unicom_nx_num01, --��ͨ��ճ������    
       (sum(a.telecom_nx_num01) + sum(a.mobile_nx_num01)) telecom_and_mobile_nx_num01, --ճ�������:���ź��ƶ���ճ������
       
       sum(a.two_SALES01) two_sales01, --��������
       SUM(a.new_old_num01) new_old_num01, -- �ƶ�����:Ҳ���������û�����,��ϸ���е��ƶ�������������
       sum(a.young_SALES01) young_sales01 --�ഺ������
       
  from V_LSD_2 a
 group by a.group01
