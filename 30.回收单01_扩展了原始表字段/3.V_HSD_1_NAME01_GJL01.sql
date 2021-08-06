/*�������ƣ���Ա�����ʶ��ձ�+  */

-- * ���������,�Լ��Ƿ������>=28% �ǵĻ���˵������� * --
CREATE OR REPLACE VIEW V_HSD_1_NAME01_GJL01 AS

WITH T1 AS
 (select a.*,
         
         b.sale_num01, --��Ա��Ӧ����������
         
         round(a.hs_num01 / (case
                 when b.sale_num01 = 0 then
                  a.hs_num01 / 0.28
                 else
                  b.sale_num01
               end),
               2) gjl01 -- ��������/��������������������Ϊ0��������Ĭ��28%
  
    FROM V_HSD_1_NAME01_DATA a --���յ���Ա����
  
    LEFT JOIN V_LSD_1_NAME01_DATA b --���۵���Ա����������
      on a.name01 = b.name01
  
  
  )

------------------------------------------------------------------------------------------------------------------
select t1.*,
       (case
         when gjl01 >= 0.28 then
          1
         else
          0
       end) pk_gjl01 --pk�����ʣ����˸�����>=28%Ϊ1,��ʾ��꣬����Ϊ0
  from t1
