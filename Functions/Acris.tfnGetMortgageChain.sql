SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:			Raj Sethi

-- Date Created:	03/10/2017
	
-- Dates Modified:	

-- Description:		
--					

-- Input tables:	

-- Tables modified: None

-- Arguments:		
--					
-- Outputs:			

-- Where used:		
-- =============================================
CREATE FUNCTION [Acris].[tfnGetMortgageChain](@BBLE VARCHAR(11))
RETURNS TABLE
AS RETURN
(	
   SELECT a.*
		  ,'https://a836-acris.nyc.gov/DS/DocumentSearch/DocumentImageView?doc_id='+a.UniqueKey AS URL
		  ,b.DocumentType RelatedDocumentType 
		  ,b.DocumentTypeDescription RelatedDocumentTypeDescription 
		  ,b.UniqueKey RelatedDocumentUniqueKey 
		  ,b.DocumentDate RelatedDocumentDate
		  ,b.DateRecorded RelatedDocumentRecordDate
		  ,'https://a836-acris.nyc.gov/DS/DocumentSearch/DocumentImageView?doc_id='+b.UniqueKey AS RelatedDocumentURL
   FROM acris.vwDocumentsByBBLE a
   LEFT OUTER JOIN [Acris].[tfnMortgageChainRelatedCrossReferenceRecord](@BBLE) b ON ((b.DocumentIdReference IS NOT NULL AND a.UniqueKey=b.DocumentIdReference)
																			OR (b.CRFN IS NOT NULL AND a.CRFN=b.CRFN) 
																			OR (b.Reelnumber<>'00000' AND a.ReelNumber=b.ReelNumber AND a.ReelPage=b.ReelPage ))
   WHERE (a.DocumentType='M&CON' OR a.DocumentType='AGMT' OR a.DocumentType='MTGE')
		 AND a.bble=@BBLE
)



GO
