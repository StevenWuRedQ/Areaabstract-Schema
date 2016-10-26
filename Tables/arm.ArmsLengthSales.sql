CREATE TABLE [arm].[ArmsLengthSales]
(
[BBLE] [varchar] (11) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DeedUniqueKey] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DocumentDate] [date] NULL,
[DocumentAmount] [numeric] (14, 2) NULL,
[ArmsLength] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [arm].[ArmsLengthSales] ADD CONSTRAINT [PK_ArmsLengthSales_1] PRIMARY KEY CLUSTERED  ([BBLE], [DeedUniqueKey]) ON [PRIMARY]
GO
