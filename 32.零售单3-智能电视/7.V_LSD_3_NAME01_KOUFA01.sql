CREATE OR REPLACE VIEW V_LSD_3_NAME01_KOUFA01 AS

select a.area01,
			 a.group01, --����껹��...
			 a.group02, --A  B��
			 a.area_zhp_task01, --�ǻ�������
			 
			 b.name01, --����
			 b.zhiwu01, --ְ��
			 b.OFFDATA01, --��ְ����
			 b.ondata01, --��ְ����
			 b.newname01, --�Ƿ���Ա��
			 
			 nvl(c.NUM01, 0) num01, -- ��Ա�ǻ�������
			 
			 (CASE
				 WHEN a.group02 = 'A' THEN --8.û������,A��Ļ���200
					-200
				 WHEN group02 = 'B' THEN -- 9.û������, B��Ļ���100
					-100
				 ELSE
					0 --����Ļ��Ͳ���
			 END) koufa01

	from zhp_area_task a --1. �ŵ���������,��������ŵ�Żῼ��1̨����

	left join ryxx_upmonth b --2. �����������������Щ��, ��ͼ������,�����Ѿ�����Ա�Ļ�����Ϣ������ɸѡ
		on a.area01 = b.area01

	left join V_LSD_3_NAME01_DATA c --3. ��Щ�˵��ǻ������������Ƕ���
		on b.name01 = c.NAME01

 where a.area01 in
			 (select area01 from V_LSD_3_AREA01_diff01 r where diff01 > 0) --4. ����ֻ��û�д��Ŀ��ĵ����Ż��п۷�
       
	 and (c.NUM01 is null or c.num01 = 0) --5.0. Ȼ����ֻ������Ϊ�յĻ�������Ϊ <= 0��Ա�ſ۷�(����1̨,��1̨,��������0)
			
	 and b.name01 is not null; --7. �����ŵ�����������,����û����Ա

--==========================================================================    

-- * �ϸ������һ�����Ա�� * --
CREATE OR REPLACE VIEW ryxx_upmonth AS
	select a.*, b.area_brand01
		from ryxx a
	
		left join areafl b -- 1. �����͵���Ʒ�ƶ���
			on a.area01 = b.area01
	
	 where date01 = TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) --2. ȡ�ϸ������һ���ͨѶ¼
				
		 and b.area_brand01 = '��Ϊ����'    --3. ɸѡ��Ϊ���۵��ŵ� 
		 and a.zhiwu01 in ('רԱ', '����/�鳤') --4.  רԱ���ܲŻ�۷�
		 and a.newname01 = 0  --5. ������Ա��
