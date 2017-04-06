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

	TRUNCATE TABLE tmp.AllDeedsDocuments
	INSERT tmp.AllDeedsDocuments
	SELECT	*
			,ROW_NUMBER() OVER (PARTITION BY BBLE ORDER BY DB.DocumentDate DESC, DB.UniqueKey DESC) AS RowNumber
	FROM Acris.vwDeedsByBBLE DB

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
		   ,'https://a836-acris.nyc.gov/DS/DocumentSearch/DocumentImageView?doc_id='+DB1.UniqueKey AS URL
		   ,DB1.DateLastUpdated
		   ,GETDATE() AS DateProcessed
	FROM	tmp.AllDeedsDocuments DB1
	WHERE	DB1.RowNumber = 1;

	TRUNCATE TABLE tmp.AllDeedsDocuments
	
	TRUNCATE TABLE dbo.LotsPerLatestDeed;
	INSERT INTO dbo.LotsPerLatestDeed
	SELECT DeedUniqueKey, COUNT(DeedUniqueKey) NumberOfLots FROM [dbo].[LatestDeedDocument] GROUP BY DeedUniqueKey
END



/*

SELECT a.*, b.*, DATEDIFF(day,a.DocumentDate,b.DocumentDate)
FROM Acris.vwDeedsByBBLE a
INNER JOIN dbo.LatestDeedDocument b on a.bble=b.bble


DROP TABLE dbo.deedsWithinSixMonths

SELECT a.*, DATEDIFF(month,a.DocumentDate,b.DocumentDate) MonthDiff
INTO dbo.deedsWithinSixMonths
FROM Acris.vwDeedsByBBLE a
INNER JOIN [dbo].[LatestValidSaleDeedDocument] b on a.bble=b.bble
INNER JOIN [dbo].[LotsPerLatestDeed] c on c.DeedUniqueKey = b.DeedUniqueKey
where DATEDIFF(month,a.DocumentDate,b.DocumentDate)<=6 and a.DocumentDate<=b.DocumentDate
and b.DeedUniqueKey<>a.UniqueKey
and a.DocumentAmount>10000
and c.NumberOfLots=1

--64,781
SELECT b.*
FROM [dbo].[LatestValidSaleDeedDocument]  b 
INNER JOIN [dbo].[LotsPerLatestDeed] c on c.DeedUniqueKey = b.DeedUniqueKey
WHERE DATEDIFF(year,b.DocumentDate,GETDATE())<=2
and c.NumberOfLots=1

SELECT ROUND(100.00* (b.DocumentAmount-a.DocumentAmount)/a.DocumentAmount,0), DATEDIFF(day,a.DocumentDate,b.DocumentDate), a.*, b.* 
FROM [dbo].[LatestValidSaleDeedDocument] b 
INNER JOIN dbo.deedsWithinSixMonths a on a.bble=b.bble
ORDER BY DATEDIFF(day,a.DocumentDate,b.DocumentDate) DESC



SELECT ROUND(100.00* (b.DocumentAmount-a.DocumentAmount)/a.DocumentAmount,0), DATEDIFF(day,a.DocumentDate,b.DocumentDate), a.*, b.* 
FROM [dbo].[LatestValidSaleDeedDocument] b 
INNER JOIN dbo.deedsWithinSixMonths a on a.bble=b.bble
INNER JOIN [dbo].[LotsPerLatestDeed] c on c.DeedUniqueKey = b.DeedUniqueKey
where DATEDIFF(day,a.DocumentDate,b.DocumentDate)>=0
and b.DocumentAmount<>0
and a.documentAmount<>b.DocumentAmount
and DATEDIFF(year,b.DocumentDate,GETDATE())<=2
and c.NumberOfLots=1
ORDER BY DATEDIFF(day,a.DocumentDate,b.DocumentDate) DESC


SELECT BBLE, COUNT(*)
FROM dbo.deedsWithinSixMonths
GROUP BY BBLE
HAVING COUNT(*)>1

SELECT	*,ROW_NUMBER() OVER (PARTITION BY BBLE ORDER BY DB.DocumentDate DESC, DB.UniqueKey DESC) AS RowNumber
FROM	Acris.vwDeedsByBBLE DB
where BBLE ='1000162488'
			

SELECT DATEDIFF(month,'2005-10-21','2010-01-02')

--EXEC [dbo].[GetLatestDeedDocumentForAllProperties]
*/
GO
