CREATE TABLE [stage].[UCCPartyBase20160909]
(
[UniqueKey] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PartyType] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Name] [varchar] (70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CompressedName] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address1] [varchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address2] [varchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Country] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[City] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[State] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Zip] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateLastUpdated] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
