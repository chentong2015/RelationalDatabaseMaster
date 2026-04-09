-- TODO. 删除指定名称前缀的表: 有外键无法删除
DECLARE @sql NVARCHAR(MAX) = N'';

SELECT @sql += 'DROP TABLE [' + s.name + '].[' + t.name + '];' + CHAR(13)
FROM sys.tables t
    JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE t.name LIKE 'PREFIX_%';
PRINT @sql;
EXEC sp_executesql @sql;


-- Drop all tables
DECLARE @name VARCHAR(128)
DECLARE @SQL VARCHAR(254)

SELECT @name = (SELECT TOP 1 [name] FROM sysobjects WHERE [type] = 'U' AND category = 0 ORDER BY [name])
    WHILE @name IS NOT NULL
BEGIN
SELECT @SQL = 'DROP TABLE [dbo].[' + RTRIM(@name) +']'
    EXEC (@SQL)
    PRINT 'Dropped Table: ' + @name
SELECT @name = (SELECT TOP 1 [name] FROM sysobjects WHERE [type] = 'U' AND category = 0 AND [name] > @name ORDER BY [name])
END
GO
