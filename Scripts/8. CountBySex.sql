SELECT
    CASE Sex
        WHEN 0 THEN 'Female'
        WHEN 1 THEN 'Male'
        ELSE 'Unknown'
    END AS Sex,
    COUNT(*) AS Quantity
FROM Animals
GROUP BY Sex;
