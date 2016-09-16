CREATE TABLE [stage].[MortgageDeedLot]
(
[RecordId] [bigint] NOT NULL IDENTITY(1, 1),
[Unique Key] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Borough] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Block] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Lot] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Easement] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Partial_Lot] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Air_rights] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Subterranean_rights] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Property_type] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Street_number] [varchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Street_name] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Addr_unit] [varchar] (7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
