CREATE TABLE [Acris].[UCCCrossReference]
(
[UniqueKey] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CRFN] [varchar] (13) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DocumentIdReference] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FileNumber] [varchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateLastUpdated] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Acris].[UCCCrossReference] ADD CONSTRAINT [PK_UCCCrossReference] PRIMARY KEY CLUSTERED  ([UniqueKey]) ON [PRIMARY]
GO
