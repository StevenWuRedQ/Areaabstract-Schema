SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[GetLatestValidSaleDeedDocumentForAllProperties]
AS
BEGIN
--SET NOCOUNT ON added to prevent extra result sets from
--interfering with SELECT statements.
	SET NOCOUNT ON;

	TRUNCATE TABLE dbo.LatestValidSaleDeedDocument;
	
	INSERT	INTO dbo.LatestValidSaleDeedDocument
	SELECT	DB1.BBLE
		   ,DB1.UniqueKey AS DeedUniqueKey
		   ,DB1.PropertyType
		   ,DB1.DocumentType
		   ,DB1.DocumentTypeDescription
		   ,DB1.DocumentClassCodeDescription
		   ,DB1.DocumentDate
		   ,DB1.DocumentAmount
		   ,DB1.PercentageOfTransaction
		   ,DB1.DateRecorded
		   ,DB1.DateModified
		   ,DB1.BoroughOfRecord
		   ,Acris.fnGetDocumentRemarks(DB1.UniqueKey) AS Remarks
		   ,'https://a836-acris.nyc.gov/DS/DocumentSearch/DocumentImageView?doc_id='+DB1.UniqueKey AS URL
		   ,DB1.DateLastUpdated
		   ,GETDATE() AS DateProcessed
	FROM	(SELECT	*
				   ,ROW_NUMBER() OVER (PARTITION BY BBLE ORDER BY DB.DocumentDate DESC, DB.UniqueKey DESC) AS RowNumber
			 FROM	Acris.vwDeedsByBBLE DB
			 WHERE DB.DocumentAmount>=10000
			) DB1
	WHERE	DB1.RowNumber = 1;


	TRUNCATE TABLE dbo.LotsPerLatestDeed;
	INSERT INTO dbo.LotsPerLatestDeed
	SELECT DeedUniqueKey, COUNT(DeedUniqueKey) NumberOfLots FROM [dbo].[LatestValidSaleDeedDocument] GROUP BY DeedUniqueKey
END

--EXEC [dbo].[GetLatestDeedDocumentForAllProperties]
GO
