/**********************************************************************************
��������:
1.�����ս��4�������,100Ԫ�ⶥ
2.���ս��>=21��һ̨,�����û��ս��/21 ��̨��
3.�������ĵ����ֶ�¼��,��ɽ��Ϊ0
****************************************************************************************/

create or replace view V_HSD_1 as
select a.*, --���յ�����Ϣ
			 
			 b.hsd01 no_hsd01, --Ҫ�ų��Ļ��յ�
			 -----------------
			 (case
				 when b.hsd01 is not null then --�������ų��Ļ��պŵ�ʱ��,���ֱ��Ϊ0
					0
				 else --����ɽ�����4����,100Ԫ�ⶥ
					(case
						when (a.amount01 * (select per01 from hs_param z1 where rownum = 1)) >=
								 (select top01 from hs_param z1 where rownum = 1) then --��Ҫ��������Ϊ�����ж�
						 (select top01 from hs_param z1 where rownum = 1) --100Ԫ�ⶥ: �Ӳ�ѯ������Ľ��Ϊ100
						else
						 (a.amount01 * (select per01 from hs_param z1 where rownum = 1))
					end)
			 end) tc, --����4����������,100Ԫ�ⶥ
			 -----------------
			 round((case
							 when a.amount01 >= 21 then
								1
							 else
								a.amount01 / 21
						 end),
						 2) hs_num01 --���ս��>=21��1̨,�����������

	from hsd a

	left join (select * from zcxx_no_hsd r) b --�����ų��Ļ��յ�������ɸѡ
		on a.hsd01 = b.hsd01

 where a.date01 >= TRUNC(ADD_MONTHS(SYSDATE, -1), 'month') --ɸѡ���յ�����,Ϊ�ϸ���1�ŵ��µ�  
	 and a.date01 <= TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1)))
   
	 and exists (select s.area01
					from areafl s
				 where a.area01 = s.area01
					 and s.area_brand01 = '��Ϊ����') --ֻʹ�û�Ϊ�����ŵ�
