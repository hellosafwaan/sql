select students.student_id, students.student_name, subjects.subject_name, count(examinations.student_id) as attended_exams
from students
    cross join subjects
    left join examinations on
        examinations.subject_name = subjects.subject_name and
        examinations.student_id = students.student_id
group by students.student_id, students.student_name, subjects.subject_name
order by students.student_id, subjects.subject_name;
