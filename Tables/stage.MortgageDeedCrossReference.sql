CREATE TABLE [stage].[MortgageDeedCrossReference]
(
[RecordId] [bigint] NOT NULL IDENTITY(1, 1),
[Unique Key] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CRFN] [varchar] (13) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Doc_id_ref] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Reel_yr] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Reel_borough] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Reel_nbr] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Reel_pg] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
