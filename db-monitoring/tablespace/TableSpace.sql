-- Oracle数据库表空间大小检查
SELECT tablespace_name, file_name, bytes/1024/1024 AS MB
FROM dba_data_files;

-- 分区Segment使用的表空间在数据被DELETE后是可被重用
-- 执行TRUNCATE表之后才会释放分区Segment占用的表空间
SELECT tablespace_name, SUM(bytes)/1024/1024 AS used_mb
FROM dba_segments
GROUP BY tablespace_name;