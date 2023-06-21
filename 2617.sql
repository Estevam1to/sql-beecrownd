SELECT pr.name, p.name
FROM providers p
JOIN products pr ON p.id = pr.id_providers
WHERE p.name = 'Ajax SA';