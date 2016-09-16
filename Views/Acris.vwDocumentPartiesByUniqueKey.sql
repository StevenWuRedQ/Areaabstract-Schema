SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [Acris].[vwDocumentPartiesByUniqueKey]
AS
SELECT	ap.UniqueKey
	   ,am.DocumentDate
	   ,adoc.DocumentType AS DocumentType
	   ,adoc.DocumentTypeDescription
	   ,am.DocumentAmount
	   ,am.DateRecorded
	   ,am.DateModified
	   ,Acris.fnGetPartyTypeDescription(ap.PartyType, adoc.Party1Type, adoc.Party2Type, adoc.Party3Type) AS PartyType
	   ,ap.Name
	   ,ap.PartyType AS PartyTypeCode
FROM	Acris.MortgageDeedMaster AS am
INNER JOIN Acris.MortgageDeedParty AS ap ON am.UniqueKey = ap.UniqueKey
INNER JOIN Acris.DocumentControlCodes adoc ON am.DocumentTypeCode = adoc.DocumentType;            

GO
