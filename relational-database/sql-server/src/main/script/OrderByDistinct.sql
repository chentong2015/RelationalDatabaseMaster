-- TODO. SQL Server查询: [ORDER BY items must appear in the select list if SELECT DISTINCT is specified.]
-- select distinct必须添加order by排序, 且排序字段必须在select list列表中
select distinct id from tableA order by id;