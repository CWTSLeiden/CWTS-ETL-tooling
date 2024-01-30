set nocount on

exec drop_extended_properties '$(db_name)'

declare @input_table as add_extended_properties_input_table
insert into @input_table(table_name, column_name, description_type, [description])
select
    table_name,
    column_name,
    description_type,
    [description]
from $(db_name).._documentation
where [description] is not null

exec add_extended_properties '$(db_name)', @input_table
