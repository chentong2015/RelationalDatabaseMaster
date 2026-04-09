-- MySQL会追踪time zone用于有时间关联的functions
-- 可以在System Variables中看到
SELECT @@system_time_zone;
SELECT @@time_zone;

-- 重新设置时区
SET GLOBAL time_zone='+1:00'

-- transaction per second
-- 每秒事务量(每秒完成了多少commit), 在DB层面获取
show /* global */ status like ‘Question’;  -- Queries/seconds
show status like ‘Com_commit’;  -- Com_commit/seconds
show status like ‘Com_rollback’; -- Com_rollback/seconds