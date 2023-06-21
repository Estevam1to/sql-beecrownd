SELECT l.name, CAST(DATE_PART('day', l.payday) AS INTEGER) AS "day"
    FROM loan l
    WHERE l.payday IS NOT NULL;