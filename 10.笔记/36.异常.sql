--��д�쳣�������,����Ĳ�ѯ���ض��м�¼,��ֵ������V_LSD��,�Ͳ�����,�ᱨ�쳣
DECLARE

	V_LSD LSD%ROWTYPE;

BEGIN

	SELECT * INTO V_LSD FROM LSD;

END;

-------------------------------------------

һ :Ԥ�����쳣����
-- �Կ��ܲ����쳣�������в������
DECLARE

V_LSD LSD%ROWTYPE;

BEGIN

	--���������쳣�����
	SELECT * INTO V_LSD FROM LSD;

EXCEPTION

	when NO_DATA_FOUND then
		--�м��Ǹ�NO_DATA_FOUND����oracleԤ�����21���쳣
		--����ʽ1:��ӡ�쳣
		dbms_output.put_line('û���ҵ�����');
	
		--����ʽ2:ֱ���׳��쳣
		RAISE_APPLICATION_ERROR(-20003, 'û���ҵ�����');
	
	when TOO_MANY_ROWS then
		--���ܷ������쳣�����һ��
		--����ʽ:�׳��쳣
		RAISE_APPLICATION_ERROR(-20003, '����̫����');
	
END;

-------------------------------------------

�� :�Զ����쳣
--�����������쳣, ��д���Զ����쳣
DECLARE

V_LSD LSD%ROWTYPE;

INTEGRITY_ERROR Exception;
ERRNO Integer;
ERRMSG Char(200);

BEGIN

	begin
	
		SELECT * INTO V_LSD FROM LSD; -- �����д���ܳ����쳣�����
	
	exception
		when NO_DATA_FOUND then
			--������������ϵͳ�����NO_DATA_FOUND�쳣
			ERRNO  := -20003;
			ERRMSG := 'û���ҵ�����'; --�����쳣�Ļ�,��������Զ���������и�ֵ,Ȼ���׳��쳣�� INTEGRITY_ERROR�쳣���ͱ�����
			raise INTEGRITY_ERROR;
		when too_many_rows then
			ERRNO  := -20003;
			ERRMSG := '����̫����';
			raise INTEGRITY_ERROR;
	end;

	--ǰ�˽�����ʾ�쳣
EXCEPTION
	WHEN INTEGRITY_ERROR THEN
		RAISE_APPLICATION_ERROR(ERRNO, ERRMSG);
	
END;
-------------------------------------------

--�Զ����쳣��Ϊ��ʾ��Ϣ�� 
DECLARE

	V_LSD LSD%ROWTYPE;

	INTEGRITY_ERROR Exception;
	ERRNO  Integer;
	ERRMSG Char(200);

BEGIN

	IF 1 = 1 THEN
		ERRNO  := -20003;
		ERRMSG := '1ȷʵ����1';
		Raise INTEGRITY_ERROR;
	END IF;

EXCEPTION
	WHEN INTEGRITY_ERROR THEN
		RAISE_APPLICATION_ERROR(ERRNO, ERRMSG);
	
END;
