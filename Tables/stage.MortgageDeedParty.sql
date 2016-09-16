CREATE TABLE [stage].[MortgageDeedParty]
(
[RecordId] [bigint] NOT NULL IDENTITY(1, 1),
[Unique Key] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Party_type] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Name] [varchar] (70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Addr1] [varchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Addr2] [varchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Country] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[City] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[State] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Zip] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
