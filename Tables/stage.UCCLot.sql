CREATE TABLE [stage].[UCCLot]
(
[RecordId] [bigint] NOT NULL IDENTITY(1, 1),
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
[UnitNumber] [varchar] (7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
