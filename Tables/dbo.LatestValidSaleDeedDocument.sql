CREATE TABLE [dbo].[LatestValidSaleDeedDocument]
(
[BBLE] [varchar] (11) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DeedUniqueKey] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PropertyType] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DocumentType] [varchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DocumentTypeDescription] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DocumentClassCodeDescription] [varchar] (27) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DocumentDate] [date] NULL,
[DocumentAmount] [numeric] (14, 2) NULL,
[PercentageOfTransaction] [numeric] (15, 6) NULL,
[DateRecorded] [date] NULL,
[DateModified] [date] NULL,
[BoroughOfRecord] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Remarks] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[URL] [varchar] (1024) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastUpdatedDate] [datetime] NULL,
[DateProcessed] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[LatestValidSaleDeedDocument] ADD CONSTRAINT [PK_LatestValidSalesDeedDocument] PRIMARY KEY CLUSTERED  ([BBLE]) ON [PRIMARY]
GO
