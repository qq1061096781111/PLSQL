--不写异常处理程序,下面的查询返回多行记录,赋值到变量V_LSD中,就不让了,会报异常
DECLARE

	V_LSD LSD%ROWTYPE;

BEGIN

	SELECT * INTO V_LSD FROM LSD;

END;

-------------------------------------------

一 :预定义异常处理
-- 对可能产生异常的语句进行捕获并输出
DECLARE

V_LSD LSD%ROWTYPE;

BEGIN

	--可能引发异常的语句
	SELECT * INTO V_LSD FROM LSD;

EXCEPTION

	when NO_DATA_FOUND then
		--中间那个NO_DATA_FOUND就是oracle预定义的21种异常
		--处理方式1:打印异常
		dbms_output.put_line('没有找到数据');
	
		--处理方式2:直接抛出异常
		RAISE_APPLICATION_ERROR(-20003, '没有找到数据');
	
	when TOO_MANY_ROWS then
		--可能发生的异常都监控一下
		--处理方式:抛出异常
		RAISE_APPLICATION_ERROR(-20003, '数据太多了');
	
END;

-------------------------------------------

二 :自定义异常
--这里对上面的异常, 改写成自定义异常
DECLARE

V_LSD LSD%ROWTYPE;

INTEGRITY_ERROR Exception;
ERRNO Integer;
ERRMSG Char(200);

BEGIN

	begin
	
		SELECT * INTO V_LSD FROM LSD; -- 这里编写可能出现异常的语句
	
	exception
		when NO_DATA_FOUND then
			--该语句可能引发系统定义的NO_DATA_FOUND异常
			ERRNO  := -20003;
			ERRMSG := '没有找到数据'; --引发异常的话,则对两个自定义变量进行赋值,然后抛出异常到 INTEGRITY_ERROR异常类型变量中
			raise INTEGRITY_ERROR;
		when too_many_rows then
			ERRNO  := -20003;
			ERRMSG := '数据太多了';
			raise INTEGRITY_ERROR;
	end;

	--前端进行显示异常
EXCEPTION
	WHEN INTEGRITY_ERROR THEN
		RAISE_APPLICATION_ERROR(ERRNO, ERRMSG);
	
END;
-------------------------------------------

--自定义异常作为提示信息用 
DECLARE

	V_LSD LSD%ROWTYPE;

	INTEGRITY_ERROR Exception;
	ERRNO  Integer;
	ERRMSG Char(200);

BEGIN

	IF 1 = 1 THEN
		ERRNO  := -20003;
		ERRMSG := '1确实等于1';
		Raise INTEGRITY_ERROR;
	END IF;

EXCEPTION
	WHEN INTEGRITY_ERROR THEN
		RAISE_APPLICATION_ERROR(ERRNO, ERRMSG);
	
END;
