-- TODO: Oracle性能视图V$SYSMETRIC
-- 实时TPS视图: 每分钟或15秒滑动窗口内的平均TPS
-- 测试Batch批量导入: 每秒平均执行的事务提交
SELECT metric_name, value
FROM v$sysmetric
WHERE metric_name = 'User Transaction Per Sec'
AND rownum = 1;