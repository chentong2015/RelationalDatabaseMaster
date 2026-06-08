-- TODO. 查询字段必须出现在group by分组选项中
-- 添加新column列之后，必须考虑字段是否在分组查询字段中使用 !!

SELECT
    ka1_0.id,
    ka1_0.oid,
    ka1_0.is_main_address,
    ka1_0.city,
    ka1_0.country,
    ka1_0.street,
    -- fileds...
    ka1_0.checksum,
    ka1_0.wkf_execution_public_id
FROM KZ_ADDRESS ka1_0
JOIN KZ_RECORD kr1_0 ON kr1_0.id = ka1_0.kz_record_id
JOIN EXECUTION_WORKFLOW ew1_0 ON ew1_0.id = kr1_0.wkf_execution_id
JOIN BIC_LOOKUP_ADDRESS_HIT bclah1_0 ON ka1_0.oid = bclah1_0.address_oid
JOIN BIC_CODE_LOOK_UP_EXECUTION bclue1_0 ON bclue1_0.id = bclah1_0.bic_code_look_up_execution_id
WHERE
  kr1_0.review_status IN ('DEFAULT', 'DRAFT_EDITION')
  AND kr1_0.import_container_public_id = '0575eaf0-f7e0-4fac-9ea3-6e8d1c6eed8b'
  AND bclah1_0.address_oid = ka1_0.oid
  AND bclah1_0.has_new_or_lost = 'Y'
GROUP BY
    kr1_0.oid, -- 支持额外的分组字段
    kr1_0.nam, -- 该字段不作为返回结果字段
    ka1_0.id,
    ka1_0.oid,
    ka1_0.is_main_address,
    ka1_0.city,
    ka1_0.country,
    ka1_0.street,
    -- fileds...
    ka1_0.checksum,
    ka1_0.wkf_execution_public_id
ORDER BY
    CASE
        WHEN (ka1_0.oid) IS NULL THEN 1
    ELSE 0
    END,
    ka1_0.oid