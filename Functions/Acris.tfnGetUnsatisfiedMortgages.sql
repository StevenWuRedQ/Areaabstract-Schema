SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:			Raj Sethi

-- Date Created:	

-- Dates Modified:	11/21/2016

-- Description:		This function returns all mortgage documents that do not have a corresponding satisfaction document
--					

-- Input tables:	Acris.vwDocumentsByBBLE
--					Acris.vwSatisfactionAndAssignmentCrossReeferenceRecords

-- Tables modified: None

-- Arguments:		@BBLE BBLE of the Property
--					
-- Outputs:			See Below 

-- Where used:		PropertyWebApi
-- =============================================
CREATE FUNCTION [Acris].[tfnGetUnsatisfiedMortgages] (@BBLE VARCHAR(10))
RETURNS @UnsatisfiedMortgages TABLE 
(
    -- Columns returned by the function
	RowNo							INT PRIMARY KEY,
	BBLE							VARCHAR(11) NOT NULL,
	UniqueKey						VARCHAR(16) NOT NULL,
	CRFN							VARCHAR(13) NULL,
	PropertyType					VARCHAR(2) NULL,
	DocumentType					VARCHAR(8) NOT NULL,
	DocumentTypeDescription			VARCHAR(30) NULL,
	DocumentClassCodeDescription	VARCHAR(27),
	DocumentDate					DATE NULL,
	DocumentAmount					NUMERIC(14,2) NULL,
	PercentageOfTransaction			NUMERIC(15,6) NULL,
	DateRecorded					DATE NULL,
	DateModified					DATE NULL,
	RecordedBorough					VARCHAR(1) NULL,
	Remarks							VARCHAR(MAX) NULL,
	DateLastUpdated					DATETIME NULL,
	URL								VARCHAR(500),
	ReelYear						VARCHAR(4),
	ReelNumber						VARCHAR(5),
	ReelPage						VARCHAR(5)
)
BEGIN

	INSERT @UnsatisfiedMortgages      
	SELECT	ROW_NUMBER() OVER (ORDER BY IIF(a.DocumentDate IS NOT NULL, a.DocumentDate, a.DateRecorded) DESC, a.UniqueKey DESC) RowNo, a.BBLE, a.UniqueKey, a.CRFN, a.PropertyType, a.DocumentType, a.DocumentTypeDescription, 
				a.DocumentClassCodeDescription, a.DocumentDate, a.DocumentAmount, a.PercentageOfTransaction, a.DateRecorded, a.DateModified, 
				a.RecordedBorough, acris.fnGetDocumentRemarks(a.UniqueKey) AS Remarks, a.DateLastUpdated, 'https://a836-acris.nyc.gov/DS/DocumentSearch/DocumentImageView?doc_id='+a.UniqueKey AS URL,
				a.ReelYear, a.ReelNumber, a.ReelPage
	FROM acris.vwDocumentsByBBLE a
	LEFT OUTER JOIN [Acris].[tfnMortgageSatisfactionCrossReferenceRecord](@BBLE) b ON ((b.DocumentIdReference IS NOT NULL AND a.UniqueKey=b.DocumentIdReference)
													OR (b.CRFN IS NOT NULL AND a.CRFN=b.CRFN) 
													OR (b.Reelnumber<>'00000' AND a.ReelNumber=b.ReelNumber AND a.ReelPage=b.ReelPage ))
	WHERE (a.DocumentType='M&CON' OR a.DocumentType='AGMT' OR a.DocumentType='MTGE')
	AND a.bble=@BBLE
	AND b.UniqueKey IS NULL
	RETURN;
END

/*
 SELECT * FROM [acris].[tfnGetUnsatisfiedMortgages] ('4068880046') 
SELECT * FROM [acris].[tfnGetUnsatisfiedMortgages] ('2045100005') 
SELECT * FROM [acris].[tfnGetUnsatisfiedMortgages] ('3080590055') 


SELECT a.* FROM [acris].[tfnGetUnsatisfiedMortgages] ('4068880046') b
CROSS APPLY [Acris].[tfnGetDocumentPartiesByKey](b.UniqueKey,DEFAULT) a

SELECT b.* FROM	Acris.vwDocumentsByBBLE a
CROSS APPLY [Acris].[tfnGetDocumentPartiesByKey](a.UniqueKey,DEFAULT) b
WHERE	a.BBLE = '4068880046'
AND (a.DocumentType = 'MTGE' OR a.DocumentType = 'AGMT'	OR a.DocumentType = 'ASST')

SELECT * FROM [dbo].[LatestDeedDocument] where BBLe='4068880046'
SELECT * FROM [Acris].[tfnGetDocumentPartiesByKey]('FT_4740008998174',NULL)


SELECT	ROW_NUMBER() OVER (ORDER BY DateRecorded DESC, UniqueKey DESC) RowNo, a.BBLE, a.UniqueKey, a.CRFN, a.PropertyType, a.DocumentType, a.DocumentTypeDescription, 
				a.DocumentClassCodeDescription, a.DocumentDate, a.DocumentAmount, a.PercentageOfTransaction, a.DateRecorded, a.DateModified, 
				a.RecordedBorough, acris.fnGetDocumentRemarks(UniqueKey) AS Remarks, a.DateLastUpdated, 'https://a836-acris.nyc.gov/DS/DocumentSearch/DocumentImageView?doc_id='+a.UniqueKey AS URL,
				a.ReelYear, a.ReelNumber, a.ReelPage
	FROM	Acris.vwDocumentsByBBLE a
	WHERE	(a.DocumentType = 'M&CON' OR a.DocumentType = 'AGMT')
*/
GO
