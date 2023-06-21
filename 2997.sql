SELECT d.nome AS "Departamento",
        salario.nome AS "Empregado",
        salario.bruto AS "Salario Bruto",
        salario.desconto AS "Total Desconto",
        salario.liquido AS "Salario Liquido"
    FROM (
        SELECT emp.matr, emp.nome, emp.lotacao,
        (
            SELECT SUM(COALESCE(v.valor, 0))
            FROM empregado empregado
            LEFT JOIN emp_venc ev ON empregado.matr = ev.matr
            LEFT JOIN vencimento v ON ev.cod_venc = v.cod_venc
            GROUP BY empregado.matr
            HAVING empregado.matr = emp.matr
        ) as bruto,
        (
            SELECT SUM(COALESCE(d.valor, 0))
            FROM empregado e2
            LEFT JOIN emp_desc ed ON e2.matr = ed.matr
            LEFT JOIN desconto d ON ed.cod_desc = d.cod_desc
            GROUP BY e2.matr
            HAVING e2.matr = emp.matr
        )as desconto,
        (
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
        ) AS liquido
      
        FROM empregado emp
        GROUP BY emp.matr, emp.nome, emp.lotacao
    ) AS salario
    LEFT JOIN departamento d ON salario.lotacao = d.cod_dep
    GROUP BY d.nome, salario.nome, salario.bruto, salario.liquido, salario.desconto
    ORDER BY "Salario Liquido" DESC, "Empregado" DESC;