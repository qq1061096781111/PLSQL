/*���ܣ�͸�ӻ��յ���ά�ȣ������������棻���ݣ�4%��ɣ�2%��ɣ���������**************

ҵ���߼��������Ϊ�յ�ɸѡ����������˶�Ҫ��������

***********************************************************************/


CREATE OR REPLACE VIEW V_HSD_1_NAME01_DATA AS 
select name01,sum(AMOUNT01) amount01, sum(hs_num01) hs_num01, sum(tc) tc, (listagg( HSD01, ',') within group(order by HSD01)) hsd01
  from V_HSD_1 a
 group by name01
 
 

