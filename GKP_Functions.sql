create or alter function [dbo].[Client_Visit_History](@Client_Info [varchar](max))
returns table
as
	return(select concat([Visit_Dates],[Ticket_Info]) as "���������" from [dbo].[Visit_History]
	where [Client_Info] like '%'+@Client_Info+'%')
go

select * from [dbo].[Client_Visit_History] ('������ �.�.')
go

create or alter function [dbo].[Employee_Visit_History](@Employee_Info [varchar](max))
returns table
as
	return(select concat([Visit_Dates],' ', [Ticket_Info]) as "���������" from [dbo].[Visit_History]
	where [Employee_Info] like '%'+@Employee_Info+'%')
go

select * from [dbo].[Client_Visit_History] ('�������� �.�.')
go

create or alter function [dbo].[Client_Diagnosis_History](@Client_Info [varchar] (max))
returns table
as
	return(select [Diagnosis_Info] as "����������" from [dbo].[Diagnosis_History]
	where [Client_Info] like '%'+@Client_Info+'%')
go

select * from [dbo].[Client_Diagnosis_History] ('������ �.�. �����:0000000003')
go

create or alter function [dbo].[Employee_Diagnosis_History](@Employee_Info [varchar](max))
returns table
as
	return(select [Diagnosis_Info] as "�������" from [dbo].[Diagnosis_History]
	where [Employee_Info] like '%'+@Employee_Info+'%')
go

select * from [dbo].[Employee_Diagnosis_History] ('�������� �. .')
go

