select distinct product_id, new_price as price
from Products
where (product_id, change_date) in (
    -- 首先筛选有16号前变化日期的ID
    -- 分组后取Group中最大日期作为有效数据值
    -- 根据ID+Date唯一确定行并找到价格
    select product_id, max(change_date)
    from Products
    where change_date <= '2019-08-16'
    group by product_id
)
union
-- 取其它变化时间超过指定日期的默认数据
select product_id, 10 as price
from Products
group by product_id
having min(change_date) > '2019-08-16'