SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [Acris].[vwDocumentPartiesByUniqueKey]
AS
SELECT      ap.Unique_key AS UniqueKey, am.Document_Date AS DocumentDate, adoc.[DOC  TYPE] AS DocumentType, adoc.[DOC  TYPE DESCRIPTION] AS DocumentTypeDescription, am.Document_Amt AS DocumentAmount, am.Recorded_Date AS DateRecorded, 
            am.Modified_date AS DateModified, acris.fnGetPartyTypeDescription(ap.Party_type, adoc.[PARTY1 TYPE], adoc.[PARTY2 TYPE], adoc.[PARTY3 TYPE]) AS PartyType, ap.Name, ap.Occurance, ap.Party_type AS PartyTypeCode
FROM		acris.ACRIS_Master am	            
INNER JOIN	acris.ACRIS_Parties ap ON am.Unique_Key=ap.Unique_key		
INNER JOIN	acris.MD_Document_Control_Codes adoc ON am.Doc_Type=adoc.[DOC  TYPE]            
GO
