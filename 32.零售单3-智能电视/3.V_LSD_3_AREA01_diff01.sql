-- * ��������������,Ҫ������ŵ�û����ɵ����� * --
CREATE OR REPLACE VIEW V_LSD_3_AREA01_diff01 AS


 SELECT a.area01,
				a.area_zhp_task01, --3. ��������
				nvl(b.NUM01, 0) num01, --4. �����ǻ�������
				
				(CASE
					WHEN (area_zhp_task01 - nvl(b.NUM01, 0)) > 0 THEN
					 (area_zhp_task01 - nvl(b.NUM01, 0))
					ELSE
					 0
				END) diff01, --5. ���� - ���� = ������� > 0 �Ļ�,˵��û���������, ��ʾδ�������;   �������0  �������������
				
				nvl(b.NUM01, 0) * 50 jiangli01 --6. ˳������������Ӧ�����,���ǵ곤�����
 
	 FROM zhp_area_task a --1. �ŵ���ǻ���������(�����ŵ���)
 
	 LEFT JOIN V_LSD_3_AREA01_DATA b --2. �ŵ���ǻ�������
		 on a.area01 = b.AREA01
