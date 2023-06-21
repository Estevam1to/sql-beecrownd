SELECT p.name, round((p.salary * 0.1), 2) as tax
    FROM people p
    WHERE p.salary > 3000;