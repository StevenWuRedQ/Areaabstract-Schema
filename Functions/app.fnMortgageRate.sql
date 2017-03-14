SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [app].[fnMortgageRate](@MortgageDate AS DATE, @TermInYears AS INTEGER = 30 )
RETURNS DECIMAL(4,2)
AS
BEGIN
	DECLARE @MortgageRate AS DECIMAL(4,2)

	IF (@TermInYears=30)
		SELECT @MortgageRate=a.[NationalInterestRate] FROM [app].[Historical30yHistoricalRate] a
		INNER JOIN (SELECT MAX(a.[Date]) AS [Date] 
		            FROM [app].[Historical30yHistoricalRate] a 
					WHERE a.[Date]<@MortgageDate 
						  AND a.[Date]>DATEADD(YEAR,-2,@MortgageDate) 
				    ) b ON a.[Date]=b.[Date]
	ELSE
		SELECT @MortgageRate=a.[NationalInterestRate] FROM [app].[Historical15yHistoricalRate] a
		INNER JOIN (SELECT MAX(a.[Date]) AS [Date] 
		            FROM [app].[Historical15yHistoricalRate] a 
					WHERE a.[Date]<@MortgageDate 
						  AND a.[Date]>DATEADD(YEAR,-2,@MortgageDate) 
				    ) b ON a.[Date]=b.[Date]
	
	RETURN @MortgageRate
END;


 --select [app].[fnMortgageRate]('2006-10-18',30)
GO
