CREATE TABLE [stage].[MortgageDeedMasterBase20160909]
(
[UniqueKey] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DateFileCreated] [date] NULL,
[CRFN] [varchar] (13) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordedBorough] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DocumentTypeCode] [varchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DocumentDate] [date] NULL,
[DocumentAmount] [numeric] (14, 2) NULL,
[DateRecorded] [date] NULL,
[DateModified] [date] NULL,
[ReelYear] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RealNumber] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ReelPage] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PercentageOfTransaction] [numeric] (15, 6) NULL,
[DateLastUpdated] [datetime] NULL
) ON [PRIMARY]
GO
