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

-- Input tables:	stage.[UCCRemark]

-- Tables modified: None

-- Arguments:		
--					
-- Outputs:			Returns dedupped set of records

-- Where used:		acris.tfnUCCRemarkDataDailyImport Table Valued Function
-- =============================================

CREATE VIEW [stage].[vwUCCRemarkNoDups]
AS 
	SELECT a.RecordId
		  ,UniqueKey
		  ,[Sequence]
		  ,LTRIM(RTRIM([Text])) AS [Text]
	FROM  [stage].[UCCRemark] a
	INNER JOIN (SELECT MAX(RecordId) AS RecordId 
				FROM [stage].[UCCRemark]
           		GROUP BY UniqueKey, [Sequence]
				) b ON a.RecordId=b.RecordId


GO
