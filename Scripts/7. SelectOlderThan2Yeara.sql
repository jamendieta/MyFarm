SELECT AnimalId, Name, Breed, BirthDate, Sex, Price, Status
FROM Animals WITH(NOLOCK)
WHERE BirthDate <= DATEADD(YEAR, -2, GETDATE()) 
    AND Sex = 0
ORDER BY Name ASC;