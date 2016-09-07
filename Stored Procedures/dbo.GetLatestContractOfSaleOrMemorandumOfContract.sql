SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

Create PROCEDURE [dbo].[GetLatestContractOfSaleOrMemorandumOfContract]
AS
BEGIN
--SET NOCOUNT ON added to prevent extra result sets from
--interfering with SELECT statements.
	SET NOCOUNT ON;

	TRUNCATE TABLE AreaAbstract.dbo.LatestContractOfSaleorMemorandumofContract;

	INSERT INTO AreaAbstract.dbo.LatestContractOfSaleorMemorandumofContract
	SELECT	DB1.BBLE, DB1.UniqueKey, DB1.PropertyType, DB1.DocumentType, DB1.DocumentTypeDescription, 
			DB1.DocumentClassCodeDescription, DB1.DocumentDate, DB1.DocumentAmount, DB1.PercentageOfTransaction, DB1.DateRecorded, DB1.DateModified, 
			DB1.BoroughOfRecord, acris.fnGetDocumentRemarks(DB1.UniqueKey) AS Remarks, DB1.LastUpdateDate, GETDATE() AS DateProcessed
	FROM acris.vwDocumentsByBBLE DB1
	INNER JOIN (SELECT	DB.BBLE, MAX(DB.UniqueKey) AS UniqueKey
				FROM acris.vwDocumentsByBBLE DB
				INNER JOIN (SELECT	BBLE, MAX(DocumentDate) AS LatestDocumentDate
							FROM acris.vwDocumentsByBBLE
							WHERE acris.vwDocumentsByBBLE.DocumentType='MCON' OR acris.vwDocumentsByBBLE.DocumentType='CNTR'
							GROUP BY BBLE
							-- This Query is to find the latest date on contracts
							) SS ON SS.BBLE = DB.BBLE
				WHERE DB.DocumentType='MCON' OR DB.DocumentType='CNTR'
				AND SS.LatestDocumentDate = DB.DocumentDate
				GROUP BY DB.BBLE
				-- This Query is to get the last contract on that day since document key's by themselves are not in ascending seq 
				) SS2 ON SS2.BBLE = DB1.BBLE
	WHERE DB1.UniqueKey=SS2.UniqueKey

END
GO
