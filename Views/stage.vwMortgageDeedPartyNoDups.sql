SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:			Raj Sethi

-- Date Created:	09/07/2016
	
-- Dates Modified:	09/09/2016

-- Description:		This view removes duplicate records in an stagging table. 
--					The latest version of the record is considered for the import based on the Identity column RecordId.			

-- Input tables:	stage.MortgageDeedParty

-- Tables modified: None

-- Arguments:		
--					
-- Outputs:			Returns deupped set of records

-- Where used:		acris.tfnMortgageDeedPartyDataDailyImport Table Valued Function
-- =============================================

CREATE VIEW [stage].[vwMortgageDeedPartyNoDups]
AS 
SELECT	a.RecordId
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
FROM	[stage].[MortgageDeedParty] a
INNER JOIN (SELECT	MAX(RecordId) AS RecordId
			FROM	[stage].[MortgageDeedParty]
			GROUP BY UniqueKey
				   ,PartyType
				   ,[Name]
		   ) b ON a.RecordId = b.RecordId;
GO
