SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [Acris].[vwDocumentPartiesByBBLE]
AS
SELECT        dbb.BBLE, ap.Unique_key AS UniqueKey, dbb.DocumentDate, dbb.DocumentType, dbb.DocumentTypeDescription, dbb.DocumentAmount, dbb.DateRecorded, dbb.DateModified, 
                         acris.fnGetPartyTypeDescription(ap.Party_type, adoc.[PARTY1 TYPE], adoc.[PARTY2 TYPE], adoc.[PARTY3 TYPE]) AS PartyType, ap.Name, ap.Occurance, ap.Party_type AS PartyTypeCode
FROM            acris.MD_DOCUMENT_CONTROL_CODES AS adoc INNER JOIN
                         acris.vwDocumentsByBBLE AS dbb ON adoc.[DOC  TYPE] = dbb.DocumentType INNER JOIN
                         acris.ACRIS_Parties AS ap ON dbb.UniqueKey = ap.Unique_key

GO
