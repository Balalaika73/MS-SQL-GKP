create table [dbo].[Visit_History]
(
[Id_Visit_History] [uniqueidentifier] not null,
[Visit_Dates] [varchar] (max),
[Ticket_Info] [varchar] (10) not null,
[Create_Record] [datetime] null default(getdate()),
[Change_Record] [datetime] null default(getdate()),
[Employee_Info] [varchar] (200) not null,
[Client_Info] [varchar] (max) not null
constraint [PK_Visit_History] primary key clustered
([Id_Visit_History] ASC) on [PRIMARY]
)
go

create table [dbo].[Diagnosis_History]
(
[Id_Diagnosis_History] [uniqueidentifier] not null,
[Diagnosis_Info] [varchar] (100) not null,
[Client_Info] [varchar] (max) not null,
[Employee_Info] [varchar] (max) not null,
[Dignosis_Dates] [varchar] (max) not null,
[Create_Record] [datetime] null default(getdate()),
[Change_Record] [datetime] null default(getdate()),
constraint [PK_Diagnosis_History] primary key clustered
([Id_Diagnosis_History] ASC) on [PRIMARY]
)
go

create or alter trigger [dbo].[Visit_History_Insert]
on [dbo].[Visit] after insert
as
	insert into [dbo].[Visit_History]
	([Id_Visit_History], [Client_Info], [Employee_Info], [Ticket_Info], [Visit_Dates])
	values(NEWID(),
	(select CONCAT([Second_Name_Cl],' ',substring([First_Name_Cl],1,1),'.',substring([Middle_Name_Cl],1,1),'. ', 'Карта:', [Personal_Outpatient_Card_Number]) from [dbo].[Personal_Outpatient_Card] 
	inner join [dbo].[Client] on [Client_Id] = [Id_Client]
	where [Id_Personal_Outpatient_Card] =
	(select [Personal_Outpatient_Card_Id] from [inserted])),
	(select CONCAT([Second_Name_Empl],' ',substring([First_Name_Empl],1,1),'.',substring([Middle_Name_Empl],1,1),'.') from [dbo].[Treatment_Employee] where [Id_Treatment_Employee] =
	(select [Treatment_Employee_Id] from [inserted])),
	(select CONCAT('Талон: ', [Ticket_Number], 'Дата:',[Date_Of_Reception], 'Время: ', [Time_Of_Reception]) from [dbo].[Ticket] 
	where [Id_Ticket] = (select [Ticket_id] from [inserted])), 'Новая запись')
 go

 create or alter trigger [dbo].[Visit_History_Update]
on [dbo].[Visit] after update
as
	insert into [dbo].[Visit_History]
	([Id_Visit_History], [Client_Info], [Employee_Info], [Ticket_Info], [Visit_Dates])
	values(NEWID(),
	(select CONCAT([Second_Name_Cl],' ',substring([First_Name_Cl],1,1),'.',substring([Middle_Name_Cl],1,1),'. ', 'Карта:', [Personal_Outpatient_Card_Number]) from [dbo].[Personal_Outpatient_Card] 
	inner join [dbo].[Client] on [Client_Id] = [Id_Client]
	where [Id_Personal_Outpatient_Card] =
	(select [Personal_Outpatient_Card_Id] from [inserted])),
	(select CONCAT([Second_Name_Empl],' ',substring([First_Name_Empl],1,1),'.',substring([Middle_Name_Empl],1,1),'.') from [dbo].[Treatment_Employee] where [Id_Treatment_Employee] =
	(select [Treatment_Employee_Id] from [inserted])),
	(select CONCAT('Талон: ', [Ticket_Number], 'Дата:',[Date_Of_Reception], 'Время: ', [Time_Of_Reception]) from [dbo].[Ticket] 
	where [Id_Ticket] = (select [Ticket_id] from [inserted])), 'Запись изменена')
 go

   create or alter trigger [dbo].[Visit_History_Delete]
on [dbo].[Visit] after delete
as
	insert into [dbo].[Visit_History]
	([Id_Visit_History], [Client_Info], [Employee_Info], [Ticket_Info], [Visit_Dates])
	values(NEWID(),
	(select CONCAT([Second_Name_Cl],' ',substring([First_Name_Cl],1,1),'.',substring([Middle_Name_Cl],1,1),'. ', 'Карта:', [Personal_Outpatient_Card_Number]) from [dbo].[Personal_Outpatient_Card] 
	inner join [dbo].[Client] on [Client_Id] = [Id_Client]
	where [Id_Personal_Outpatient_Card] =
	(select [Personal_Outpatient_Card_Id] from [inserted])),
	(select CONCAT([Second_Name_Empl],' ',substring([First_Name_Empl],1,1),'.',substring([Middle_Name_Empl],1,1),'.') from [dbo].[Treatment_Employee] where [Id_Treatment_Employee] =
	(select [Treatment_Employee_Id] from [inserted])),
	(select CONCAT('Талон: ', [Ticket_Number], 'Дата:',[Date_Of_Reception], 'Время: ', [Time_Of_Reception]) from [dbo].[Ticket] 
	where [Id_Ticket] = (select [Ticket_id] from [inserted])), 'Запись удалена')
 go

 create or alter trigger [dbo].[Diagnosis_History_Insert]
on [dbo].[Diagnosis_View] after insert
as
	insert into [dbo].[Diagnosis_History]
	([Id_Diagnosis_History], [Diagnosis_Info], [Client_Info], [Employee_Info], [Dignosis_Dates])
	values(NEWID(),
	(select concat([Unique_Diagnosis_Number], ' ', [Name_Of_Diagnosis]) from [dbo].[Diagnosis] 
	where [Id_Diagnosis] = (select [Diagnosis_Id] from [inserted])),

	(select CONCAT([Second_Name_Cl],' ',substring([First_Name_Cl],1,1),'.',substring([Middle_Name_Cl],1,1),'. ', 'Карта:', [Personal_Outpatient_Card_Number]) from [dbo].[Personal_Outpatient_Card] 
	inner join [dbo].[Client] on [Client_Id] = [Id_Client]
	where [Id_Personal_Outpatient_Card] =
	(select [Personal_Outpatient_Card_Id] from [inserted])), 
	(select CONCAT([Second_Name_Empl],' ',substring([First_Name_Empl],1,1),'.',substring([Middle_Name_Empl],1,1),'.') from [dbo].[Treatment_Employee] where [Id_Treatment_Employee] =
	(select [Treatment_Employee_Id] from [inserted])),'Новая запись')
 go

 create or alter trigger [dbo].[Diagnosis_History_Update]
on [dbo].[Diagnosis_View] after update
as
	insert into [dbo].[Diagnosis_History]
	([Id_Diagnosis_History], [Diagnosis_Info], [Client_Info], [Employee_Info], [Dignosis_Dates])
	values(NEWID(),
	(select concat([Unique_Diagnosis_Number], ' ', [Name_Of_Diagnosis]) from [dbo].[Diagnosis] 
	where [Id_Diagnosis] = (select [Diagnosis_Id] from [inserted])),

	(select CONCAT([Second_Name_Cl],' ',substring([First_Name_Cl],1,1),'.',substring([Middle_Name_Cl],1,1),'. ', 'Карта:', [Personal_Outpatient_Card_Number]) from [dbo].[Personal_Outpatient_Card] 
	inner join [dbo].[Client] on [Client_Id] = [Id_Client]
	where [Id_Personal_Outpatient_Card] =
	(select [Personal_Outpatient_Card_Id] from [inserted])), 
	(select CONCAT([Second_Name_Empl],' ',substring([First_Name_Empl],1,1),'.',substring([Middle_Name_Empl],1,1),'.') from [dbo].[Treatment_Employee] where [Id_Treatment_Employee] =
	(select [Treatment_Employee_Id] from [inserted])),'Запись изменена')
 go

   create or alter trigger [dbo].[Diagnosis_History_Delete]
on [dbo].[Diagnosis_View] after delete
as
	insert into [dbo].[Diagnosis_History]
	([Id_Diagnosis_History], [Diagnosis_Info], [Client_Info], [Employee_Info], [Dignosis_Dates])
	values(NEWID(),
	(select concat([Unique_Diagnosis_Number], ' ', [Name_Of_Diagnosis]) from [dbo].[Diagnosis] 
	where [Id_Diagnosis] = (select [Diagnosis_Id] from [inserted])),

	(select CONCAT([Second_Name_Cl],' ',substring([First_Name_Cl],1,1),'.',substring([Middle_Name_Cl],1,1),'. ', 'Карта:', [Personal_Outpatient_Card_Number]) from [dbo].[Personal_Outpatient_Card] 
	inner join [dbo].[Client] on [Client_Id] = [Id_Client]
	where [Id_Personal_Outpatient_Card] =
	(select [Personal_Outpatient_Card_Id] from [inserted])), 
	(select CONCAT([Second_Name_Empl],' ',substring([First_Name_Empl],1,1),'.',substring([Middle_Name_Empl],1,1),'.') from [dbo].[Treatment_Employee] where [Id_Treatment_Employee] =
	(select [Treatment_Employee_Id] from [inserted])),'Запись удалена')
 go

insert into [dbo].[Visit] ([Ticket_Id],[Personal_Outpatient_Card_Id],[Treatment_Employee_Id])
values(1,1,1)
go
insert into [dbo].[Visit] ([Ticket_Id],[Personal_Outpatient_Card_Id],[Treatment_Employee_Id])
values(2,2,2)
go
insert into [dbo].[Visit] ([Ticket_Id],[Personal_Outpatient_Card_Id],[Treatment_Employee_Id])
values(3,3,3)
go
insert into [dbo].[Visit] ([Ticket_Id],[Personal_Outpatient_Card_Id],[Treatment_Employee_Id])
values(4,4,4)
go
insert into [dbo].[Visit] ([Ticket_Id],[Personal_Outpatient_Card_Id],[Treatment_Employee_Id])
values(5,5,5)
go

insert into [dbo].[Diagnosis_View] ([Diagnosis_Id],[Personal_Outpatient_Card_Id],[Treatment_Employee_Id])
values(1,1,1)
go
insert into [dbo].[Diagnosis_View] ([Diagnosis_Id],[Personal_Outpatient_Card_Id],[Treatment_Employee_Id])
values(2,2,2)
go
insert into [dbo].[Diagnosis_View] ([Diagnosis_Id],[Personal_Outpatient_Card_Id],[Treatment_Employee_Id])
values(3,3,3)
go
insert into [dbo].[Diagnosis_View] ([Diagnosis_Id],[Personal_Outpatient_Card_Id],[Treatment_Employee_Id])
values(4,4,4)
go
insert into [dbo].[Diagnosis_View] ([Diagnosis_Id],[Personal_Outpatient_Card_Id],[Treatment_Employee_Id])
values(5,5,5)
go
