SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:			Raj Sethi

-- Date Created:	09/08/2016
	
-- Dates Modified:	09/09/2016

-- Description:		This view removes duplicate records in an stagging table. 
--					The latest version of the record is considered for the import based on the Identity column RecordId.			

-- Input tables:	stage.[MortgageDeedRemark]

-- Tables modified: None

-- Arguments:		
--					
-- Outputs:			Returns deupped set of records

-- Where used:		acris.tfnMortgageDeedRemarkDataDailyImport Table Valued Function
-- =============================================

CREATE VIEW [stage].[vwMortgageDeedRemarkNoDups]
AS 
SELECT a.RecordId
	  ,UniqueKey
      ,[Sequence]
      ,LTRIM(RTRIM([Text])) AS [Text]
FROM  [stage].[MortgageDeedRemark] a
INNER JOIN (SELECT MAX(RecordId) AS RecordId 
            FROM [stage].[MortgageDeedRemark]
           	GROUP BY UniqueKey, [Sequence]
		    ) b ON a.RecordId=b.RecordId

GO
