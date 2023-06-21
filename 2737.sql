SELECT name, customers_number 
    FROM (
        SELECT 1 as id, name, customers_number
        FROM lawyers
        WHERE customers_number = (SELECT MAX(customers_number) FROM lawyers)

        UNION

        SELECT 2 as id, name, customers_number
        FROM lawyers
        WHERE customers_number = (SELECT MIN(customers_number) FROM lawyers)

        UNION

        SELECT 3 as id, 'Average' as name, CAST(FLOOR(AVG(customers_number)) AS INTEGER) as customers_number
        FROM lawyers
    ) AS lawyers
    ORDER BY id;