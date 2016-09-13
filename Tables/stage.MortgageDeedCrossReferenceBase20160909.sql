CREATE TABLE [stage].[MortgageDeedCrossReferenceBase20160909]
(
[UniqueKey] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CRFN] [varchar] (13) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DocumentIdReference] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ReelYear] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ReelBorough] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ReelNumber] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ReelPage] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateLastUpdated] [datetime] NULL
) ON [PRIMARY]
GO
