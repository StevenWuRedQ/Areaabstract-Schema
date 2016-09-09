SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:			Raj Sethi

-- Date Created:	09/06/2016
	
-- Dates Modified:	09/09/2016

-- Description:		This view removes duplicate records in an stagging table. 
--					The latest version of the record is considered for the import based on the Identity column RecordId.			

-- Input tables:	stage.[MortgageDeedCrossReference]

-- Tables modified: None

-- Arguments:		
--					
-- Outputs:			Returns deupped set of records

-- Where used:		acris.tfnMortgageDeedCrossReferenceDataDailyImport Table Valued Function
-- =============================================

CREATE VIEW [stage].[vwMortgageDeedCrossReferenceNoDups]
AS 
SELECT a.[RecordId]
      ,[UniqueKey]
      ,LTRIM(RTRIM([CRFN])) AS CRFN
      ,LTRIM(RTRIM([DocumentIdReference])) AS [DocumentIdReference]
      ,[ReelYear]
      ,[ReelBorough]
      ,[ReelNumber]
      ,[ReelPage]
FROM  [stage].[MortgageDeedCrossReference] a
INNER JOIN (SELECT MAX(RecordId) AS RecordId 
            FROM [stage].[MortgageDeedCrossReference]
			GROUP BY [UniqueKey]
 	       ) b ON a.RecordId=b.RecordId

GO
