-- * �ǻ������۵�һ����ϸ���� * --

CREATE OR REPLACE VIEW V_LSD_3 AS

 select a.*,
				b.ppid_tc_price01, --5. ƥ��PPID����ɵ���
        
				a.num01 * b.ppid_tc_price01 TvEmp01 --6. ������ɽ��
 
	 from lsd a
 
	 LEFT JOIN zhp_product b
		 on a.ppid01 = b.ppid01
 
	where area01 != 'GD_hw7' -- 4. �ų��ߵµ�
  
		and date01 >= TRUNC(ADD_MONTHS(SYSDATE, -1), 'month')  --1.ɸѡ���۵�, �ϸ��µ�һ�쵽���һ��
		and date01 <= TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) 
			 
		and exists (select *
					 from spfl e1
					where a.spfl01 = e1.spfl01
						and e1.spfl01 = '���ܵ���') --2.ɸѡ��Ʒ����Ϊ���ܵ��ӵ�
            
		and exists (select s.area01
					 from areafl s
					where a.area01 = s.area01
						and s.area_brand01 = '��Ϊ����') --3.ֻʹ�û�Ϊ�����ŵ�
