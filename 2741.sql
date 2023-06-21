SELECT CONCAT('Approved: ', s.name), s.grade
    FROM students s
    WHERE s.grade >= 7
    ORDER BY s.grade DESC;