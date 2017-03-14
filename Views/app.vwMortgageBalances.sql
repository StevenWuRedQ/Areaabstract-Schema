SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE view [app].[vwMortgageBalances]
AS
SELECT *
	,Utilities.[util].[fnLoanBalanceDue](a.DocumentAmount,[app].[fnMortgageRate](DocumentDate,30),30,DEFAULT,MonthsSinceMortgage) MortgageBalance30y
	,Utilities.[util].[fnMonthLoanPayment](a.DocumentAmount,[app].[fnMortgageRate](DocumentDate,30),30,DEFAULT) MonthlyPayment30y
	,IIF(MonthsSinceMortgage<=180,Utilities.[util].[fnLoanBalanceDue](a.DocumentAmount,[app].[fnMortgageRate](DocumentDate,15),15,DEFAULT,MonthsSinceMortgage),NULL) MortgageBalance15y
	,Utilities.[util].[fnMonthLoanPayment](a.DocumentAmount,[app].[fnMortgageRate](DocumentDate,15),15,DEFAULT) MonthlyPayment15y
FROM app.vwMortgage a
WHERE MonthsSinceMortgage<360 AND MonthsSinceMortgage>200 

/*
CREATE view app.vwMortgage
AS 
SELECT *
	,DATEDIFF(MONTH,DocumentDate,GETDATE()) MonthsSinceMortgage
FROM [Acris].[MortgageDeedMaster] a
WHERE a.DocumentTypeCode='MTGE'
AND DocumentDate>='1980-01-01' AND a.DocumentAmount>0

INSERT INTO app.[Historical15yHistoricalRate]
SELECT  *
FROM [stage].[vwHistorical15yHistoricalRate]


TRUNCATE TABLE app.[Historical30yHistoricalRate]
INSERT INTO app.[Historical30yHistoricalRate]
SELECT  *
FROM [stage].[vwHistorical30yHistoricalRate]
*/
GO
