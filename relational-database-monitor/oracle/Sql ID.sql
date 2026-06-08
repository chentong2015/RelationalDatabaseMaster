-- TODO 1. 查询特定用户所执行的语句(SQL ID + SQL Text)
-- v$sql表需要权限才能查询
SELECT s.sid, s.serial#, s.username, s.status, s.sql_id, q.sql_text
FROM v$session s
JOIN v$sql q ON s.sql_id = q.sql_id
WHERE s.username IS NOT NULL;

-- TODO 2. 然后通过SQL ID找到完整执行语句
SELECT sql_fulltext FROM v$sqlarea
WHERE sql_id = 'sql_id';

-- TODO 3. 查询特定SQL ID执行时间
SELECT sql_id,
       sql_fulltext,
       elapsed_time / 1e6 AS total_elapsed_seconds,
       executions,
       (elapsed_time / 1e6) / NULLIF(executions, 0) AS avg_elapsed_seconds
FROM v$sql
WHERE sql_id = 'sql_id';
-- AND sql_fulltext like '%count(levels)%' 过滤特定的查询语句