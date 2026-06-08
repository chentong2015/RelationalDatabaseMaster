-- TODO. SQL Server对于DISTINCT查询约束严格
-- ORDER BY items must appear in the select list if SELECT DISTINCT is specified.

SELECT DISTINCT
    kr1_0.id,
    kr1_0.oid,
    kr1_0.original_id,
    kr1_0.import_container_public_id,
    kr1_0.prefix,
    kr1_0.nam,
    kr1_0.ori,
    kr1_0.dsg,
    kr1_0.typ,
    kr1_0.bad,
    kr1_0.validated_date,
    kr1_0.expired_date,
    kr1_0.deleted_date
FROM
    KZ_RECORD kr1_0
LEFT JOIN
    EXECUTION_WORKFLOW ew1_0 ON ew1_0.id = kr1_0.wkf_execution_id
ORDER BY
    CASE WHEN (kr1_0.ori) IS NULL THEN 1 ELSE 0 END,
    7,
    CASE WHEN (kr1_0.oid) IS NULL THEN 1 ELSE 0 END,
    2