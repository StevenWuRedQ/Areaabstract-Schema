SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:			Raj Sethi

-- Date Created:	09/06/2016
	
-- Dates Modified:	

-- Description:		This function returns new records to be insert and records to be updates from stage.MortgageDeedRemark
--					

-- Input tables:	stage.MortgageDeedRemark and acris.MortgageDeedRemark

-- Tables modified: None

-- Arguments:		@operationFlag AS VARCHAR(1) 'A' returns records to be inserted and 'U' returns records to be updated
--					
-- Outputs:			Desired set of records

-- Where used:		acris.MortgageDeedRemarkDataDailyImport Stored Procedure
-- =============================================
CREATE FUNCTION [stage].[tfnMortgageDeedRemarkDataDaily](@operationFlag AS VARCHAR(1))
RETURNS TABLE
AS RETURN
(	
	SELECT	a.[UniqueKey]
		   ,a.[Sequence]
		   ,a.[Text]
		   ,GETDATE() AS DateLastUpdated
	FROM	[stage].[vwMortgageDeedRemarkNoDups] a
	LEFT OUTER JOIN [Acris].[MortgageDeedRemark] b ON a.UniqueKey = b.UniqueKey
													  AND a.[Sequence] = b.[Sequence]
	WHERE	(b.UniqueKey IS NULL
			 AND @operationFlag = 'A'
			)
			OR (b.UniqueKey IS NOT NULL
				AND @operationFlag = 'U'
			   )
)



--SELECT * FROM [stage].[tfnMortgageDeedRemarkDataDaily]('A')
GO
