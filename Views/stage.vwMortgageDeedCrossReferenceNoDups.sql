SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


/****** Script for SelectTopNRows command from SSMS  ******/
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
