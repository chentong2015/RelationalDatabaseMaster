-- TODO. Case when 条件判断测试
-- name  course  core
-- chen  java    80
-- chen  cpp     78
-- xiao  js      56
-- xiao  cpp     90
-- tong  java    60
-- tong  cpp     70

-- 1. 先对课程的所有分数进行定级
-- course level
-- java   good
-- cpp    bad
-- js     bad
-- cpp    good
-- java   bad
-- cpp    bad

-- 2. 再分组统计"课程+级别"的数量
-- course level_text  count
-- java   bad         1
-- java   good        1
-- cpp    bad         2
-- cpp    good        1
-- js     bad         1

-- TODO. Group By时根据不同的Case值进行分组
select course,
  case
  when score < 80 then 'Bad'
  when score >= 80 then 'Good'
  end as level_text,
  count(*)
from STUDENTS
group by course,
  case
  when score < 80 then 'Bad'
  when score >= 80 then 'Good'
  end;