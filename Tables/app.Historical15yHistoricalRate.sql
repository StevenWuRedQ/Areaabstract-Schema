CREATE TABLE [app].[Historical15yHistoricalRate]
(
[Date] [date] NOT NULL,
[NationalInterestRate] [decimal] (4, 2) NULL,
[NWInterestRate] [decimal] (4, 2) NULL,
[SEInterestRate] [decimal] (4, 2) NULL,
[NCInterestRate] [decimal] (4, 2) NULL,
[SWInterestRate] [decimal] (4, 2) NULL,
[WInterestRate] [decimal] (4, 2) NULL
) ON [PRIMARY]
GO
ALTER TABLE [app].[Historical15yHistoricalRate] ADD CONSTRAINT [PK_Historical15yHistoricalRate] PRIMARY KEY CLUSTERED  ([Date]) ON [PRIMARY]
GO
