


--select * from ClinicalData

drop table if exists #1

--select * from ClinicalData

select * from INFORMATION_SCHEMA.columns where TABLE_NAME like 'ClinicalData'

select column_name,ordinal_position, data_type, character_maximum_length into #1
from INFORMATION_SCHEMA.columns where TABLE_NAME like 'ClinicalData'

select * from #1

alter table #1 add maximum nvarchar(max)
alter table #1 add minimum nvarchar(max)
alter table #1 add nulls int
alter table #1 add distinct_count int
alter table #1 add mean float
alter table #1 add median float
alter table #1 add mode nvarchar(max)
alter table #1 add SD float
alter table #1 add Zero_Values int

--------------------------------------------------------

declare @i int=1
declare @j int

set @j = (select max(ordinal_position) from #1)

declare @columnname nvarchar(max)
declare @datatype nvarchar(max)

declare @sql nvarchar(max)

while @i<=@j 
begin

select @columnname= column_name,@datatype = data_type from #1 where ORDINAL_POSITION = @i


  -- Handle numeric columns
    IF @dataType IN ('int', 'float', 'real', 'decimal', 'numeric', 'money', 'smallint', 'tinyint')
    BEGIN
        -- Construct the dynamic SQL for calculating max, min, mean, stddev, nulls, distinct count, and zero count
        SET @sql = 'update #1 SET Maximum = (SELECT MAX(' + @columnName + ') FROM ClinicalData) WHERE ordinal_position = ' + CAST(@i AS VARCHAR(MAX))
        EXEC sp_executesql @sql

        SET @sql = 'update #1 SET Minimum = (SELECT MIN(' + @columnName + ') FROM ClinicalData) WHERE ordinal_position = ' + CAST(@i AS VARCHAR(MAX))
        EXEC sp_executesql @sql

        SET @sql = 'update #1 SET Mean = (SELECT AVG(cast(' + @columnName + ' as bigint)) FROM ClinicalData) WHERE ordinal_position = ' + CAST(@i AS VARCHAR(MAX))
        EXEC sp_executesql @sql

        SET @sql = 'update #1 SET Sd = (SELECT STDEV(' + @columnName + ') FROM ClinicalData) WHERE ordinal_position = ' + CAST(@i AS VARCHAR(MAX))
        EXEC sp_executesql @sql

        SET @sql = 'update #1 SET Nulls = (SELECT COUNT(*) FROM ClinicalData WHERE ' + @columnName + ' IS NULL) WHERE ordinal_position = ' + CAST(@i AS VARCHAR(MAX))
        EXEC sp_executesql @sql

        SET @sql = 'update #1 SET Zero_values = (SELECT COUNT(*) FROM ClinicalData WHERE ' + @columnName + ' = 0) WHERE ordinal_position = ' + CAST(@i AS VARCHAR(MAX))
        EXEC sp_executesql @sql

		SET @sql = 'UPDATE #1 SET distinct_count = (SELECT COUNT(DISTINCT ' + @columnName + ') FROM ClinicalData) WHERE ordinal_position = ' + CAST(@i AS VARCHAR(MAX))
        EXEC sp_executesql @sql

		SET @sql = 'update #1 SET mode = (select string_agg( ' + @columnName + ', '','') from
(select ' + @columnname + ',DENSE_RANK() over(order by[count all] desc)[dr] from 
(select ' + @columnname + ',count(*) [count all] from ClinicalData
group by ' + @columnname + ')x)Y where dr=1) where ordinal_position = ' + CAST(@i AS VARCHAR(MAX))
 EXEC sp_executesql @sql


		SET @sql = '
		
select * from ClinicalData

select ' + @columnname + ', row_number() over(order by ' + @columnname + ')[rn] into #2 from ClinicalData

---select * from #2
--Even Records
--8
--8/2=4
--4+1=5

--odd Records

declare @1 int
declare @m int, @n int, @x float


set @1 = (select max(rn) from #2)
set @m = @1%2---remainder
set @n=  @1/2 --integral quotient

if @m =0 --even num of records
begin 
set @x = (select avg(' + @columnname + ') from #2 where rn in (@n,@n+1)) 
end 

if @m<>0 -- odd num of Records 
begin 
set @x = (select ' + @columnname + ' from #2 where rn = @n+1)
end

update #1 set median = @x where ordinal_position = ' + CAST(@i AS VARCHAR(MAX))

EXEC sp_executesql @sql

end

 -- Handle date columns
    IF @dataType IN ('date', 'datetime', 'datetime2', 'smalldatetime', 'time')
    BEGIN
        -- Calculate max and min
        SET @sql = 'update #1 SET Maximum = (SELECT MAX(' + @columnName + ') FROM ClinicalData) WHERE ordinal_position = ' + CAST(@i AS VARCHAR(MAX));
        EXEC sp_executesql @sql;

        SET @sql = 'update #1 SET Minimum = (SELECT MIN(' + @columnName + ') FROM ClinicalData) WHERE ordinal_position = ' + CAST(@i AS VARCHAR(MAX));
        EXEC sp_executesql @sql;

        -- Nulls and distinct counts
        SET @sql = 'update #1 SET Nulls = (SELECT COUNT(*) FROM ClinicalData WHERE ' + @columnName + ' IS NULL) WHERE ordinal_position = ' + CAST(@i AS VARCHAR(MAX));
        EXEC sp_executesql @sql;

        SET @sql = 'update #1 SET Distinct_Count = (SELECT COUNT(DISTINCT ' + @columnName + ') FROM ClinicalData) WHERE ordinal_position = ' + CAST(@i AS VARCHAR(MAX));
        EXEC sp_executesql @sql;

        -- Count zero values for dates (assuming a specific zero date, e.g., '1900-01-01')
        SET @sql = 'update #1 SET Zero_Count = (SELECT COUNT(*) FROM ClinicalData WHERE ' + @columnName + ' = ''1900-01-01'') WHERE ordinal_position = ' + CAST(@i AS VARCHAR(MAX));
        EXEC sp_executesql @sql;

        -- Add logic for Mode
        SET @sql = 'update #1 SET mode = (select string_agg( ' + @columnName + ', '','') from
(select ' + @columnname + ',DENSE_RANK() over(order by[count all] desc)[dr] from 
(select ' + @columnname + ',count(*) [count all] from ClinicalData
group by ' + @columnname + ')x)Y where dr=1) where ordinal_position = ' + CAST(@i AS VARCHAR(MAX))
 EXEC sp_executesql @sql
    END

    -- Handle non-numeric columns for max and min
    IF @dataType IN ('varchar', 'nvarchar', 'text', 'char', 'nchar')
    BEGIN
        SET @sql = 'update #1 SET Maximum = (SELECT MAX(' + @columnName + ') FROM ClinicalData) WHERE ordinal_position = ' + CAST(@i AS VARCHAR(MAX))
        EXEC sp_executesql @sql

        SET @sql = 'update #1 SET Minimum = (SELECT MIN(' + @columnName + ') FROM ClinicalData) WHERE ordinal_position = ' + CAST(@i AS VARCHAR(MAX))
        EXEC sp_executesql @sql
     
        -- Nulls and distinct counts
        SET @sql = 'update #1 SET Nulls = (SELECT COUNT(*) FROM ClinicalData WHERE ' + @columnName + ' IS NULL) WHERE ordinal_position = ' + CAST(@i AS VARCHAR(MAX));
        EXEC sp_executesql @sql;

        SET @sql = 'update #1 SET distinct_count = (SELECT COUNT(DISTINCT ' + @columnName + ') FROM ClinicalData) WHERE ordinal_position = ' + CAST(@i AS VARCHAR(MAX));
        EXEC sp_executesql @sql;

        SET @sql = 'update #1 SET Zero_values = (SELECT COUNT(*) FROM ClinicalData WHERE ' + @columnName + ' = ''0'') WHERE ordinal_position = ' + CAST(@i AS VARCHAR(MAX));
        EXEC sp_executesql @sql;

		SET @sql = 'update #1 SET mode = (select string_agg( ' + @columnName + ', '','') from
(select ' + @columnname + ',DENSE_RANK() over(order by[count all] desc)[dr] from 
(select ' + @columnname + ',count(*) [count all] from ClinicalData
group by ' + @columnname + ')x)Y where dr=1) where ordinal_position = ' + CAST(@i AS VARCHAR(MAX))
 EXEC sp_executesql @sql
    END

	 -- Handle non-numeric columns for max and min
    IF @dataType IN ('bit')
    BEGIN
     
        -- Nulls and distinct counts
        SET @sql = 'update #1 SET Nulls = (SELECT COUNT(*) FROM ClinicalData WHERE ' + @columnName + ' IS NULL) WHERE ordinal_position = ' + CAST(@i AS VARCHAR(MAX));
        EXEC sp_executesql @sql;

        SET @sql = 'update #1 SET distinct_count = (SELECT COUNT(DISTINCT ' + @columnName + ') FROM ClinicalData) WHERE ordinal_position = ' + CAST(@i AS VARCHAR(MAX));
        EXEC sp_executesql @sql;

        SET @sql = 'update #1 SET Zero_values = (SELECT COUNT(*) FROM ClinicalData WHERE ' + @columnName + ' = ''0'') WHERE ordinal_position = ' + CAST(@i AS VARCHAR(MAX));
        EXEC sp_executesql @sql;

		SET @sql = 'update #1 SET mode = (select string_agg( ' + @columnName + ', '','') from
(select ' + @columnname + ',DENSE_RANK() over(order by[count all] desc)[dr] from 
(select ' + @columnname + ',count(*) [count all] from ClinicalData
group by ' + @columnname + ')x)Y where dr=1) where ordinal_position = ' + CAST(@i AS VARCHAR(MAX))
 EXEC sp_executesql @sql
    END


set @i= @i+1
end