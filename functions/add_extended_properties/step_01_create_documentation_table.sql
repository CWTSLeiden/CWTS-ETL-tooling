set nocount on

if object_id('_documentation') is not null drop table _documentation
create table _documentation
(
	table_name  varchar(128),
	column_name varchar(64),
	description_type varchar(64),
	[description] nvarchar(max),
    notes nvarchar(max)
)
