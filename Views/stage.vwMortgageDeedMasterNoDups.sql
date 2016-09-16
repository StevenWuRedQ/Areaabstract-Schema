SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:			Raj Sethi

-- Date Created:	09/06/2016
	
-- Dates Modified:	09/09/2016, 09/15/2016

-- Description:		This view removes duplicate records in an stagging table. 
--					The latest version of the record is considered for the import based on the Identity column RecordId.			

-- Input tables:	stage.[MortgageDeedMaster]

-- Tables modified: None

-- Arguments:		
--					
-- Outputs:			Returns deupped set of records

-- Where used:		acris.tfnMortgageDeedMasterDataDailyImport Table Valued Function
-- =============================================

CREATE VIEW [stage].[vwMortgageDeedMasterNoDups]
AS 
SELECT a.RecordId
	  ,[Unique Key] AS UniqueKey
      ,[Date File Created] AS DateFileCreated
      ,[CRFN]
      ,[Recorded_borough] AS RecordedBorough
      ,[Doc_type] AS DocumentTypeCode
      ,[Document Date] AS DocumentDate
      ,[Document_amt] AS DocumentAmount
      ,Recorded_datetime AS [DateRecorded]
      ,[Modified Date][DateModified]
      ,Reel_yr AS [ReelYear]
      ,Reel_nbr AS [ReelNumber]
      ,Reel_pg AS [ReelPage]
      ,Percent_trans AS [PercentageOftransaction]
FROM  [stage].[MortgageDeedMaster] a
INNER JOIN (SELECT MAX(RecordId) AS RecordId 
            FROM [stage].[MortgageDeedMaster]
			GROUP BY [Unique Key]
		    ) b ON a.RecordId=b.RecordId



GO
