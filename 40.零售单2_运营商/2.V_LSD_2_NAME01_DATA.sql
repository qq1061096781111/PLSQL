--对V_LSD_PLUS02 进行透视,按地区汇总相关销量
CREATE OR REPLACE VIEW V_LSD_2_NAME01_DATA AS
select a.NAME01,

       sum(a.nx_num01) nx_num01, -- 人员粘性销量
       
       sum(a.telecom_nx_num01) telecom_nx_num01, --人员电信的粘性销量
       sum(a.mobile_nx_num01) mobile_nx_num01, -- 人员移动的粘性销量
       sum(a.unicom_nx_num01) unicom_nx_num01, --人员联通的粘性销量
       
       (sum(a.telecom_nx_num01) + sum(a.mobile_nx_num01)) telecom_and_mobile_nx_num01, --人员粘性完成量:电信和移动的粘性销量
       
       sum(a.two_SALES01) two_sales01, --人员副卡销量
       SUM(a.new_old_num01) new_old_num01, -- 人员移动户数:也就是新老用户销量,明细表中的移动购机补贴销量
       sum(a.young_SALES01) young_sales01 --人员青春卡销量
       
  from V_LSD_2 a
 group by a.NAME01
