create or alter function [dbo].[Client_Visit_History](@Client_Info [varchar](max))
returns table
as
	return(select concat([Visit_Dates],[Ticket_Info]) as "Посещения" from [dbo].[Visit_History]
	where [Client_Info] like '%'+@Client_Info+'%')
go

select * from [dbo].[Client_Visit_History] ('Петров И.В.')
go

create or alter function [dbo].[Employee_Visit_History](@Employee_Info [varchar](max))
returns table
as
	return(select concat([Visit_Dates],' ', [Ticket_Info]) as "Посещения" from [dbo].[Visit_History]
	where [Employee_Info] like '%'+@Employee_Info+'%')
go

select * from [dbo].[Client_Visit_History] ('Ванечкин О.В.')
go

create or alter function [dbo].[Client_Diagnosis_History](@Client_Info [varchar] (max))
returns table
as
	return(select [Diagnosis_Info] as "Дисциплина" from [dbo].[Diagnosis_History]
	where [Client_Info] like '%'+@Client_Info+'%')
go

select * from [dbo].[Client_Diagnosis_History] ('Петров О.В. Карта:0000000003')
go

create or alter function [dbo].[Employee_Diagnosis_History](@Employee_Info [varchar](max))
returns table
as
	return(select [Diagnosis_Info] as "Диагноз" from [dbo].[Diagnosis_History]
	where [Employee_Info] like '%'+@Employee_Info+'%')
go

select * from [dbo].[Employee_Diagnosis_History] ('Леонтьев Е. .')
go

