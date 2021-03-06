CREATE TABLE [Acris].[UCCParty]
(
[UniqueKey] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PartyType] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Name] [varchar] (70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CompressedName] [varchar] (70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address1] [varchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address2] [varchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Country] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[City] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[State] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Zip] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateLastUpdated] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Acris].[UCCParty] ADD CONSTRAINT [PK_UCCParty] PRIMARY KEY CLUSTERED  ([UniqueKey], [PartyType], [Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_UCCParty_CompressedName] ON [Acris].[UCCParty] ([UniqueKey], [PartyType], [CompressedName]) ON [PRIMARY]
GO
