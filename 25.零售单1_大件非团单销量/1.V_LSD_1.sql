-- * �������ƣ���ѯ����ķ��ŵ����޸ߵµ��������ϸ�� * --

--TODO: ����Ҫ�޳��������ҵ�����,�޳�����ҵ�񲿻�Ҫȷ��


CREATE OR REPLACE VIEW V_LSD_1 AS
select a.*,
       b.group01, --�������:��Ϊר����,������...
       -----------
       (case
         when (sum(a.num01) over(partition by a.lsd01)) >= 5 then
          0
         else
          a.num01
       end) not_td_sale_num01 --�޳��ŵ���������

  from lsd a
  
  left join areafl b -- �����������,��ר����,������,���ǻ������,��ȫ������������
  on a.area01 = b.area01

 where a.area01 != 'GD_hw7' -- �ų��ߵµ�
      
     and a.date01 >= TRUNC(ADD_MONTHS(SYSDATE, -1), 'month')
     and a.date01 <= TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) --ɸѡ����
      
   and exists (select r.spfl01
          from spfl r
         where a.spfl01 = r.spfl01
           and r.spfl02 = '���') --ɸѡ����Ʒ:��spfl�ж����˴���ľ������,��ȫ������������
   
   and exists (select S.AREA01 from areafl s where a.area01=s.area01 and s.area_brand01='��Ϊ����')
