-- TODO. 先选择具有特定名称的表，然后执行所有Drop命令
select * from all_tables where table_name like 'TAB%'

select 'DROP TABLE "' || TABLE_NAME || '" CASCADE CONSTRAINTS PURGE;'
from all_tables
where TABLE_NAME like 'TAB%';

-- TODO. 遍历删除Oracle中所有用户创建的表
BEGIN
    FOR c IN (SELECT table_name FROM user_tables) LOOP
        EXECUTE IMMEDIATE ('DROP TABLE "' || c.table_name || '" CASCADE CONSTRAINTS');
    END LOOP;

    FOR s IN (SELECT sequence_name FROM user_sequences) LOOP
        EXECUTE IMMEDIATE ('DROP SEQUENCE ' || s.sequence_name);
    END LOOP;
END;
