SELECT p.name, LENGTH(p.name) as length
    FROM people p
    ORDER BY length DESC;