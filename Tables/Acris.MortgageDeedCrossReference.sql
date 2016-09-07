CREATE TABLE [Acris].[MortgageDeedCrossReference]
(
[UniqueKey] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CRFN] [varchar] (13) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DocumentIdReference] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ReelYear] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ReelBorough] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ReelNumber] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ReelPage] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastUpdated] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Acris].[MortgageDeedCrossReference] ADD CONSTRAINT [PK_MasterDeedCrossReference] PRIMARY KEY CLUSTERED  ([UniqueKey]) ON [PRIMARY]
GO
