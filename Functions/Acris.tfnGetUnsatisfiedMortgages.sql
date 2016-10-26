SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:			Raj Sethi

-- Date Created:	05/27/2016

-- Dates Modified:	08/17/2016

-- Description:		This function returns all mortgage documents that do not have a corresponding satisfaction document
--					

-- Input tables:	stage.vwccisAppearanceDataDailyDeDupV2
--					stage.ccisAppearanceDataDaily

-- Tables modified: None

-- Arguments:		@BBLE BBLE of the Property
--					
-- Outputs:			Master 

-- Where used:		ccis.AppearanceDataDailyImport Stored Procedure
-- =============================================
CREATE FUNCTION [Acris].[tfnGetUnsatisfiedMortgages] (@BBLE VARCHAR(10))
RETURNS TABLE
	AS RETURN
(	SELECT	a.UniqueKey
	FROM	[Acris].[tfnGetDocuments](@BBLE, 'MTGE') a
	EXCEPT
	(
		SELECT	c.UniqueKey
		  FROM		[Acris].[tfnGetDocuments](@BBLE, 'SAT') a
		  INNER JOIN [Acris].[MortgageDeedCrossReference] b ON a.UniqueKey = b.UniqueKey
		  INNER JOIN [Acris].[MortgageDeedMaster] c ON c.CRFN = b.CRFN
		  UNION
		  SELECT	c.UniqueKey
		  FROM		[Acris].[tfnGetDocuments](@BBLE, 'SAT') a
		  INNER JOIN [Acris].[MortgageDeedCrossReference] b ON a.UniqueKey = b.UniqueKey
		  INNER JOIN [Acris].[MortgageDeedMaster] c ON c.ReelNumber = b.ReelNumber
													   AND c.ReelYear = b.ReelYear
													   AND c.ReelPage = b.ReelPage
		  WHERE		b.CRFN IS NULL
	)
);

--SELECT * FROM 
GO
