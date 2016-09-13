CREATE TABLE [stage].[UCCMaster]
(
[RecordId] [bigint] NOT NULL IDENTITY(1, 1),
[UniqueKey] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Date File Created] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CRFN] [varchar] (13) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Recorded_borough] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Doc_type] [varchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Document_amt] [varchar] (17) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Recorded_datetime] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Ucc_collateral] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Fedtax_serial_nbr] [varchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Fedtax_assessment_date] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Rpttl_nbr] [varchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Modified date] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Reel_yr] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Reel_nbr] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Reel_pg] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[File_nbr] [varchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
