create or alter view [dbo].[Profile_Of_Medical_Services] ("��� �����", "��������� �������", "�������� �������")
as
	select [Second_Name_Empl]+' '+[First_Name_Empl]+' '+[Middle_Name_Empl], [Name_Medical_Degree], [Name_Treatment_Profiles] from [dbo].[Employee_Profile]
	inner join [dbo].[Treatment_Employee] on [Treatment_Employee_Id] = [Id_Treatment_Employee]
	inner join [dbo].[Medical_Degree] on [Medical_Degree_id] = [Id_Medical_Degree]
	inner join [dbo].[Treatment_Profiles] on [Treatment_Profiles_Id] = [Id_Treatment_Profiles]
	group by [Second_Name_Empl]+' '+[First_Name_Empl]+' '+[Middle_Name_Empl], [Name_Medical_Degree], [Name_Treatment_Profiles]
go

select * from [dbo].[Profile_Of_Medical_Services]

create or alter view [dbo].[Creating_Card] ("���������� �����", "���� �����������", "���", "��� ����� �������", "���� ������", "��� �������������", "���", "���� ��������", "����� ��������", "����� ��������", "��� ��������", "�����", "����", "�������", "�����", "�����")
as
	select [Personal_Outpatient_Card_Number], [Card_Registration_Date], [Second_Name_Cl]+' '+[First_Name_Cl]+' '+[Middle_Name_Cl], [Passport_Used_By], [Date_Of_Issue], [Division_Code], [Gender], [Date_Of_Burth], [Place_Of_Burth], [Passport_Serries], [Id_Passport], [Details_Of_Snils], [Details_Of_The_Mhif_Police], [Contact_Number], [Gmail_Cl], [Login_Cl] from [dbo].[Personal_Outpatient_Card]
	inner join [dbo].[Client] on [Client_Id] = [Id_Client]
	group by [Personal_Outpatient_Card_Number], [Card_Registration_Date], [Second_Name_Cl]+' '+[First_Name_Cl]+' '+[Middle_Name_Cl], [Passport_Used_By], [Date_Of_Issue], [Division_Code], [Gender], [Date_Of_Burth], [Place_Of_Burth], [Passport_Serries], [Id_Passport], [Details_Of_Snils], [Details_Of_The_Mhif_Police], [Contact_Number], [Gmail_Cl], [Login_Cl]
go

select * from [dbo].[Creating_Card]

create or alter view [dbo].[Creating_Ticket] ("�������� �������", "��� ����.", "����", "�����", "�����")
as
	select [Name_Treatment_Profiles], [Second_Name_Empl]+' '+[First_Name_Empl]+' '+[Middle_Name_Empl], [Date_Of_Reception], convert([varchar] (8),[Time_Of_Reception]), [Ticket_Number] from [dbo].[Ticket]
	inner join [dbo].[Treatment_Employee]  on [Treatment_Employee_Id] = [Id_Treatment_Employee]
	inner join [dbo].[Employee_Profile] on [Id_Employee_Profile] = [Id_Treatment_Employee]
	inner join [dbo].[Treatment_Profiles] on [Treatment_Profiles_Id] = [Id_Treatment_Profiles]
go

select * from [dbo].[Creating_Ticket]

create or alter view [dbo].[All_Service] ("������", "�������", "������������� �������", "���������")
as
	select [Code_Of_Service], string_agg([Unique_Diagnosis_Number]+[Name_Of_Diagnosis], '  '), [Exercise_Program], [Name_Taking_Medications] from [dbo].[Service_Recomended_Treatment]
	inner join [dbo].[Recommended_Taking_Medications] on [Recommended_Taking_Medications_Id] = [Id_Recommended_Taking_Medications]
	inner join [dbo].[Service_Diagnosis] on [Service_Diagnosis_Id] = [Id_Service_Diagnosis]
	inner join [dbo].[Service] on [Service_Id] = [Id_Service]
	inner join [dbo].[Diagnosis] on [Diagnosis_Id] = [Id_Diagnosis]
	inner join [dbo].[Recommended_Treatment] on [Recommended_Treatment_Id] = [Id_Recommended_Treatment]
	inner join [dbo].[Taking_Medications] on [Taking_Medications_Id] = [Id_Taking_Medications]
	group by [Code_Of_Service], [Exercise_Program], [Name_Taking_Medications]
go

create or alter view [dbo].[Creating_Sick_list] ("��� �������", "���������� ����")
as
	select [Second_Name_Cl]+' '+[First_Name_Cl]+' '+[Middle_Name_Cl], string_agg('�����: '+[Sick_List_Number]+' ���� ��������: '+convert([varchar] (10),[Sick_List_Opening_Date])+' ���� ����. ���������: '+convert([varchar] (10),[Date_Of_Next_Visit]), ' | ') from [dbo].[Sick_List]
	inner join [dbo].[Ticket] on [Ticket_Id] = [Id_Ticket]
	inner join [dbo].[Personal_Outpatient_Card] on [Personal_Outpatient_Card_Id] = [Id_Personal_Outpatient_Card]
	inner join [dbo].[Client] on [Client_Id] = [Id_Client]
	group by [Sick_List_Number], [Second_Name_Cl], [First_Name_Cl], [Middle_Name_Cl]
go

select * from [dbo].[Creating_Sick_list]
