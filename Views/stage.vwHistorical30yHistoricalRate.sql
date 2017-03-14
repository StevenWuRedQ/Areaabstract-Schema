SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [stage].[vwHistorical30yHistoricalRate]
AS
SELECT IIF(ISDATE([Week]+'/'+[Year])=1,CONVERT(DATE,[Week]+'/'+[Year],101),NULL) [Date]
      ,IIF(ISNUMERIC([Interest Rate])=1,CONVERT(DECIMAL(4,2),[Interest Rate]),NULL) NationalInterestRate
      ,IIF(ISNUMERIC([NE])=1,CONVERT(DECIMAL(4,2),[NE]),NULL) NWInterestRate
      ,IIF(ISNUMERIC([SE])=1,CONVERT(DECIMAL(4,2),[SE]),NULL) SEInterestRate
      ,IIF(ISNUMERIC([NC])=1,CONVERT(DECIMAL(4,2),[NC]),NULL) NCInterestRate
      ,IIF(ISNUMERIC([SW ])=1,CONVERT(DECIMAL(4,2),[SW ]),NULL) SWInterestRate
      ,IIF(ISNUMERIC([W])=1,CONVERT(DECIMAL(4,2),[W]),NULL) WInterestRate
FROM [AreaAbstractNew].[stage].[Historical30yHistoricalRate]
GO
