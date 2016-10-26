SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [Acris].[vwMortgageDeedCrossReference]
AS
--INSERT INTO [Acris].[MortgageDeedCrossReference]
SELECT [UniqueKey]
	  , CASE 
			WHEN [CRFN] IS NULL THEN NULL
			WHEN LEN(LTRIM(CRFN))=0 THEN NULL
			ELSE [CRFN] 
		END AS CRFN 
      ,[DocumentIdReference]
      ,Utilities.[util].[fnLPadString]([ReelYear],'0',4) AS ReelYear
      ,[ReelBorough]
      ,Utilities.[util].[fnLPadString]([ReelNumber],'0',5) AS [ReelNumber]
      ,Utilities.[util].[fnLPadString]([ReelPage],'0',5) AS [ReelPage]
      ,[DateLastUpdated]
  FROM [Acris].[MortgageDeedCrossReference_old]

GO
