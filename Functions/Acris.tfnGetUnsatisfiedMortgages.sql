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
	FROM	Acris.vwDocumentsByBBLE a
	WHERE	a.BBLE = @BBLE
			AND (a.DocumentType = 'MTGE' OR a.DocumentType = 'AGMT'	OR a.DocumentType = 'ASST')
	EXCEPT
	(	SELECT	c.UniqueKey
		FROM	[Acris].[vwSatisfactionAndAssignmentCrossReeferenceRecords] a
		INNER JOIN [Acris].[MortgageDeedMaster] c ON c.CRFN = a.CRFN
		WHERE	a.CRFN IS NOT NULL
				AND a.BBLE = @BBLE
		UNION
		SELECT	c.UniqueKey
		FROM	[Acris].[vwSatisfactionAndAssignmentCrossReeferenceRecords] a
		INNER JOIN [Acris].[MortgageDeedMaster] c ON c.ReelNumber = a.ReelNumber AND a.ReelPage = c.ReelPage
		WHERE	a.CRFN IS NULL
				AND a.BBLE = @BBLE
		/*
		UNION
		--Sometimes Assignment mortgages have reel-page reference of the previous mortage **** I am not sure about this
		SELECT	c.UniqueKey
		FROM	[Acris].[vwSatisfactionAndAssignmentCrossReeferenceRecords] a
		INNER JOIN	Acris.vwDocumentsByBBLE c ON Acris.fnGetReelNumber(acris.fnGetDocumentRemarks(c.UniqueKey)) = a.ReelNumber AND a.ReelPage = Acris.fnGetReelPage(acris.fnGetDocumentRemarks(c.UniqueKey))
		WHERE	a.BBLE = @BBLE
				AND c.BBLE=@BBLE
				AND (c.DocumentType = 'ASST')
		*/
	)
);

/*
SELECT a.*, 'https://a836-acris.nyc.gov/DS/DocumentSearch/DocumentImageView?doc_id='+a.UniqueKey AS URL FROM Acris.vwDocumentsByBBLE a
INNER JOIN [acris].[tfnGetUnsatisfiedMortgages] ('4068880046') b ON a.UniqueKey = b.UniqueKey

SELECT a.* FROM [acris].[tfnGetUnsatisfiedMortgages] ('4068880046') b
CROSS APPLY [Acris].[tfnGetDocumentPartiesByKey](b.UniqueKey,DEFAULT) a

SELECT b.* FROM	Acris.vwDocumentsByBBLE a
CROSS APPLY [Acris].[tfnGetDocumentPartiesByKey](a.UniqueKey,DEFAULT) b
WHERE	a.BBLE = '4068880046'
AND (a.DocumentType = 'MTGE' OR a.DocumentType = 'AGMT'	OR a.DocumentType = 'ASST')

SELECT * FROM [dbo].[LatestDeedDocument] where BBLe='4068880046'
SELECT * FROM [Acris].[tfnGetDocumentPartiesByKey]('FT_4740008998174',NULL)
*/
GO
