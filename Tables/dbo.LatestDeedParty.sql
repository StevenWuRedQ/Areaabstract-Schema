CREATE TABLE [dbo].[LatestDeedParty]
(
[BBLE] [varchar] (11) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DeedUniqueKey] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PartyName] [varchar] (70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address1] [varchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address2] [varchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[City] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[State] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Zip] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Country] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PartyType] [varchar] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsCompany] [int] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_LatestDeedParty_BBLE] ON [dbo].[LatestDeedParty] ([BBLE], [PartyType]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_LatestDeedParty_PartyIsCompany] ON [dbo].[LatestDeedParty] ([PartyType], [IsCompany], [BBLE]) ON [PRIMARY]
GO
