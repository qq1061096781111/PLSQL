--ʵ��1: ����ˮ��,����ʹ�õĶ���,��ͬ������ͬ�۸�,Ȼ�����ˮ��

���ʹ�ö���<5��, ��2.45�۸���м���
5-10��  ��������3.45����
10������,��������4.45����


DECLARE
	v_price1 number(10, 2); --5�����µ���
	v_price2 number(10, 2); --5-10�ֵ���
	v_price3 number(10, 2); --10�����ϵ���

	v_usenum2 number(10, 2); -- ʹ�ö���
	v_money   number(10, 2); -- ���= ����* ʹ�ö���

BEGIN
	--�Ա������г�ʼ��,���ݿ���ֱ�Ӷ���Ϊ�������ߴ����ݿ��ѯ��ֵ
	v_price1 := 2.45;
	v_price2 := 3.45;
	v_price3 := 4.45;

	v_usenum2 := 10; -- ��ֵʹ�õĶ���

	--������������������,����ֵ����������ȥ
	if v_usenum2 <= 5 then
		v_money := v_price1 * v_usenum2;
	
	elsif v_usenum2 > 5 and v_usenum2 <= 10 then
		v_money := v_price1 * 5 + v_price2 * (v_usenum2 - 5);
	
	else
		v_money := v_price1 * 5 + v_price2 * 5 + v_price3 * (v_usenum2 - 10);
	
	end if;

	dbms_output.put_line('ˮ��: ' || v_money);

END;

------------------------------------------------------------------------------------------------
/*

ʹ��case when ���������ж�,�����Ķ�һ��, ��ֻҪ��
1.if�滻�� case when,  
2.elsif ����when ,  
3.end if  ����end case�Ϳ�����
����һģһ��

*/
DECLARE

	v_price1 number(10, 2); --5�����µ���
	v_price2 number(10, 2); --5-10�ֵ���
	v_price3 number(10, 2); --10�����ϵ���

	v_usenum2 number(10, 2); -- ʹ�ö���
	v_money   number(10, 2); -- ���= ����* ʹ�ö���
BEGIN

	--�Ա������г�ʼ��,���ݿ���ֱ�Ӷ���Ϊ�������ߴ����ݿ��ѯ��ֵ
	v_price1 := 2.45;
	v_price2 := 3.45;
	v_price3 := 4.45;

	v_usenum2 := 10; -- ��ֵʹ�õĶ���

	--������������������,����ֵ����������ȥ
	case
		when v_usenum2 <= 5 then
			v_money := v_price1 * v_usenum2;
		
		when v_usenum2 > 5 and v_usenum2 <= 10 then
			v_money := v_price1 * 5 + v_price2 * (v_usenum2 - 5);
		
		else
			v_money := v_price1 * 5 + v_price2 * 5 + v_price3 * (v_usenum2 - 10);
		
	end case;

	dbms_output.put_line('ˮ��: ' || v_money);
END;
