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

-- Input tables:	stage.[UCCLot]

-- Tables modified: None

-- Arguments:		
--					
-- Outputs:			Returns deupped set of records

-- Where used:		stage.tfnUCCLotDataDailyImport Table Valued Function
-- =============================================

/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [stage].[vwUCCLotNoDups]
AS 
SELECT a.[RecordId]
      ,[UniqueKey]
      ,[Borough]
      ,[Block]
      ,[Lot]
      ,[Easement]
      ,[PartialLot]
      ,[AirRights]
      ,[SubterraneanRights]
      ,[PropertyTypeCode]
      ,[StreetNumber]
      ,[StreetName]
      ,[UnitNumber]
FROM  [stage].[UCCLot] a
INNER JOIN (SELECT MAX(RecordId) AS RecordId 
            FROM [stage].[UCCLot]
			GROUP BY [UniqueKey]
				  ,[Borough]
				  ,[Block]
				  ,[Lot]
				  ,[Easement]
		    ) b ON a.RecordId=b.RecordId



GO
