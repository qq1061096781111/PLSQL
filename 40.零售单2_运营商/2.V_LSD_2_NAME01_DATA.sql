--��V_LSD_PLUS02 ����͸��,�����������������
CREATE OR REPLACE VIEW V_LSD_2_NAME01_DATA AS
select a.NAME01,

       sum(a.nx_num01) nx_num01, -- ��Աճ������
       
       sum(a.telecom_nx_num01) telecom_nx_num01, --��Ա���ŵ�ճ������
       sum(a.mobile_nx_num01) mobile_nx_num01, -- ��Ա�ƶ���ճ������
       sum(a.unicom_nx_num01) unicom_nx_num01, --��Ա��ͨ��ճ������
       
       (sum(a.telecom_nx_num01) + sum(a.mobile_nx_num01)) telecom_and_mobile_nx_num01, --��Աճ�������:���ź��ƶ���ճ������
       
       sum(a.two_SALES01) two_sales01, --��Ա��������
       SUM(a.new_old_num01) new_old_num01, -- ��Ա�ƶ�����:Ҳ���������û�����,��ϸ���е��ƶ�������������
       sum(a.young_SALES01) young_sales01 --��Ա�ഺ������
       
  from V_LSD_2 a
 group by a.NAME01
