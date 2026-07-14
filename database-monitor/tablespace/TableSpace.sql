-- Oracle数据库表空间大小检查
SELECT tablespace_name, file_name, bytes/1024/1024 AS MB
FROM dba_data_files;

-- 分区Segment表空间在数据被DELETE后可被重用
-- 分区Segment表空间在执行TRUNCATE表后自动释放
SELECT tablespace_name, SUM(bytes)/1024/1024 AS used_mb
FROM dba_segments GROUP BY tablespace_name;