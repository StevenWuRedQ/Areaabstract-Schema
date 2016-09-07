CREATE TABLE [dbo].[RowTransactionCommitted]
(
[TableName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IdentifyingColumnName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IdentifyingValue] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsInsert] [smallint] NOT NULL,
[IsDelete] [smallint] NOT NULL,
[IsUpdate] [smallint] NOT NULL,
[TransactionDateTime] [datetime] NULL,
[DateTimeProcessed] [datetime] NOT NULL
) ON [PRIMARY]
GO
