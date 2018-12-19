BEGIN
  DECLARE @columns NVARCHAR(4000)
  
  create table #Temp
  (
    field nvarchar(255),
    msg   nvarchar(255)
  )

  INSERT INTO #Temp
  SELECT 'Field_1', 'Value_1'
  UNION ALL
  SELECT 'Field_2', 'Value_2'
  UNION ALL
  SELECT 'Field_3', 'Value_3'
  UNION ALL
  SELECT 'Field_4', 'Value_4'
  
  SELECT @columns =
         COALESCE(@columns + ',[' + CAST(Col.field AS NVARCHAR) + ']', '[' + CAST(Col.field AS NVARCHAR) + ']')
  FROM (SELECT field FROM #Temp) AS Col

  DECLARE @query1 VARCHAR(8000)
  SET @query1 = 'SELECT * FROM #Temp PIVOT (MAX(msg) for field IN (' + @columns + ')) AS PVT'
  EXEC (@query1)
end
