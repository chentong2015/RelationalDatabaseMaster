-- TODO. 典型慢SQL查询语句
-- 1. LEFT JOIN 大表极慢，导致执行计划使用Hash Join或Nested Loop
-- 2. In (SELECT DISTINCT 无法走索引，数据量大时效率低下
-- 3. kz_record 大表被查询两次，操作重复扫描
-- 4. AND fields 多字段条件扫描，没有复合索引，过滤成本大

SELECT Count(kr1_0.id)
FROM kz_record kr1_0
WHERE kr1_0.id IN (
   SELECT DISTINCT kr2_0.id FROM kz_record kr2_0
   LEFT JOIN record_with_issues rwi1_0 ON kr2_0.execution_public_id = rwi1_0.execution_public_id
   LEFT JOIN validation_errors ve1_0 ON rwi1_0.id = ve1_0.record_with_issues_id
   WHERE kr1_0.execution_public_id = :1
         AND kr1_0.id = rwi1_0.kz_record_id
         AND kr1_0.deleted_date = :2
         AND kr1_0.expired_date = :3
         AND ve1_0.criticity IN ( :4 )
         AND ve1_0.expired_date = :5
         AND ve1_0.validated_date = :6
         AND ve1_0.expired_date = :7
         AND rwi1_0.origin = :8
   )