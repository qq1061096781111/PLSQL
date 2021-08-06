--���������Ӫ�̵�ָ��

CREATE OR REPLACE VIEW V_YYS_AREA01_DATA AS

--��һ��:�����������ճ�������, �������ഺ�������,  ������ճ��ƥ����, �����ĸ���������
with T1 AS
 (select a.*,
 
         c.group01, --�ŵ��Ϊ�����,ר����,�ۺϵ�����
 
         b.area_yys_task01, --ճ������
         
         --������ճ������� = �����ţ��ƶ�����ճ����� / ��������Ӫ������          
         round((CASE
                 WHEN b.area_yys_task01 = 0 THEN
                  1
                 ELSE
                  telecom_and_mobile_nx_num01 / b.area_yys_task01
               END),
               4) area_nx_wcl01,
                         
         --�����ഺ������
         b.area_yuang_task01,  
         
         --�����ഺ������� = �ഺ������ / �����ഺ������
         round((CASE
                 WHEN b.area_yuang_task01 = 0 THEN
                  1
                 ELSE
                  young_SALES01 / b.area_yuang_task01
               END),
               4) area_young_wcl01, 
         
          --����ճ��ƥ����=(����+�ƶ�)��ճ������ / ��������
         round((CASE
                 WHEN d.sale_num01 = 0 THEN
                  0
                 ELSE
                  telecom_and_mobile_nx_num01 / d.sale_num01
               END),
               4) area_yys_ppl01,
         
         --����������=��������/���Ǳ�ע�˹����������ƶ�������
         round((CASE
                 WHEN new_old_num01 = 0 THEN
                  0
                 ELSE
                  a.TWO_SALES01 / new_old_num01
               END),
               4) two_per01, 
         
         --�������˵���Ӫ��,Ҳ����˵ָ�����������ƶ�������ͨ
         c.area_kh_yys01, 
         
         --�ŵ���������
         d.sale_num01 
  
    from V_LSD_2_AREA01_DATA a -- ��������������Ӫ�̵���������
  
    left join area_yys_task b -- ��Ӫ�������,��ճ��������ഺ������,����ճ�������,�ഺ�������
      on a.AREA01 = b.area01
  
    left join areafl c --�����͵���Ҫ���˵���Ӫ��������,���������ƶ��ĸ���������
      on a.AREA01 = c.area01
  
    left join V_LSD_1_AREA01_DATA d -- �����������,�ų����ŵ���,��������ƥ���ʵ�
      on a.AREA01 = d.area01)



--�ڶ���:�����ŵ꿼��ĳ����Ӫ��,�����ƶ������Ĵ�����, ��Ϊ����Ҳ������
select T1.*,
       (CASE
         WHEN area_kh_yys01 = '�ƶ�' THEN
          two_per01
         ELSE
          0
       END) moble_two_per01 --�ƶ�����������

  FROM T1
