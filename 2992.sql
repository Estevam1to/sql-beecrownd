SELECT departamento, divisao, media
    FROM (
        SELECT d.nome AS departamento, div.nome AS divisao, ROUND(AVG(liquido.salario), 2) AS media,
        ROW_NUMBER() OVER (PARTITION BY d.cod_dep ORDER BY AVG(liquido.salario) DESC) AS row_num
        FROM (
            SELECT e.matr, e.nome, e.lotacao, e.lotacao_div,
            (
                SELECT SUM(COALESCE(v.valor, 0))
                FROM empregado e2
                LEFT JOIN emp_venc ev ON e.matr = ev.matr
                LEFT JOIN vencimento v ON v.cod_venc = ev.cod_venc
                WHERE e2.matr = e.matr
            ) - (
                SELECT SUM(COALESCE(d.valor, 0))
                FROM empregado e2
                LEFT JOIN emp_desc ed ON e.matr = ed.matr
                LEFT JOIN desconto d ON d.cod_desc = ed.cod_desc
                WHERE e2.matr = e.matr
            ) AS salario
            FROM empregado e
            GROUP BY e.matr, e.nome, e.lotacao, e.lotacao_div
        ) AS liquido
        LEFT JOIN divisao div ON liquido.lotacao_div = div.cod_divisao
        LEFT JOIN departamento d ON d.cod_dep = div.cod_dep
        GROUP BY d.cod_dep, d.nome, div.cod_divisao, div.nome
    ) AS subquery
    WHERE row_num = 1
    ORDER BY media DESC;