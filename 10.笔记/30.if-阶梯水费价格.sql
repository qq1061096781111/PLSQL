--实例1: 计算水费,根据使用的吨数,不同吨数不同价格,然后计算水费

如果使用吨数<5吨, 按2.45价格进行计算
5-10吨  超过部分3.45计算
10吨以上,超过部分4.45计算


DECLARE
	v_price1 number(10, 2); --5吨以下单价
	v_price2 number(10, 2); --5-10吨单价
	v_price3 number(10, 2); --10吨以上单价

	v_usenum2 number(10, 2); -- 使用吨数
	v_money   number(10, 2); -- 金额= 单价* 使用吨数

BEGIN
	--对变量进行初始化,数据可以直接定义为常量或者从数据库查询后赋值
	v_price1 := 2.45;
	v_price2 := 3.45;
	v_price3 := 4.45;

	v_usenum2 := 10; -- 赋值使用的吨数

	--根据条件来计算出金额,并赋值到金额变量中去
	if v_usenum2 <= 5 then
		v_money := v_price1 * v_usenum2;
	
	elsif v_usenum2 > 5 and v_usenum2 <= 10 then
		v_money := v_price1 * 5 + v_price2 * (v_usenum2 - 5);
	
	else
		v_money := v_price1 * 5 + v_price2 * 5 + v_price3 * (v_usenum2 - 10);
	
	end if;

	dbms_output.put_line('水费: ' || v_money);

END;

------------------------------------------------------------------------------------------------
/*

使用case when 进行条件判断,其他的都一样, 就只要把
1.if替换成 case when,  
2.elsif 换成when ,  
3.end if  换成end case就可以了
其他一模一样

*/
DECLARE

	v_price1 number(10, 2); --5吨以下单价
	v_price2 number(10, 2); --5-10吨单价
	v_price3 number(10, 2); --10吨以上单价

	v_usenum2 number(10, 2); -- 使用吨数
	v_money   number(10, 2); -- 金额= 单价* 使用吨数
BEGIN

	--对变量进行初始化,数据可以直接定义为常量或者从数据库查询后赋值
	v_price1 := 2.45;
	v_price2 := 3.45;
	v_price3 := 4.45;

	v_usenum2 := 10; -- 赋值使用的吨数

	--根据条件来计算出金额,并赋值到金额变量中去
	case
		when v_usenum2 <= 5 then
			v_money := v_price1 * v_usenum2;
		
		when v_usenum2 > 5 and v_usenum2 <= 10 then
			v_money := v_price1 * 5 + v_price2 * (v_usenum2 - 5);
		
		else
			v_money := v_price1 * 5 + v_price2 * 5 + v_price3 * (v_usenum2 - 10);
		
	end case;

	dbms_output.put_line('水费: ' || v_money);
END;
