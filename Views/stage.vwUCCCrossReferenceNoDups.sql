SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- =============================================
-- Author:			Raj Sethi

-- Date Created:	09/13/2016
	
-- Dates Modified:	

-- Description:		This view removes duplicate records in an stagging table. 
--					The latest version of the record is considered for the import based on the Identity column RecordId.			

-- Input tables:	stage.[UCCCrossReference]

-- Tables modified: None

-- Arguments:		
--					
-- Outputs:			Returns deupped set of records

-- Where used:		stage.tfnUCCCrossReferenceDataDailyImport Table Valued Function
-- =============================================

CREATE VIEW [stage].[vwUCCCrossReferenceNoDups]
AS 
SELECT a.[RecordId]
      ,[UniqueKey]
      ,LTRIM(RTRIM([CRFN])) AS CRFN
      ,LTRIM(RTRIM([a].[Doc_id_ref])) AS [DocumentIdReference]
      ,LTRIM(RTRIM(a.File_nbr)) AS FileNumber
FROM  [stage].[UCCCrossReference] a
INNER JOIN (SELECT MAX(RecordId) AS RecordId 
            FROM [stage].[UCCCrossReference]
			GROUP BY [UniqueKey]
 	       ) b ON a.RecordId=b.RecordId



GO
