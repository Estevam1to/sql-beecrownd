SELECT pkg.year, sender.name AS sender, receiver.name AS receiver
    FROM packages pkg
    JOIN users sender ON sender.id = pkg.id_user_sender
    JOIN users receiver ON receiver.id = pkg.id_user_receiver
    WHERE (pkg.year = 2015 OR pkg.color = 'blue')
    AND (sender.address != 'Taiwan' AND receiver.address != 'Taiwan')
    ORDER BY pkg.year DESC;