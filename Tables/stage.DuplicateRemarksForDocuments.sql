CREATE TABLE [stage].[DuplicateRemarksForDocuments]
(
[UniqueKey] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Sequence] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Text] [varchar] (232) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateLastUpdated] [datetime] NULL
) ON [PRIMARY]
GO
