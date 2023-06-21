SELECT d.nome AS "Nome Departamento",
    COUNT(liquido.nome) AS "Numero de Empregados",
    ROUND(AVG(liquido.salario), 2) AS "Media Salarial",
    MAX(liquido.salario) AS "Maior Salario",
    MIN(liquido.salario) AS "Menor Salario"
    FROM (
        SELECT emp.matr, emp.nome, emp.lotacao, (
        SELECT SUM(COALESCE(v.valor, 0))
        FROM empregado empregado
        LEFT JOIN emp_venc ev ON empregado.matr = ev.matr
        LEFT JOIN vencimento v ON ev.cod_venc = v.cod_venc
        GROUP BY empregado.matr
        HAVING empregado.matr = emp.matr
        ) - (
        SELECT SUM(COALESCE(d.valor, 0))
        FROM empregado e2
        LEFT JOIN emp_desc ed ON e2.matr = ed.matr
        LEFT JOIN desconto d ON ed.cod_desc = d.cod_desc
        GROUP BY e2.matr
        HAVING e2.matr = emp.matr
        ) AS salario
        FROM empregado emp
        GROUP BY emp.matr, emp.nome, emp.lotacao
    ) AS liquido
    LEFT JOIN departamento d ON liquido.lotacao = d.cod_dep
    GROUP BY d.nome
    ORDER BY "Media Salarial" DESC;