SELECT DISTINCT
    d.nome AS nome_departamento,
    div.nome AS nome_divisao,
    ROUND(AVG(COALESCE(s.soma_valor, 0)), 2) AS media_valor,
    MAX(COALESCE(s.soma_valor, 0)) AS maior_valor
    FROM
        (
            SELECT DISTINCT
            emp_sal.matr,
            emp_sal.lotacao_div,
            SUM(COALESCE(emp_sal.valor, 0)) - COALESCE(des_sal.soma_desc, 0) AS soma_valor
            FROM
                (
                    SELECT 
                    emp.matr,
                    emp.lotacao,
                    emp.lotacao_div,
                    SUM(COALESCE(vnc.valor, 0)) AS valor
                    FROM
                        empregado emp
                        LEFT JOIN emp_venc emp_vnc ON emp.matr = emp_vnc.matr
                        LEFT JOIN vencimento vnc ON emp_vnc.cod_venc = vnc.cod_venc
                    GROUP BY
                        emp.matr, emp.lotacao, emp.lotacao_div
                ) emp_sal
                LEFT JOIN
                (
                    SELECT DISTINCT
                    emp.matr,
                    emp.lotacao_div,
                    SUM(dsc.valor) AS soma_desc
                    FROM
                        empregado emp
                        JOIN emp_desc emp_dsc ON emp.matr = emp_dsc.matr
                        JOIN desconto dsc ON emp_dsc.cod_desc = dsc.cod_desc
                    GROUP BY
                        emp.matr, emp.lotacao_div
                ) des_sal ON des_sal.matr = emp_sal.matr
            GROUP BY
                emp_sal.matr, emp_sal.lotacao_div, des_sal.soma_desc
        ) AS s
        LEFT JOIN divisao div ON s.lotacao_div = div.cod_divisao
        LEFT JOIN departamento d ON div.cod_dep = d.cod_dep
    GROUP BY
        nome_departamento, nome_divisao
    ORDER BY
        media_valor DESC;