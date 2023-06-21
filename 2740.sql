SELECT name
    FROM (
        (
            SELECT CONCAT('Podium: ', l.team) AS name, l.position
            FROM league l
            WHERE l.position <= 3
        )
        UNION 
        (
            SELECT CONCAT('Demoted: ', l.team) AS name, l.position
            FROM league l
            ORDER BY POSITION DESC LIMIT 2
        )
    ) AS sb
    ORDER BY SUBSTRING(name, 1, 1) DESC, sb.position ASC;