CREATE TABLE [Acris].[MortgageDeedLot]
(
[BBL] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UniqueKey] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Borough] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Block] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Lot] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Easement] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PartialLot] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AirRights] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubterraneanRights] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PropertyTypeCode] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StreetNumber] [varchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StreetName] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UnitNumber] [varchar] (7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateLastUpdated] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Acris].[MortgageDeedLot] ADD CONSTRAINT [PK_MortgageDeedLot_1] PRIMARY KEY CLUSTERED  ([BBL], [UniqueKey], [Easement]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_MortgageDeedLot_UniqueKey] ON [Acris].[MortgageDeedLot] ([UniqueKey]) ON [PRIMARY]
GO
