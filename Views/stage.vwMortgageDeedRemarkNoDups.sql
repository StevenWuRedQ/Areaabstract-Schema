SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [stage].[vwMortgageDeedRemarkNoDups]
AS 
SELECT a.RecordId
	  ,UniqueKey
      ,Sequence
      ,LTRIM(RTRIM([Text])) AS [Text]
FROM  [stage].[MortgageDeedRemark] a
INNER JOIN (SELECT MAX(RecordId) AS RecordId 
            FROM [stage].[MortgageDeedRemark]
           	GROUP BY UniqueKey, Sequence
		    ) b ON a.RecordId=b.RecordId
GO
