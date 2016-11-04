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
	RecordedBorough					VARCHAR(1) NULL,
	Remarks							VARCHAR(MAX) NULL,
	DateLastUpdated					DATETIME NULL,
	URL								VARCHAR(500),
	ReelYear						VARCHAR(4),
	ReelNumber						VARCHAR(5),
	ReelPage						VARCHAR(5)
)
BEGIN
	IF (@DocumentType IS NOT NULL)
		INSERT @UniqueDocKeys      
		SELECT	ROW_NUMBER() OVER (ORDER BY DateRecorded DESC, UniqueKey DESC) RowNo, BBLE, UniqueKey, CRFN, PropertyType, DocumentType, DocumentTypeDescription, 
				DocumentClassCodeDescription, DocumentDate, DocumentAmount, PercentageOfTransaction, DateRecorded, DateModified, 
				RecordedBorough, acris.fnGetDocumentRemarks(UniqueKey) AS Remarks, DateLastUpdated, 'https://a836-acris.nyc.gov/DS/DocumentSearch/DocumentImageView?doc_id='+UniqueKey AS URL,
				ReelYear, ReelNumber, ReelPage
		FROM acris.vwDocumentsByBBLE 
		WHERE acris.vwDocumentsByBBLE.BBLE LIKE @BBLE AND acris.vwDocumentsByBBLE.DocumentType=@DocumentType
	ELSE
		INSERT @UniqueDocKeys      
		SELECT	ROW_NUMBER() OVER (ORDER BY DateRecorded DESC, UniqueKey DESC) RowNo, BBLE, UniqueKey, CRFN, PropertyType, DocumentType, DocumentTypeDescription, 
				DocumentClassCodeDescription, DocumentDate, DocumentAmount, PercentageOfTransaction, DateRecorded, DateModified, 
				RecordedBorough, acris.fnGetDocumentRemarks(UniqueKey) AS Remarks, DateLastUpdated, 'https://a836-acris.nyc.gov/DS/DocumentSearch/DocumentImageView?doc_id='+UniqueKey AS URL,
				ReelYear, ReelNumber, ReelPage
		FROM acris.vwDocumentsByBBLE
		WHERE acris.vwDocumentsByBBLE.BBLE LIKE @BBLE 
    RETURN;
END;

/* 
	SELECT * FROM [Acris].[tfnGetDocuments]('4068880046',NULL)
   SELECT * FROM [Acris].[tfnGetDocuments]('4068880046','MTGE')
   SELECT * FROM [Acris].[tfnGetDocuments]('4068880046','SAT')
    SELECT * FROM [Acris].[tfnGetDocuments]('4068880046','ASST')

   SELECT b.* FROM [Acris].[tfnGetDocuments]('4068880046','SAT') a 
   INNER JOIN [Acris].[MortgageDeedCrossReference] b on a.uniquekey=b.uniquekey

   SELECT b.* FROM [Acris].[tfnGetDocuments]('4068880046','ASST') a 
   INNER JOIN [Acris].[MortgageDeedCrossReference] b on a.uniquekey=b.uniquekey
   
   SELECT a.UniqueKey FROM [Acris].[tfnGetDocuments]('4068880046','MTGE') a
   EXCEPT
   (SELECT c.UniqueKey FROM [Acris].[tfnGetDocuments]('4068880046','SAT') a 
   INNER JOIN [Acris].[MortgageDeedCrossReference] b on a.uniquekey=b.uniquekey
   INNER JOIN [Acris].[MortgageDeedMaster] c on c.CRFN=b.CRFN
   where b.CRFN IS NOT NULL 
   UNION ALL
   SELECT c.UniqueKey FROM [Acris].[tfnGetDocuments]('4068880046','SAT') a 
   INNER JOIN [Acris].[MortgageDeedCrossReference] b on a.uniquekey=b.uniquekey
   INNER JOIN [Acris].[MortgageDeedMaster] c on c.ReelNumber=b.ReelNumber and c.ReelYear=b.ReelYear and c.ReelPage=b.ReelPage 
   where b.CRFN IS NULL
   UNION ALL
   SELECT  c.UniqueKey FROM [Acris].[tfnGetDocuments]('4068880046','ASST') a 
   INNER JOIN [Acris].[MortgageDeedCrossReference] b on a.uniquekey=b.uniquekey
   INNER JOIN [Acris].[MortgageDeedMaster] c on c.CRFN=b.CRFN
   where b.CRFN IS NOT NULL
   UNION ALL
   SELECT c.UniqueKey FROM [Acris].[tfnGetDocuments]('4068880046','ASST') a 
   INNER JOIN [Acris].[MortgageDeedCrossReference] b on a.uniquekey=b.uniquekey
   INNER JOIN [Acris].[MortgageDeedMaster] c on c.ReelNumber=b.ReelNumber and c.ReelYear=b.ReelYear and c.ReelPage=b.ReelPage 
   where b.CRFN IS NULL 
   )


   SELECT c.* FROM [Acris].[MortgageDeedMaster] c 
   INNER JOIN 
   (SELECT b.* FROM [Acris].[tfnGetDocuments]('4068880046','SAT') a 
   INNER JOIN [Acris].[vwMortgageDeedCrossReference] b on a.uniquekey=b.uniquekey
   UNION ALL
   SELECT b.*  FROM [Acris].[tfnGetDocuments]('4068880046','ASST') a 
   INNER JOIN [Acris].[vwMortgageDeedCrossReference] b on a.uniquekey=b.uniquekey
   ) b on c.ReelNumber=b.ReelNumber and c.ReelYear=b.ReelYear and c.ReelPage=b.ReelPage 


   (SELECT a.* FROM [Acris].[tfnGetDocuments]('4068880046','SAT') a 
   LEFT OUTER JOIN [Acris].[vwMortgageDeedCrossReference] b on a.uniquekey=b.uniquekey
   WHERE b.UniqueKey IS NULL
   UNION ALL
   SELECT a.*  FROM [Acris].[tfnGetDocuments]('4068880046','ASST') a 
   LEFT OUTER JOIN [Acris].[vwMortgageDeedCrossReference] b on a.uniquekey=b.uniquekey
   WHERE b.UniqueKey IS NULL
   ) 
*/
GO
