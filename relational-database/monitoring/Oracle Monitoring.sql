-- Oracle自带的性能视图V$SYSMETRIC
-- 实时TPS视图: 每分钟或15秒滑动窗口内的平均TPS
SELECT metric_name, value FROM v$sysmetric
WHERE metric_name = 'User Transaction Per Sec' AND rownum = 1;

-- 显示当前连接的用户, SQL ID和正在执行的语句
SELECT s.sid, s.serial#, s.username, s.status, s.sql_id, q.sql_text
FROM v$session s
JOIN v$sql q ON s.sql_id = q.sql_id
WHERE s.username IS NOT NULL;

-- 然后通过sql_id找到完整的执行语句
SELECT sql_fulltext FROM v$sqlarea
WHERE sql_id = 'sql_id';

-- 找到执行慢的Query
SELECT sql_id, sql_fulltext,
       elapsed_time / 1e6 AS total_elapsed_seconds,
       executions,
       (elapsed_time / 1e6) / NULLIF(executions, 0) AS avg_elapsed_seconds
FROM v$sql
WHERE sql_id = 'sql_id';