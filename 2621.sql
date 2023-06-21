SELECT p.name
FROM products p
JOIN providers pro ON p.id_providers = pro.id
WHERE (p.amount > 10 AND p.amount < 20) AND pro.name LIKE 'P%';