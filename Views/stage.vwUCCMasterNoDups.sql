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

-- Input tables:	stage.[UCCMaster]

-- Tables modified: None

-- Arguments:		
--					
-- Outputs:			Returns deupped set of records

-- Where used:		stage.tfnUCCMasterDataDailyImport Table Valued Function
-- =============================================

CREATE VIEW [stage].[vwUCCMasterNoDups]
AS 
SELECT a.RecordId
	  ,UniqueKey
      ,[Date File Created] 
      ,[CRFN]
      ,[Recorded_borough]
      ,[Doc_Type]
      ,[Document_amt]
      ,[Recorded_datetime]
	  ,[Ucc_collateral]
	  ,Fedtax_serial_nbr
	  ,Fedtax_assessment_date
	  ,Rpttl_nbr
      ,[Modified date]
      ,[Reel_yr]
      ,[Reel_nbr]
      ,[Reel_pg]
      ,[File_nbr]
FROM  [stage].[UCCMaster] a
INNER JOIN (SELECT MAX(RecordId) AS RecordId 
            FROM [stage].[UCCMaster]
			GROUP BY UniqueKey
		    ) b ON a.RecordId=b.RecordId


GO
