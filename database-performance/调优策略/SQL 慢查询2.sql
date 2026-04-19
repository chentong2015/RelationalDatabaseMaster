-- TODO. 使用多重Func计算 + 大表JOIN
-- COALESCE避免查询结果为NULL，确保返回一个默认值0
select coalesce(sum(case when ka1_0.is_main_address='N' then 1 else 0 end), 0)
from KZ_RECORD kr1_0
join KZ_ADDRESS ka1_0 on kr1_0.id=ka1_0.kz_record_id
where kr1_0.execution_public_id='b497b147'
and kr1_0.provider_action='ADD_NEW';

-- 优化大表JOIN查询，替换成EXISTS条件过滤，方便使用Index筛选
-- COUNT方法默认返回0，不存在返回NULL的异常情况
SELECT COUNT(*)
FROM KZ_ADDRESS A
WHERE A.is_main_address = 'N'
  AND EXISTS (
    SELECT 1
    FROM KZ_RECORD R
    WHERE R.id = A.kz_record_id
    AND R.execution_public_id = 'b497b147'
    AND R.provider_action = 'ADD_NEW'
);

--------------------------------------------------------------------------------
-- TODO. 多重Func计算 + JOIN大表 + 重复扫描
select coalesce(sum(case
   when ka1_0.is_main_address='N'
   and kr1_0.expired_date=TO_TIMESTAMP('3000-01-01 00:00:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF6')
   then 1 else 0 end), 0)
from KZ_ADDRESS ka1_0
join KZ_RECORD kr1_0 on kr1_0.id=ka1_0.kz_record_id
where kr1_0.original_id not in (
  select kr2_0.original_id
  from KZ_RECORD kr2_0
  where kr2_0.execution_public_id='b497b147'
)

-- 优化Func计算 + JOIN大表自身(取消重复扫描)
SELECT COUNT(*)
FROM KZ_ADDRESS ka1_0
JOIN KZ_RECORD kr1_0 ON kr1_0.id = ka1_0.kz_record_id
LEFT JOIN KZ_RECORD kr2_0
  ON kr2_0.original_id = kr1_0.original_id
  AND kr2_0.execution_public_id = 'b497b147'
WHERE ka1_0.is_main_address = 'N'
  AND kr1_0.expired_date = TO_TIMESTAMP('3000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
  And kr2_0.original_id IS NULL;