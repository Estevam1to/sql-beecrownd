SELECT r.temperature, COUNT(*) AS number_of_records
    FROM records r
    GROUP BY r.temperature, r.mark
    ORDER BY r.mark;