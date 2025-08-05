


--select * from clinicalData

select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME like 'clinicalData'


declare @i int = 1
declare @sql nvarchar(max)
declare @j int

set @j = (select max(ordinal_position) from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME like 'clinicalData')
declare @columnname varchar(max)

while @i<=@j
begin

set @columnname = (select column_name from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME like 'clinicalData' and ORDINAL_POSITION = @i)

set @sql = 'select ' + @columnname + ' ,count(*) [Frequency] from clinicalData group by ' +  @columnname + ' order by count(*) desc'

exec sp_executesql @sql

set @i = @i + 1
end
