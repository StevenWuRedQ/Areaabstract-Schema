CREATE TABLE [Acris].[MortgageDeedCrossReference]
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
CREATE NONCLUSTERED INDEX [IX_CRFN] ON [Acris].[MortgageDeedCrossReference] ([CRFN]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ReelKey] ON [Acris].[MortgageDeedCrossReference] ([ReelNumber], [ReelPage], [ReelYear]) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_UniqueKey] ON [Acris].[MortgageDeedCrossReference] ([UniqueKey]) ON [PRIMARY]
GO
