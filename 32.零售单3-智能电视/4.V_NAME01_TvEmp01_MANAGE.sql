
-- * ����곤�ǻ�����ҵ��  * --

CREATE OR REPLACE VIEW V_NAME01_TvEmp01_MANAGE AS


WITH W1 AS
 (
	
	select a.*, diff01 * (-50) koufa01 --2.  ����δ���Ŀ۷�, ��50һ̨�۷����
	
		from V_LSD_3_AREA01_diff01 a
	
	)

-------------------------------

select a.*,
			 
			 a.jiangli01 + a.koufa01 manage_tc01, --1. �ŵ꽱�����۷�=�ŵ����
			 
			 t.name01 --3. Ҫ�����ŵ��Ӧ�곤��˭

	from W1 a

	left JOIN ryxx_hwmanage t --4. ������Ϊ�곤����ͼ,��Ϊ�곤����ͼ������
		ON a.area01 = t.area01

 where name01 is not null;

--=======================================================================================================

-- * ��Ϊ���۵ĵ곤��ͼ * --
CREATE OR REPLACE VIEW ryxx_hwmanage AS

--��һ��:�ѻ�Ϊ����ְ�곤ɸѡ����,ʹ�õ����ϸ������һ���ͨѶ¼
	with w1 as
	 (
		
		select a.*, b.area_brand01
			from ryxx a
		
			left join areafl b -- 1. �����͵���Ʒ�ƶ���
				on a.area01 = b.area01
		
		 where date01 = TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) --2. ȡ�ϸ������һ���ͨѶ¼
					
			 and b.area_brand01 = '��Ϊ����' --3. ɸѡ��Ϊ���۵��ŵ�
					
			 and zhiwu01 = '�곤' --4. ְλ�ǵ곤
			 and iswork01 = 1 --5. ��ְ�Ļ�Ϊ����곤
		)
	--�ڶ���: һ������ڶ����ְ�곤, ȡ��ְ���ڱȽ���ĵ곤
	select a.*
		from w1 a
	 where not exists (select *
						from w1 b
					 where b.AREA01 = a.AREA01 --��������ظ�
						 --and a.zhiwu01 = b.zhiwu01
						 and b.ONDATA01 < a.ONDATA01); --6. ȡ��ְ������ĵ곤



--------------------------------------------
 

























