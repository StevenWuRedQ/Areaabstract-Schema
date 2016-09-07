CREATE TABLE [dbo].[DailyImportLog]
(
[FullFileNameProcessed] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FileName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TableMnemonic] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DateTimeStarted] [datetime] NULL,
[DateTimeCompleted] [datetime] NULL,
[Successful] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DailyImportLog] ADD CONSTRAINT [PK_DailyImportLog] PRIMARY KEY CLUSTERED  ([FullFileNameProcessed]) ON [PRIMARY]
GO
