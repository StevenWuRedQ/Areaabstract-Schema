SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [Acris].[vwDocumentsByBBLE]
AS
SELECT        alot.BBLE, ama.Unique_Key AS UniqueKey, ama.CRFN, alot.Property_type AS PropertyType, ama.Doc_Type AS DocumentType, adoc.[DOC  TYPE DESCRIPTION] AS DocumentTypeDescription, 
                         adoc.[CLASS CODE DESCRIPTION] AS DocumentClassCodeDescription, ama.Document_Date AS DocumentDate, ama.Document_Amt AS DocumentAmount, ama.Percent_trans AS PercentageOfTransaction, 
                         ama.Recorded_Date AS DateRecorded, ama.Modified_date AS DateModified, ama.Recorded_Borough AS BoroughOfRecord, ama.LastUpdated AS LastUpdateDate
FROM            acris.ACRIS_Master AS ama INNER JOIN
                         acris.ACRIS_Lots AS alot ON ama.Unique_Key = alot.Unique_Key INNER JOIN
                         acris.MD_DOCUMENT_CONTROL_CODES AS adoc ON ama.Doc_Type = adoc.[DOC  TYPE]


GO
