CREATE TABLE [Acris].[UCCRemark]
(
[UniqueKey] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Sequence] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Text] [varchar] (232) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateLastUpdated] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Acris].[UCCRemark] ADD CONSTRAINT [PK_UCCRemark] PRIMARY KEY CLUSTERED  ([UniqueKey], [Sequence]) ON [PRIMARY]
GO
