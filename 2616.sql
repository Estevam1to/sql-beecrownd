SELECT c.id, c.name
FROM customers c
WHERE c.id NOT IN (SELECT DISTINCT l.id_customers FROM locations l)
ORDER BY c.id;