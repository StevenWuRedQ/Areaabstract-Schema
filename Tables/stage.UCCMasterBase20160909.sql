CREATE TABLE [stage].[UCCMasterBase20160909]
(
[UniqueKey] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DateFileCreated] [date] NULL,
[CRFN] [varchar] (13) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordedBorough] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DocumentTypeCode] [varchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DocumentAmount] [numeric] (14, 2) NULL,
[DateRecorded] [date] NULL,
[UCCCollateral] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FederalTaxSerialNumber] [varchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FederalTaxAssessmentDate] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RPTTLNumber] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateModified] [date] NULL,
[ReelYear] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RealNumber] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ReelPage] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FileNumber] [varchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateLastUpdated] [datetime] NULL
) ON [PRIMARY]
GO
