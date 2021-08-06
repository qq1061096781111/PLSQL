--计算地区运营商销量是否达标,达标为1,不达标为0

CREATE OR REPLACE VIEW V_PK_YYS_TASK_AREA AS

select a.area01,

       a.area_yys_task01, -- 门店运营商任务
       
       b.NX_NUM01, -- 门店粘性的销量
       
       --如果门店粘性销量 >= 门店运营商任务，则为1，否则为0
       (CASE
         WHEN b.NX_NUM01 >= a.area_yys_task01 THEN
          1
         ELSE
          0
       END) is_area_yys_dabiao01

  from area_yys_task a -- 地区运营商任务表：运营商模块中的任务设置里面进行维护

  left join V_YYS_AREA01_DATA b --用来赔地区的粘性销量
    on a.area01 = b.AREA01


