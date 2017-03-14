CREATE TABLE [app].[Historical30yHistoricalRate]
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
ALTER TABLE [app].[Historical30yHistoricalRate] ADD CONSTRAINT [PK_Historical30yHistoricalRate] PRIMARY KEY CLUSTERED  ([Date]) ON [PRIMARY]
GO
