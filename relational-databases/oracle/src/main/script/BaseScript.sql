-- 设置允许脚本时的参数
DEFINE TS_DATA = &1;

-- 表名和字段名全部大写
CREATE TABLE T_BATCHING_COMMENT (
   ID NUMBER PRIMARY KEY,
   REVIEW VARCHAR2(30) -- 字符串为VARCHAR2
) tablespace &TS_DATA; -- 存储到特定表空间管理

-- 调用定义的含参数的Procedure
-- call procedure_name ('', '') into ..

-- 查找用户自定义的对象或者是方法
SELECT * FROM user_procedures
select * from table where rownum <= 100; -- 返回行数在前100的数据
select * from record where NVL(col1, 'NULL') -- Oracle空字段值的判断

select * from USER_OBJECTS
select count(1) from USER_OBJECTS where OBJECT_TYPE = 'FUNCTION' and OBJECT_NAME = 'Procedure_name'
select table_name from all_tables where table_name = '%s'; -- 判断指定的表名称是否存在
select value from v$sysstat where name='user commits' -- 统计指定时间段内的提交量

-- TODO. 对特殊字符进行转义后存储
INSERT INTO customer (id, customer_name) VALUES (11, 'ABC'' Company');