SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE FUNCTION [Acris].[tfnGetDocuments](@BBLE VARCHAR(11), @DocumentType VARCHAR(8)=NULL)
RETURNS @UniqueDocKeys TABLE 
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
	BoroughOfRecord					VARCHAR(1) NULL,
	Remarks							VARCHAR(MAX) NULL,
	LastUpdatedDate					DATETIME NULL,
	URL								VARCHAR(500)
)
BEGIN
	IF (@DocumentType IS NOT NULL)
		INSERT @UniqueDocKeys      
		SELECT	ROW_NUMBER() OVER (ORDER BY DateRecorded DESC, UniqueKey DESC) RowNo, BBLE, UniqueKey, CRFN, PropertyType, DocumentType, DocumentTypeDescription, 
				DocumentClassCodeDescription, DocumentDate, DocumentAmount, PercentageOfTransaction, DateRecorded, DateModified, 
				BoroughOfRecord, acris.fnGetDocumentRemarks(UniqueKey) AS Remarks, LastUpdateDate, 'https://a836-acris.nyc.gov/DS/DocumentSearch/DocumentImageView?doc_id='+UniqueKey AS URL
		FROM acris.vwDocumentsByBBLE
		WHERE acris.vwDocumentsByBBLE.BBLE LIKE @BBLE AND acris.vwDocumentsByBBLE.DocumentType=@DocumentType
	ELSE
		INSERT @UniqueDocKeys      
		SELECT	ROW_NUMBER() OVER (ORDER BY DateRecorded DESC, UniqueKey DESC) RowNo, BBLE, UniqueKey, CRFN, PropertyType, DocumentType, DocumentTypeDescription, 
				DocumentClassCodeDescription, DocumentDate, DocumentAmount, PercentageOfTransaction, DateRecorded, DateModified, 
				BoroughOfRecord, acris.fnGetDocumentRemarks(UniqueKey) AS Remarks, LastUpdateDate, 'https://a836-acris.nyc.gov/DS/DocumentSearch/DocumentImageView?doc_id='+UniqueKey AS URL
		FROM acris.vwDocumentsByBBLE
		WHERE acris.vwDocumentsByBBLE.BBLE LIKE @BBLE 
    RETURN;
END;
GO
