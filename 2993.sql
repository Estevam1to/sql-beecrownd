SELECT vt.amount AS most_frequent_value 
    FROM value_table vt 
    GROUP BY vt.amount
    ORDER BY COUNT(vt.amount) DESC
    LIMIT 1;