set nocount on

select
    table_name = a.[name],
    column_name = b.[name],
    data_type = c.[name],
    data_length = b.max_length,
    is_nullable = b.is_nullable,
    description = d.[value]
from sys.tables as a
join sys.columns as b on a.object_id = b.object_id
join sys.types as c on b.user_type_id = c.user_type_id
left join sys.extended_properties as d on b.object_id = d.major_id and b.[name] = d.[name]
where a.[name] = '$(table_name)' and isnull(d.minor_id, -1) <> 0
order by b.column_id
