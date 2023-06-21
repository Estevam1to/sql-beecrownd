SELECT c.name, 
    ROUND(((x.math * 2 + x.specific * 3 + x.project_plan * 5)/10), 2) AS "avg"
    FROM candidate c
    JOIN score x ON c.id = x.candidate_id
    ORDER BY "avg" DESC;