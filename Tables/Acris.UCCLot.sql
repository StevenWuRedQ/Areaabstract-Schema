CREATE TABLE [Acris].[UCCLot]
(
[BBL] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UniqueKey] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Borough] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Block] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Lot] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Easement] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PartialLot] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AirRights] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubterraneanRights] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PropertyType] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StreetNumber] [varchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StreetName] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UnitNumber] [varchar] (7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateLastUpdated] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Acris].[UCCLot] ADD CONSTRAINT [PK_UCCLot] PRIMARY KEY CLUSTERED  ([BBL], [UniqueKey], [Easement]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_UCCLot_UniqueKey] ON [Acris].[UCCLot] ([UniqueKey]) ON [PRIMARY]
GO
