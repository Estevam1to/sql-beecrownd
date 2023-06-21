SELECT t.name AS nome,
    COUNT(m.id) AS partidas,
    SUM(CASE WHEN m.team_1 = t.id AND m.team_1_goals > m.team_2_goals THEN 1
             WHEN m.team_2 = t.id AND m.team_2_goals > m.team_1_goals THEN 1
             ELSE 0
        END) AS vitorias,
    SUM(CASE WHEN m.team_1 = t.id AND m.team_1_goals < m.team_2_goals THEN 1
             WHEN m.team_2 = t.id AND m.team_2_goals < m.team_1_goals THEN 1
             ELSE 0
        END) AS derrotas,
    SUM(CASE WHEN m.team_1 = t.id AND m.team_1_goals = m.team_2_goals THEN 1
             WHEN m.team_2 = t.id AND m.team_2_goals = m.team_1_goals THEN 1
             ELSE 0
        END) AS empates,
    (SUM(CASE WHEN m.team_1 = t.id AND m.team_1_goals > m.team_2_goals THEN 3
             WHEN m.team_2 = t.id AND m.team_2_goals > m.team_1_goals THEN 3
             WHEN m.team_1 = t.id AND m.team_1_goals = m.team_2_goals THEN 1
             WHEN m.team_2 = t.id AND m.team_2_goals = m.team_1_goals THEN 1
             ELSE 0
        END)) AS pontuacao
    FROM teams t
    LEFT JOIN matches m ON t.id = m.team_1 OR t.id = m.team_2
    GROUP BY t.name
    ORDER BY pontuacao DESC;