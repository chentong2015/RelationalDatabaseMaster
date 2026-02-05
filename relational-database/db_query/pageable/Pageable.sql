-- TODO. 分页查询语句: 不同DB可能存在差异,
-- offset偏移量(Page整数倍) + Page Size查询行数

-- SQL Server 默认添加version排序
select p1_0.id, p1_0.description, p1_0.discount, p1_0.location, p1_0.name, p1_0.price, p1_0.url
from t_product p1_0
where p1_0.price > ?
order by @@version
offset ? rows
fetch first ? rows only

-- Oracle 推荐自定义添加Order字符排序，避免随机片段
select p1_0.id, p1_0.description, p1_0.discount, p1_0.location, p1_0.name, p1_0.price, p1_0.url
from t_product p1_0
where p1_0.price > ?
order by p1_0.id
offset ? rows
fetch first ? rows only

-- TODO. 分页查询优化:
-- 偏移量很大会导致查询性能下降: 避免使用偏移，记录上次查询的最大ID
where id > ? order by id fetch first ? rows only

-- 对于需要获取查询总数的请求: 将查询统计并发执行
select count(id) from large_table