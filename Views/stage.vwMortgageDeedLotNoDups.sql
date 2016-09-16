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
      ,[Unique Key] AS UniqueKey
      ,[Borough]
      ,[Block]
      ,[Lot]
      ,[Easement]
      ,[Partial_lot] AS PartialLot
      ,[Air_rights] AS AirRights
      ,[Subterranean_rights] AS SubterraneanRights
      ,[Property_type] AS PropertyTypeCode
      ,[Street_number] AS StreetNumber
      ,[Street_name] AS StreetName
      ,[Addr_unit] AS UnitNumber
FROM  [stage].[MortgageDeedLot] a
INNER JOIN (SELECT MAX(RecordId) AS RecordId 
            FROM [stage].[MortgageDeedLot]
			GROUP BY [Unique Key]
				  ,[Borough]
				  ,[Block]
				  ,[Lot]
				  ,[Easement]
		    ) b ON a.RecordId=b.RecordId



GO
