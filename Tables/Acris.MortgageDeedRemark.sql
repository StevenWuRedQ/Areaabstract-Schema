CREATE TABLE [Acris].[MortgageDeedRemark]
(
[UniqueKey] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Sequence] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Text] [varchar] (232) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DateLastUpdated] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Acris].[MortgageDeedRemark] ADD CONSTRAINT [PK_MortgageDeedRemark] PRIMARY KEY CLUSTERED  ([UniqueKey], [Sequence]) ON [PRIMARY]
GO
