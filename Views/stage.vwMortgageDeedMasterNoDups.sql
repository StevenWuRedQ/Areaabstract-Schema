SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [stage].[vwMortgageDeedMasterNoDups]
AS 
SELECT a.RecordId
	  ,UniqueKey
      ,[DateFileCreated]
      ,[CRFN]
      ,[RecordedBorough]
      ,[DocumentTypeCode]
      ,[DocumentDate]
      ,[DocumentAmount]
      ,[DateRecorded]
      ,[DateModified]
      ,[ReelYear]
      ,[ReelNumber]
      ,[ReelPage]
      ,[PercentageOftransaction]
FROM  [stage].[MortgageDeedMaster] a
INNER JOIN (SELECT MAX(RecordId) AS RecordId 
            FROM [stage].[MortgageDeedMaster]
			GROUP BY UniqueKey
		    ) b ON a.RecordId=b.RecordId
GO
