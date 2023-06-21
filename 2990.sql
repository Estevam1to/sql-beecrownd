SELECT emp.cpf, emp.enome, dp.dnome
    FROM empregados emp
    JOIN  departamentos dp ON emp.dnumero = dp.dnumero
    WHERE emp.cpf_supervisor IS NULL
    ORDER BY emp.cpf ASC;