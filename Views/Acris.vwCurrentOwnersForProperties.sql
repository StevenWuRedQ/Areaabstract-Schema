SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE VIEW [Acris].[vwCurrentOwnersForProperties]
AS
SELECT	am.BBLE
	   ,am.DocumentDate
	   ,adoc.DocumentType AS DocumentType
	   ,adoc.DocumentTypeDescription
	   ,am.DocumentAmount
	   ,am.DateRecorded
	   ,am.DateModified
--	   ,Acris.fnGetPartyTypeDescription(ap.PartyType, adoc.Party1Type, adoc.Party2Type, adoc.Party3Type) AS PartyType
	   ,ap.Name
	   ,ap.PartyType AS PartyTypeCode
	   ,ap.Address1
	   ,ap.Address2
	   ,ap.City
	   ,ap.State
	   ,ap.Zip
	   ,ap.Country
FROM	[dbo].[LatestDeedDocument] AS am
INNER JOIN Acris.MortgageDeedParty AS ap ON am.DeedUniqueKey = ap.UniqueKey AND ap.PartyType=2
INNER JOIN Acris.DocumentControlCodes adoc ON am.DocumentType = adoc.DocumentType           



GO
