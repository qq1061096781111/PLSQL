--�����Ļ�������͵����Ļ��������бȽ�,ȷ���Ƿ���
CREATE OR REPLACE VIEW V_PK_HS_TASK_AREA AS

SELECT a.area01,
			 
			 a.area_hs_task01, -- ��������
			 
			 b.hs_num01, -- ��������
			 
			 (CASE
				 WHEN b.hs_num01 >= a.area_hs_task01 THEN -- �Ƚϻ��������ͻ�������
					1 --Ӯ�˾���1
				 ELSE
					0
			 END) is_area_hs_dabiao01

	FROM area_hs_task a
	LEFT JOIN V_HSD_1_AREA01_DATA b
		ON a.area01 = b.area01
