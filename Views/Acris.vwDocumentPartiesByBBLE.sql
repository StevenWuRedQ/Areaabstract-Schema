SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [Acris].[vwDocumentPartiesByBBLE]
AS
SELECT	dbb.BBLE
	   ,ap.UniqueKey
	   ,dbb.DocumentDate
	   ,dbb.DocumentType
	   ,dbb.DocumentTypeDescription
	   ,dbb.DocumentAmount
	   ,dbb.DateRecorded
	   ,dbb.DateModified
	   ,Acris.fnGetPartyTypeDescription(ap.PartyType, adoc.Party1Type, adoc.Party2Type, adoc.Party3Type) AS PartyType
	   ,ap.Name
	   ,ap.PartyType AS PartyTypeCode
FROM	Acris.DocumentControlCodes AS adoc
INNER JOIN Acris.vwDocumentsByBBLE AS dbb ON adoc.DocumentType = dbb.DocumentType
INNER JOIN Acris.MortgageDeedParty AS ap ON dbb.UniqueKey = ap.UniqueKey;


GO
