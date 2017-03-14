SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








CREATE VIEW [Acris].[vwMortgageSatisfactionCrossReeferenceRecords]
AS
/*
   SELECT a.BBLE, b.* FROM  acris.vwDocumentsByBBLE a
   INNER JOIN [Acris].[MortgageDeedCrossReference] b ON a.uniquekey=b.uniquekey
   WHERE (a.DocumentType='SAT' OR a.DocumentType='ASST')
   UNION
   SELECT	a.BBLE
			,a.UniqueKey
			,NULL AS CRFN
			,NULL AS DcoumentIdReference	
			,0000 AS ReelYear
			,0 AS ReelBorough
			,Acris.fnGetReelNumber(acris.fnGetDocumentRemarks(a.UniqueKey))
			,Acris.fnGetReelPage(acris.fnGetDocumentRemarks(a.UniqueKey))
			,NULL AS DateLastUpdated 
   FROM acris.vwDocumentsByBBLE a 
   LEFT OUTER JOIN [Acris].[MortgageDeedCrossReference] b ON a.uniquekey=b.uniquekey
   WHERE b.Uniquekey IS NULL
   AND (a.DocumentType='SAT' OR a.DocumentType='ASST')
*/

   SELECT a.BBLE, b.* FROM  acris.vwDocumentsByBBLE a
   INNER JOIN [Acris].[MortgageDeedCrossReference] b ON a.uniquekey=b.uniquekey
   WHERE (a.DocumentType='SAT' OR a.DocumentType='M&CON' OR a.DocumentType='AGMT')
   UNION
   SELECT	a.BBLE
			,a.UniqueKey
			,NULL AS CRFN
			,NULL AS DcoumentIdReference	
			,0000 AS ReelYear
			,0 AS ReelBorough
			,c.ReelNumber
			,c.ReelPage
			,NULL AS DateLastUpdated 
   FROM acris.vwDocumentsByBBLE a 
   CROSS APPLY [app].[tfnGetReelNumberAndPage](acris.fnGetDocumentRemarks(a.UniqueKey)) c 
   LEFT OUTER JOIN [Acris].[MortgageDeedCrossReference] b ON a.uniquekey=b.uniquekey
   WHERE b.Uniquekey IS NULL
   AND (a.DocumentType='SAT' OR a.DocumentType='M&CON' OR a.DocumentType='AGMT')






GO
