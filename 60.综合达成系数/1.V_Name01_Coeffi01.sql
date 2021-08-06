--������Ա���ۺϴ��ϵ��

CREATE OR REPLACE VIEW V_Name01_Coeffi01 AS 

--ƴ�ӳ�Ҫ��ԱҪ���˵�ָ����ص��ֶ�: ��Ա����,�����Ա����,��������,��Ա��������, ��Ա�����ʸ�����,��Ա�ļӵ���, ������ճ�������,�����Ļ��������
with t2 as
 (select a.name01,
				 a.area01, --��Ա���ڵ���  
				 
				 c.pk_gjl01, -- ƥ��������Ƿ���(1,0)
				 h.PK_PPL01, -- ƥ����Աƥ�����Ƿ���(1,0)
				 
				 g.is_area_hs_dabiao01, -- �����Ļ������Ƿ���(1,0)
				 b.is_area_yys_dabiao01, -- ��������Ӫ���Ƿ���(1,0)
				 
				 k.name01 low_name01, -- �����Ա����,ҵ��ά��, ���Կ������д��
         
				 --�ۺ�����ʵļ���                              
				 ROUND(nvl((CASE
										 WHEN h.RYXX_YYS_PPL01 > 0.3 THEN
											0.3
										 ELSE
											h.ryxx_yys_ppl01
									 END),
									 0) * 0.5 / 0.25 +
							 nvl((CASE
										 WHEN c.GJL01 > 0.324 THEN
											0.324
										 ELSE
											c.GJL01
									 END),
									 0) * 0.5 / 0.27,
							 4) ZH_WCL01
	
		from ryxx_emp a -- Ҫ����ϵ������Ա
	
		left join V_HSD_1_NAME01_GJL01 c -- ƥ����˸������Ƿ�ﵽҪ��:������>=0.28,��ﵽҪ��
			on a.NAME01 = c.NAME01
	
		left join V_YYS_NAME01_DATA h    -- ƥ�������Ӫ��ƥ�����Ƿ���:ƥ����>=0.22
			on a.name01 = h.NAME01
	
		left join V_PK_HS_TASK_AREA g    --ƥ���ŵ��Ƿ����������:���ŵ�Ļ����������õ��ŵ�����������Ƚ�
			on a.area01 = g.area01
	
		left join V_PK_YYS_TASK_AREA b   --ƥ���ŵ��Ƿ������Ӫ������
			on a.area01 = b.area01
	
		LEFT JOIN RYSD_LOW k -- ƥ���Ƿ�Ϊ�����Ա
			on a.name01 = k.name01
	
	)

--��������Ա�ͷǵ����Ա��ϵ��: ���ڵ����Ա,�жϵ�ָ���Ǳ������� �� �ӵ���, ���ڷǵ����Ա,���˵�����Ա����Ӫ��ƥ���ʺ͵�����ճ�������    
select t2.*,
			 
			 (CASE
				 WHEN low_name01 is null THEN
					(CASE
						WHEN (is_area_hs_dabiao01 = 1 and pk_gjl01 = 1) and
								 (is_area_yys_dabiao01 = 1 and PK_PPL01 = 1) THEN
						 1.2
					
						ELSE
						
						 (CASE
							 WHEN (is_area_hs_dabiao01 = 1 and pk_gjl01 = 1) or
										(is_area_yys_dabiao01 = 1 and PK_PPL01 = 1) THEN
								1.1
							 ELSE
								1
						 END)
					
					END)
				 ELSE
					(CASE
						WHEN low_name01 is not null THEN
						 0.8
						ELSE
						 1
					
					END)
			 END)
			 
			 coeffi01

	from t2;

--==================================================================================           

--��Ϊ����,���ϸ������һ��δ��ְ��������Ա: �����ۺϴ��ϵ������
CREATE OR REPLACE VIEW ryxx_emp AS
	select a.*, b.area_brand01
		from ryxx a
		left join areafl b
			on a.area01 = b.area01
	
	 where date01 = TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) --�������һ����Ա���ڵ���
		 and b.area_brand01 = '��Ϊ����'
