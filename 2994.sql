SELECT
        doc.name,
        ROUND(
            SUM(
                att.hours * 150 * 
                CASE 
                    WHEN ws.name = 'nocturnal' THEN 1.15
                    WHEN ws.name = 'afternoon' THEN 1.02
                    WHEN ws.name = 'day' THEN 1.01
                    ELSE 1.0
                END
            ),
            1
        ) AS salary
    FROM
        doctors doc
    JOIN
        attendances att ON doc.id = att.id_doctor
    JOIN
        work_shifts ws ON ws.id = att.id_work_shift
    GROUP BY
        doc.id,
        doc.name
    ORDER BY
        salary DESC;