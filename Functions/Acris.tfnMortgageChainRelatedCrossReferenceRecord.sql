SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:			Raj Sethi

-- Date Created:	03/10/2017
	
-- Dates Modified:	

-- Description:		
--					

-- Input tables:	

-- Tables modified: None

-- Arguments:		
--					
-- Outputs:			

-- Where used:		
-- =============================================
CREATE FUNCTION [Acris].[tfnMortgageChainRelatedCrossReferenceRecord](@BBLE VARCHAR(11))
RETURNS TABLE
AS RETURN
(	
	SELECT a.BBLE, a.DocumentType, a.DocumentTypeDescription, a.DocumentDate, a.DateRecorded, b.* FROM  acris.vwDocumentsByBBLE a
	INNER JOIN [Acris].[MortgageDeedCrossReference] b ON a.uniquekey=b.uniquekey
	WHERE (a.DocumentType='SAT' OR a.DocumentType='M&CON' OR a.DocumentType='AGMT' OR a.DocumentType='ASST')
		AND a.BBLE=@BBLE
	UNION
	SELECT	a.BBLE
			,a.DocumentType
			,a.DocumentTypeDescription
			,a.DocumentDate
			,a.DateRecorded
			,a.UniqueKey
			,NULL AS CRFN
			,NULL AS DcoumentIdReference	
			,0000 AS ReelYear
			,0 AS ReelBorough
			,Acris.fnGetReelNumber(acris.fnGetDocumentRemarks(a.UniqueKey))
			,Acris.fnGetReelPage(acris.fnGetDocumentRemarks(a.UniqueKey))
			,NULL AS DateLastUpdated 
	FROM acris.vwDocumentsByBBLE a 
	LEFT OUTER JOIN [Acris].[MortgageDeedCrossReference] b ON a.uniquekey=b.uniquekey
	WHERE b.Uniquekey IS NULL
		  AND (a.DocumentType='SAT' OR a.DocumentType='M&CON' OR a.DocumentType='AGMT' OR a.DocumentType='ASST')
		  AND a.BBLE=@BBLE
)



GO
