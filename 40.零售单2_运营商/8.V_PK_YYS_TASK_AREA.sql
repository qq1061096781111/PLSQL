--���������Ӫ�������Ƿ���,���Ϊ1,�����Ϊ0

CREATE OR REPLACE VIEW V_PK_YYS_TASK_AREA AS

select a.area01,

       a.area_yys_task01, -- �ŵ���Ӫ������
       
       b.NX_NUM01, -- �ŵ�ճ�Ե�����
       
       --����ŵ�ճ������ >= �ŵ���Ӫ��������Ϊ1������Ϊ0
       (CASE
         WHEN b.NX_NUM01 >= a.area_yys_task01 THEN
          1
         ELSE
          0
       END) is_area_yys_dabiao01

  from area_yys_task a -- ������Ӫ���������Ӫ��ģ���е����������������ά��

  left join V_YYS_AREA01_DATA b --�����������ճ������
    on a.area01 = b.AREA01


