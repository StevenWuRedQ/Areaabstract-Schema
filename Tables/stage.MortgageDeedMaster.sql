CREATE TABLE [stage].[MortgageDeedMaster]
(
[RecordId] [bigint] NOT NULL IDENTITY(1, 1),
[UniqueKey] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DateFileCreated] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CRFN] [varchar] (13) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordedBorough] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DocumentTypeCode] [varchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DocumentDate] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DocumentAmount] [varchar] (17) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateRecorded] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateModified] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ReelYear] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ReelNumber] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ReelPage] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PercentageOftransaction] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
