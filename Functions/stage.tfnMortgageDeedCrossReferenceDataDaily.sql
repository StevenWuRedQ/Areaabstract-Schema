SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:			Raj Sethi

-- Date Created:	09/06/2016
	
-- Dates Modified:	10/26/2016

-- Description:		This function returns new records to be insert and records to be updates from stage.MortgageDeedCrossReference
--					

-- Input tables:	stage.MortgageDeedCrossReference and acris.MortgageDeedCrossReference

-- Tables modified: None

-- Arguments:		@operationFlag AS VARCHAR(1) 'A' returns records to be inserted and 'U' returns records to be updated
--					
-- Outputs:			Desired set of records

-- Where used:		acris.MortgageDeedCrossReferenceDataDailyImport Stored Procedure
-- =============================================
CREATE FUNCTION [stage].[tfnMortgageDeedCrossReferenceDataDaily](@operationFlag AS VARCHAR(1))
RETURNS TABLE
AS RETURN
(	
	SELECT	a.[UniqueKey]
		   ,a.[CRFN]
		   ,a.[DocumentIdReference]
		   ,a.[ReelYear]
		   ,a.[ReelBorough]
		   ,a.[ReelNumber]
		   ,a.[ReelPage]
		   ,GETDATE() AS DateLastUpdated
	FROM	[stage].[vwMortgageDeedCrossReferenceNoDups] a
	WHERE	@operationFlag = 'A'
)



--SELECT * FROM [stage].[tfnMortgageDeedCrossReferenceDataDaily]('U')
GO
