set nocount on

select *
from $(table_name)
order by 1
offset $(offset) rows fetch next $(limit) rows only