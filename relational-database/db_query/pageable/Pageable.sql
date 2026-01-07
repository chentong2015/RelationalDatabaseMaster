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
