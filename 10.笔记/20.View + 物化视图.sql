��ͼ�Ļ����ṹ

CREATE OR REPLACE VIEW VIEW_��ͼ���� AS
select


---------------------------------------

����: �ﻯ��ͼ

��һ��: ��dba�ʻ�����ǰ�û���Ȩ
 grant create materialized view to gzscm; 

�ڶ���: ��ʼ��д�ﻯ��ͼ  
 create materialized view  mv_name
 refresh force
 on demand
 start with sysdate   --����������ִ�е�һ�β�ѯ
 
 --����������䲻���ں�������ע��,����ִ�в���,���������˼���Ժ�ÿ���賿1��ִ�в�ѯ
 next to_date(concat(to_char(sysdate+1,'dd-mm-yyyy'),'01:00:00'),'dd-mm-yyyy hh24:mi:ss') 
 as 
 
select * from lsd; --���治�ӷֺ�Ҳ����,�ﻯ��ͼ���ֶ��в������Ӳ�ѯ

------------------------

ɾ���ﻯ��ͼ��

drop materialized view mv_name





