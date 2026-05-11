-- TODO: V$SYSMETRIC性能视图
-- 实时TPS视图: 每分钟或15秒滑动窗口内的平均TPS
-- 测试Batch批量导入: 每秒平均执行的事务提交
SELECT metric_name, value
FROM v$sysmetric
WHERE metric_name = 'User Transaction Per Sec'
AND rownum = 1;

-- 查看Table(Insert, Update, Delete)更新次数
-- 分析事务提交次数(累计值)和活跃度
SELECT * FROM user_tab_modifications;