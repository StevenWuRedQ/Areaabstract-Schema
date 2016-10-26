SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE VIEW [Acris].[vwDocumentsByBBLE]
AS
SELECT	alot.BBL AS BBLE
	   ,ama.UniqueKey AS UniqueKey
	   ,ama.CRFN
	   ,alot.PropertyTypeCode AS PropertyType
	   ,ama.DocumentTypeCode AS DocumentType
	   ,adoc.DocumentTypeDescription
	   ,adoc.ClassCodeDescription AS DocumentClassCodeDescription
	   ,ama.DocumentDate
	   ,ama.DocumentAmount
	   ,ama.PercentageOfTransaction
	   ,ama.DateRecorded
	   ,ama.DateModified
	   ,ama.RecordedBorough
	   ,ama.DateLastUpdated
	   ,ama.ReelYear
	   ,ama.ReelNumber
	   ,ama.ReelPage
FROM	Acris.MortgageDeedMaster AS ama
INNER JOIN Acris.MortgageDeedLot AS alot ON ama.UniqueKey = alot.UniqueKey
INNER JOIN Acris.DocumentControlCodes AS adoc ON ama.DocumentTypeCode = adoc.DocumentType;



GO
