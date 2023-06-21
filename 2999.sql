SELECT
        salario.nome AS "Empregado",
        salario.liquido AS "Salario"
    FROM (
        SELECT emp.matr, emp.nome, emp.lotacao, emp.lotacao_div,
        (
            SELECT SUM(COALESCE(v.valor, 0))
            FROM empregado empregado
            LEFT JOIN emp_venc ev ON empregado.matr = ev.matr
            LEFT JOIN vencimento v ON ev.cod_venc = v.cod_venc
            WHERE empregado.matr = emp.matr
        ) - (
            SELECT SUM(COALESCE(d.valor, 0))
            FROM empregado e2
            LEFT JOIN emp_desc ed ON e2.matr = ed.matr
            LEFT JOIN desconto d ON ed.cod_desc = d.cod_desc
            WHERE e2.matr = emp.matr
        ) AS liquido
        FROM empregado emp
        GROUP BY emp.matr, emp.nome, emp.lotacao, emp.lotacao_div
    ) AS salario
    LEFT JOIN departamento d ON salario.lotacao = d.cod_dep
    LEFT JOIN divisao div ON div.cod_dep = salario.lotacao_div
    GROUP BY salario.nome, salario.liquido, salario.lotacao_div
    HAVING AVG(salario.liquido) > 8000
    ORDER BY salario.lotacao_div ASC, salario.nome;