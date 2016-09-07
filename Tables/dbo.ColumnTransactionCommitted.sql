CREATE TABLE [dbo].[ColumnTransactionCommitted]
(
[TableName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IdentifyingColumnName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IdentifyingValue] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ColumnName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[NewValue] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OldValue] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TransactionDateTime] [datetime] NULL,
[DateTimeProcessed] [datetime] NULL
) ON [PRIMARY]
GO
