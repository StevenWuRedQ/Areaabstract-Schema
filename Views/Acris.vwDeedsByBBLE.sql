SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [Acris].[vwDeedsByBBLE]
AS
SELECT	alot.BBL AS BBLE
	   ,ama.UniqueKey AS UniqueKey
	   ,ama.CRFN
	   ,alot.PropertyTypeCode AS PropertyType
	   ,ama.DocumentTypeCode AS DocumentType
	   ,adoc.DocumentTypeDescription AS DocumentTypeDescription
	   ,adoc.ClassCodeDescription AS DocumentClassCodeDescription
	   ,ama.DocumentDate 
	   ,ama.DocumentAmount
	   ,ama.PercentageOfTransaction
	   ,ama.DateRecorded
	   ,ama.DateModified
	   ,ama.RecordedBorough AS BoroughOfRecord
	   ,ama.DateLastUpdated
FROM	Acris.MortgageDeedMaster AS ama
INNER JOIN Acris.MortgageDeedLot AS alot ON ama.UniqueKey = alot.UniqueKey
INNER JOIN Acris.DocumentControlCodes AS adoc ON ama.DocumentTypeCode = adoc.DocumentType
WHERE ama.DocumentTypeCode='DEED' OR ama.DocumentTypeCode='DEEDO'


GO
