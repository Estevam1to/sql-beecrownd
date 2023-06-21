SELECT p.name, f.name, c.name
FROM products p
JOIN providers f ON p.id_providers = f.id
JOIN categories c ON p.id_categories = c.id
WHERE c.name = 'Imported' AND f.name = 'Sansul SA';