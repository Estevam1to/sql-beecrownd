SELECT l.name, ROUND((l.omega * 1.618), 3) AS "The N Factor"
    FROM life_registry l
    JOIN dimensions d ON d.id = l.dimensions_id
    WHERE d.name IN ('C875', 'C774') AND l.name LIKE 'Richard%'
    ORDER BY l.omega ASC;