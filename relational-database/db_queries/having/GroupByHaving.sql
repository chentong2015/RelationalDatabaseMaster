-- TODO. Having 操作分组后的数据结果
select cat_id, count(order_id) as sales
from t_tab
where cat_id <> "c666"
group by cat_id
having count(order_id) > 10
order by count(order_id) desc
limit 100;

-- 查找所有分数都大于等于80的学生ID
select student_id from t_students
group by student_id
having min(score) >= 80; -- 对分组后的数据进行筛选判断

-- 选择重复信息的列
select name, email count(*) as nums from users
group by name, email
having count(*) > 1;

select alter_id from records
group by alter_id
having count(alter_id) > 1;