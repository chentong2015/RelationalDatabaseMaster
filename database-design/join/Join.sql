-- TODO. 如何联合查询数据库的多张表 ?
-- SELECT    查询完一张表，再使用查询的结果执行另一个sql(select查询另外一张表)
-- SUBSELECT 在同一个sql查询中将select子查询放置到where条件查询中
-- JOIN      在同一个sql查询中使用join on联合多张表

-- TODO. Join聚合查询性能分析
select t1.id, t1.xxx, t2.xxx from t1
  left join t2
  on t1.id = t2.id and t1.id < 10; -- 与后者等效性能

select t1.id, t1.xxx, t2.xxx from t1
  left join t2
  on t1.id = t2.id
  where t1.id < 10; -- 在Join完之后进行额外where条件筛选

select tmp_t1.id, tmp_t1.xxx, t2.xxx
  from (
    select * from t1 where t1.id < 10
  ) tmp_t1
  left join t2
  on tmp_t1.id = t2.id; -- 使用过滤表来进行JOIN查询

-- TODO. JOIN查询的基本算法
-- Nested Loop Join
-- 从一张表(驱动表)循环读行，然后根据关联字段从另外一张表(被驱动表)提取满足的行，然后取出两个表的结果合集
--
-- Block Nested Loop Join
-- 把原始驱动表的数据读取到join_buffer中，然后扫描被驱动表，从被驱动表中提取每一行和join_buffer中的数据对比