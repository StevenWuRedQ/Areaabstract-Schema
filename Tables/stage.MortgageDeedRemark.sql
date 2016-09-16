CREATE TABLE [stage].[MortgageDeedRemark]
(
[RecordId] [bigint] NOT NULL IDENTITY(1, 1),
[Unique Key] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Seq] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Text] [varchar] (232) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
