SELECT a.id, a.password,MD5(a.password) 
    FROM account a;