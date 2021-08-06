--计算人员的粘性完成率,人员的匹配率
CREATE OR REPLACE VIEW V_YYS_NAME01_DATA AS

--第一步：确定要核算的人员,并关联人员任务,人员的粘性销量(电信和移动),大件的销量
WITH W1 AS
 (select a.name01, 
         
         b.ryxx_nx_task01, --人员的粘性任务
         
         a.telecom_and_mobile_nx_num01, --人员的电信和移动的粘性销量
         
         d.sale_num01 --人员的主机的销量,提出了团单,为大件产品的5个类别
  
    from  V_LSD_2_NAME01_DATA a-- 人员运营商的数据,匹配人员的粘性销量
  
    left join name_yys_task b -- 关联人员的粘性任务表,用来匹配人员任务
      on a.name01 = b.name01
  
    left join V_LSD_1_NAME01_DATA d --关联人员大件销量表, 用来匹配大件的销量
      on a.name01 = d.name01), 


--第二步：计算人员的匹配率，计算人员的粘性完成率
W2 AS
 (select w1.*,
         ----------------
         round((CASE
                 WHEN sale_num01 = 0 THEN
                  0
                 ELSE
                  telecom_and_mobile_nx_num01 / sale_num01
               END),
               4) ryxx_yys_ppl01, --人员的匹配率=粘性完成数量(电信+移动)/主机销量
         -----------------
         round((CASE
                 WHEN ryxx_nx_task01 = 0 or ryxx_nx_task01 is null THEN
                  1
                 ELSE
                  telecom_and_mobile_nx_num01 / ryxx_nx_task01
               END),
               4) ryxx_nx_wcl01 --人员的粘性完成率(电信+移动)
  
    from w1)

--最后看下人员的匹配率是否达标，看下个人匹配率是否>=0.22
SELECT W2.*,
       (CASE
         WHEN ryxx_yys_ppl01 >= 0.22 THEN
          1
         ELSE
          0
       END) PK_PPL01

  FROM W2
