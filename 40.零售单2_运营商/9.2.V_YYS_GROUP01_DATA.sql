
CREATE OR REPLACE VIEW V_YYS_GROUP01_DATA AS


with w1 as
 (
  
  select a.GROUP01, --��������:�����,ר����....
  
          sum(a.telecom_and_mobile_nx_num01) telecom_and_mobile_nx_num01, -- �������:Ҳ�����ƶ�����ͨ��
          
          sum(a.telecom_nx_num01) telecom_nx_num01, -- ���ŵ�ճ������
          sum(a.mobile_nx_num01) mobile_nx_num01, -- �ƶ���ճ������
          sum(a.unicom_nx_num01) unicom_nx_num01, --��ͨճ������
          
          sum(a.two_SALES01) two_SALES01, -- ��������
          sum(a.new_old_num01) new_old_num01, --�ƶ�����
          sum(a.young_SALES01) young_SALES01, --�ഺ������
          
          sum(a.sale_num01) sale_num01 --��������
  
    from V_YYS_AREA01_DATA a --��Ӫ�̵���������
  
   group by a.GROUP01
  
  )

select a.*,
       
       b.group_nx_task01,
       
       --������Ӫ������� =�����ţ��ƶ�����ճ������� / ճ������
       round((CASE
               WHEN b.group_nx_task01 = 0 THEN
                1
               ELSE
                telecom_and_mobile_nx_num01 / b.group_nx_task01
             END),
             4) group_nx_wcl01, 
       

       --������Ӫ��ƥ���� = ������+�ƶ�����ճ������� / ��������
       round((CASE
               WHEN sale_num01 = 0 THEN
                0
               ELSE
                telecom_and_mobile_nx_num01 / sale_num01
             END),
             4) group_yys_ppl01, 
             

        -- �����ഺ������
       b.group_yuang_task01,
       
       -- �����ഺ�������
       round((CASE
               WHEN b.group_yuang_task01 = 0 THEN
                1
               ELSE
                young_SALES01 / b.group_yuang_task01
             END),
             4) group_young_wcl01,
       
       --���ĸ���������
       round((CASE
               WHEN new_old_num01 = 0 THEN
                0
               ELSE
                TWO_SALES01 / new_old_num01
             END),
             4) two_per01
       

  from w1 a
  left join group_data b --��ģ����Ӫ������������������ά��
    on a.GROUP01 = b.group01
