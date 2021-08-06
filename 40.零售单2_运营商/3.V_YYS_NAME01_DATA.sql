--������Ա��ճ�������,��Ա��ƥ����
CREATE OR REPLACE VIEW V_YYS_NAME01_DATA AS

--��һ����ȷ��Ҫ�������Ա,��������Ա����,��Ա��ճ������(���ź��ƶ�),���������
WITH W1 AS
 (select a.name01, 
         
         b.ryxx_nx_task01, --��Ա��ճ������
         
         a.telecom_and_mobile_nx_num01, --��Ա�ĵ��ź��ƶ���ճ������
         
         d.sale_num01 --��Ա������������,������ŵ�,Ϊ�����Ʒ��5�����
  
    from  V_LSD_2_NAME01_DATA a-- ��Ա��Ӫ�̵�����,ƥ����Ա��ճ������
  
    left join name_yys_task b -- ������Ա��ճ�������,����ƥ����Ա����
      on a.name01 = b.name01
  
    left join V_LSD_1_NAME01_DATA d --������Ա���������, ����ƥ����������
      on a.name01 = d.name01), 


--�ڶ�����������Ա��ƥ���ʣ�������Ա��ճ�������
W2 AS
 (select w1.*,
         ----------------
         round((CASE
                 WHEN sale_num01 = 0 THEN
                  0
                 ELSE
                  telecom_and_mobile_nx_num01 / sale_num01
               END),
               4) ryxx_yys_ppl01, --��Ա��ƥ����=ճ���������(����+�ƶ�)/��������
         -----------------
         round((CASE
                 WHEN ryxx_nx_task01 = 0 or ryxx_nx_task01 is null THEN
                  1
                 ELSE
                  telecom_and_mobile_nx_num01 / ryxx_nx_task01
               END),
               4) ryxx_nx_wcl01 --��Ա��ճ�������(����+�ƶ�)
  
    from w1)

--�������Ա��ƥ�����Ƿ��꣬���¸���ƥ�����Ƿ�>=0.22
SELECT W2.*,
       (CASE
         WHEN ryxx_yys_ppl01 >= 0.22 THEN
          1
         ELSE
          0
       END) PK_PPL01

  FROM W2
