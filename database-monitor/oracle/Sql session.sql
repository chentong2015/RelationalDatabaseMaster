-- 查询特定用户Session所执行语句
select sid, serial#, sql_id, event, state, status
from v$session
where username='LS_ALL';

-- 通过SQL ID找到完整执行语句(数据库已经接收)
select sql_text from v$sql where sql_id = '6kxxxxxx';
SELECT sql_fulltext FROM v$sqlarea WHERE sql_id = 'sql_id';

-- 查询特定SQL ID执行时间
SELECT sql_id, sql_fulltext,  executions,
       elapsed_time / 1e6 AS total_elapsed_seconds,
       (elapsed_time / 1e6) / NULLIF(executions, 0) AS avg_elapsed_seconds
FROM v$sql
WHERE sql_id = 'sql_id'
AND sql_fulltext like '%count(levels)%';

-- 终止某个特定Session(需要权限)
ALTER SYSTEM KILL SESSION 'sid,serial#' EXECUTE IMMEDIATE;