WITH Subtable AS
(
    SELECT 
        *, COUNT(subject_name) AS attended_exams
    FROM 
        Examinations
    GROUP BY 
        student_id, subject_name
)

SELECT 
    t.student_id, t.student_name, s.subject_name, IFNULL(attended_exams, 0) AS attended_exams
FROM 
    Students t
    CROSS JOIN 
        Subjects s
    LEFT JOIN 
        Subtable sub 
            ON t.student_id = sub.student_id AND s.subject_name = sub.subject_name
ORDER BY 
    student_id, subject_name;