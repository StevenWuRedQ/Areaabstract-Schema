SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [app].[vwMortgage]
AS 
SELECT *
	,DATEDIFF(MONTH,DocumentDate,GETDATE()) MonthsSinceMortgage
FROM [Acris].[MortgageDeedMaster] a
WHERE (a.DocumentTypeCode = 'MTGE' OR a.DocumentTypeCode = 'M&CON' OR a.DocumentTypeCode = 'AGMT')
AND DocumentDate>='1980-01-01' AND a.DocumentAmount>0
UNION
SELECT *
	,DATEDIFF(MONTH,DocumentDate,GETDATE()) MonthsSinceMortgage
FROM [Acris].[MortgageDeedMaster] a
WHERE (a.DocumentTypeCode = 'MTGE' OR a.DocumentTypeCode = 'M&CON' OR a.DocumentTypeCode = 'AGMT')
AND DocumentDate IS NULL AND a.DateRecorded>='1980-01-01' AND a.DocumentAmount>0

GO
