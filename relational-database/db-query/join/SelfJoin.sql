-- TODO. Self JOIN 同一张表SELF JOIN
-- 1. 将表和自身JOIN级联，判断是否有数据异常
-- 2. 将表中不同行的数进行比较，

SELECT NEW_PATCH.ID
  from PATCH_MAIN NEW_PATCH
  INNER JOIN PATCH_MAIN OLD_PATCH
  ON NEW_PATCH.ID = OLD_PATCH.ID

  -- where条件将同一张表差分成两半，然后JOIN对比每组数据
  where NEW_PATCH.ID like '%-1'
  AND OLD_PATCH.ID like '%-0'
  AND (
     -- 判断是否在字段上有新的变化
     NEW_PATCH.BIC != OLD_PATCH.BIC OR
     NEW_PATCH.DOB != OLD_PATCH.DOB
  )
