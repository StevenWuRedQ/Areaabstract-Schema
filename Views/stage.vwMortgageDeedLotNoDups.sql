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

-- Input tables:	stage.[MortgageDeedLot]

-- Tables modified: None

-- Arguments:		
--					
-- Outputs:			Returns deupped set of records

-- Where used:		acris.tfnMortgageDeedLotDataDailyImport Table Valued Function
-- =============================================

/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [stage].[vwMortgageDeedLotNoDups]
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
FROM  [stage].[MortgageDeedLot] a
INNER JOIN (SELECT MAX(RecordId) AS RecordId 
            FROM [stage].[MortgageDeedLot]
			GROUP BY [UniqueKey]
				  ,[Borough]
				  ,[Block]
				  ,[Lot]
				  ,[Easement]
		    ) b ON a.RecordId=b.RecordId


GO
