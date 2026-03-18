TRUNCATE TABLE -- 只是删除表中数据: 注意可能存在外键导致无法删除
DROP TABLE     -- 删除表以及表中数据

-- Select 1 用于判断存在性, 兼容各种数据库
-- 返回查询常数1, 简单测试存在性, 语义更加明确, 性能可能更快
SELECT 1 FROM users WHERE email = 'test@example.com' LIMIT 1;

-- UNION 联合查询结果时必须保证字段一致
select id, name from tableA where id < 10
UNION
select id from tableA where id > 100;


-- 可以直接统计查询的离散字段
select DISTINCT id from tableA where status = 'updated';
select count(DISTINCT id) from tableA where status = 'updated';

-- select 0 空排序占位符: 等效于没有排序
select distinct id from tableA order by (select 0);