SELECT prod.name, 
       CASE 
           WHEN prod.type = 'A' THEN 20.0
           WHEN prod.type = 'B' THEN 70.0
           WHEN prod.type = 'C' THEN 530.5
       END AS price
FROM products prod
GROUP BY prod.name, prod.type, prod.id
ORDER BY CASE prod.type
           WHEN 'A' THEN 1
           WHEN 'B' THEN 2
           WHEN 'C' THEN 3
         END,
        prod.id DESC;