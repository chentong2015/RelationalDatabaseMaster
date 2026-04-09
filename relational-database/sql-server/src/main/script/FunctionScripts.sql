-- 调用SQL Server方法对字段值进行修剪
UPDATE T_SYAN set NAME = RTRIM(NAME) WHERE RIGHT(NAME, 1) = ' ';