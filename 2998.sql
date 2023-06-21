SELECT
        C.NAME AS "name",
        C.INVESTMENT,
        SLS.MONTH as "month_of_payback",
        (LM.MIN_PROFIT - C.INVESTMENT) AS RETURN_ON_INVESTMENT
    FROM
        CLIENTS C
    JOIN (
        SELECT
            MIN(OPS.SUM_PROFIT) AS MIN_PROFIT,
            C.NAME
        FROM
            CLIENTS C
        JOIN (
            SELECT
                OP.CLIENT_ID,
                OP."month",
                SUM(OP2."profit") AS SUM_PROFIT
            FROM
                OPERATIONS OP
            JOIN
                OPERATIONS OP2 ON OP2."month" <= OP."month" AND OP2.CLIENT_ID = OP.CLIENT_ID
            GROUP BY
                OP.CLIENT_ID,
                OP."month"
            ORDER BY
                OP.CLIENT_ID,
                OP."month"
        ) OPS ON OPS.CLIENT_ID = C.ID
        WHERE
            OPS.SUM_PROFIT >= C.INVESTMENT
        GROUP BY
            C.NAME
    ) LM ON C.NAME = LM.NAME
    JOIN (
        SELECT
            OP.CLIENT_ID,
            OP."month",
            SUM(OP2."profit") AS SUM_PROFIT
        FROM
            OPERATIONS OP
        JOIN
            OPERATIONS OP2 ON OP2."month" <= OP."month" AND OP2.CLIENT_ID = OP.CLIENT_ID
        GROUP BY
            OP.CLIENT_ID,
            OP."month"
        ORDER BY
            OP.CLIENT_ID,
            OP."month"
    ) SLS ON SLS.CLIENT_ID = C.ID
    AND SLS.SUM_PROFIT = LM.MIN_PROFIT
    ORDER BY
        RETURN_ON_INVESTMENT DESC;