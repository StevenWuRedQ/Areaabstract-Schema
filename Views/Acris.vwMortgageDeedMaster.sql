SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [Acris].[vwMortgageDeedMaster]
AS
--INSERT INTO [Acris].[MortgageDeedMaster]
SELECT  [UniqueKey]
      ,[DateFileCreated]
      ,CASE 
			WHEN LEN(LTRIM([CRFN]))=0 THEN NULL
			WHEN CRFN IS NULL THEN NULL
			ELSE CRFN
		END AS CRFN				
      ,[RecordedBorough]
      ,[DocumentTypeCode]
      ,[DocumentDate]
      ,[DocumentAmount]
      ,[DateRecorded]
      ,[DateModified]
      ,Utilities.[util].[fnLPadString]([ReelYear],'0',4) AS [ReelYear]
      ,Utilities.[util].[fnLPadString]([ReelNumber],'0',5) AS [ReelNumber]
      ,Utilities.[util].[fnLPadString]([ReelPage],'0',5) AS [ReelPage]
      ,[PercentageOftransaction]
      ,[DateLastUpdated]
  FROM [Acris].[MortgageDeedMaster_Old]
 
GO
