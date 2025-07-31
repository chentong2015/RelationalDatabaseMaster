TRUNCATE TABLE -- 只是删除表中所的数据，并不会删除表本省
DROP TABLE     -- 删除表以及表中的所有数据

-- TODO. Select 1 用于判断存在性, 不关系具体数据
-- 返回查询常数1,	测试存在性/性能优化/简单测试
-- 查询的语义更加明确, 性能可能会更快
SELECT 1 FROM users WHERE email = 'test@example.com' LIMIT 1;

-- UNION联合查询结果时必须保证字段一致
select id, name from tableA where id < 10
UNION
select id from tableA where id > 100;

-- 只统计离散数据的数量
select count(DISTINCT id) from tableA where status = 'updated';
