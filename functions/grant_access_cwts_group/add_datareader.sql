set nocount on

create user [$(login)] from login [$(login)]
go

alter role [db_datareader] add MEMBER [$(login)]
go
