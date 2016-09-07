SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [stage].[vwMortgageDeedPartyNoDups]
AS 
SELECT a.RecordId
	  ,UniqueKey
      ,PartyType
	  ,LTRIM(RTRIM([Name])) AS Name
	  ,Utilities.util.[fnGetAlphaNumeric]([Name]) AS CompressedName
      ,LTRIM(RTRIM([Address1])) AS Address1
      ,LTRIM(RTRIM([Address2])) AS Address2
      ,[Country]
      ,LTRIM(RTRIM([City])) AS City
      ,[State]
      ,LTRIM(RTRIM([Zip])) AS Zip 
FROM  [stage].[MortgageDeedParty] a
INNER JOIN (SELECT MAX(RecordId) AS RecordId 
            FROM (SELECT RecordId, UniqueKey, PartyType, Utilities.util.[fnGetAlphaNumeric]([Name]) AS CompressedName FROM [stage].[MortgageDeedParty]) a
           	GROUP BY UniqueKey, PartyType, CompressedName
		    ) b ON a.RecordId=b.RecordId

GO
