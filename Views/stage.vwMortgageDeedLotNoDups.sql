SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


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
