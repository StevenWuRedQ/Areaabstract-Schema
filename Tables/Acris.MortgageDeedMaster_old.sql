CREATE TABLE [Acris].[MortgageDeedMaster_old]
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
[ReelNumber] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ReelPage] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PercentageOftransaction] [numeric] (15, 6) NULL,
[DateLastUpdated] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Acris].[MortgageDeedMaster_old] ADD CONSTRAINT [PK_MortgageDeedsMaster] PRIMARY KEY CLUSTERED  ([UniqueKey]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the Mortgage and Deeds Master Table', 'SCHEMA', N'Acris', 'TABLE', N'MortgageDeedMaster_old', NULL, NULL
GO
