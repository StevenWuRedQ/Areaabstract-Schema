SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[GetLatestDeedDocumentForAllProperties]
AS
BEGIN
--SET NOCOUNT ON added to prevent extra result sets from
--interfering with SELECT statements.
	SET NOCOUNT ON;

	/* NOT OPTIMIZED HENCE REPLACED
	INSERT INTO AreaAbstract.dbo.LatestDeedDocument
	SELECT ld.BBLE
	,ld.UniqueKey AS DeedUniqueKey
	,ld.PropertyType
	,ld.DocumentType
	,ld.DocumentTypeDescription
	,ld.DocumentClassCodeDescription
	,ld.DocumentDate
	,ld.DocumentAmount
	,ld.PercentageOfTransaction
	,ld.DateRecorded
	,ld.DateModified
	,ld.BoroughOfRecord
	,ld.Remarks
	,ld.LastUpdatedDate
	,GETDATE() AS DateProcessed FROM [NYC_SRC].[nycdof].[AssUnionView] ta
	--NYCDOF.dof.TaxValuationAssessmentTentative ta
	CROSS APPLY AreaAbstract.acris.tfnGetLatestDocument(ta.[BBLE],'DEED') ld
	*/
	/*
	ISSUES WITH EXECUTION TIME ON SQL SERVER 2016

	INSERT INTO AreaAbstract.dbo.LatestDeedDocument
	SELECT	DB1.BBLE, DB1.UniqueKey AS DeedUniqueKey, DB1.PropertyType, DB1.DocumentType, DB1.DocumentTypeDescription, 
			DB1.DocumentClassCodeDescription, DB1.DocumentDate, DB1.DocumentAmount, DB1.PercentageOfTransaction, DB1.DateRecorded, DB1.DateModified, 
			DB1.BoroughOfRecord, acris.fnGetDocumentRemarks(DB1.UniqueKey) AS Remarks, DB1.LastUpdateDate, GETDATE() AS DateProcessed
	FROM acris.vwDocumentsByBBLE DB1
	INNER JOIN (SELECT	DB.BBLE, MAX(DB.UniqueKey) AS UniqueKey
				FROM acris.vwDocumentsByBBLE DB
				INNER JOIN (SELECT	BBLE, MAX(DocumentDate) AS LatestDocumentDate
							FROM acris.vwDocumentsByBBLE
							WHERE acris.vwDocumentsByBBLE.DocumentType='DEED' OR acris.vwDocumentsByBBLE.DocumentType='DEEDO'
							GROUP BY BBLE
							-- This Query is to find the latest date on Deed
							) SS ON SS.BBLE = DB.BBLE AND SS.LatestDocumentDate = DB.DocumentDate 
				WHERE DB.DocumentType='DEED' OR DB.DocumentType='DEEDO'
				GROUP BY DB.BBLE
				-- This Query is to get the last deed on that day since deed dcoument key's are not in ascending seq 
				) SS2 ON SS2.BBLE = DB1.BBLE
	WHERE DB1.UniqueKey=SS2.UniqueKey
	*/
	TRUNCATE TABLE dbo.LatestDeedDocument;
	INSERT	INTO dbo.LatestDeedDocument
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
		   ,DB1.DateLastUpdated
		   ,GETDATE() AS DateProcessed
	FROM	(SELECT	*
				   ,ROW_NUMBER() OVER (PARTITION BY BBLE ORDER BY DB.DocumentDate DESC, DB.UniqueKey DESC) AS RowNumber
			 FROM	Acris.vwDeedsByBBLE DB
			) DB1
	WHERE	DB1.RowNumber = 1;


	TRUNCATE TABLE dbo.LotsPerLatestDeed;
	INSERT INTO dbo.LotsPerLatestDeed
	SELECT DeedUniqueKey, COUNT(DeedUniqueKey) NumberOfLots FROM [dbo].[LatestDeedDocument] GROUP BY DeedUniqueKey
END
GO
