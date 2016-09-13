SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:			Raj Sethi

-- Date Created:	09/13/2016
	
-- Dates Modified:	

-- Description:		This view removes duplicate records in an stagging table. 
--					The latest version of the record is considered for the import based on the Identity column RecordId.			

-- Input tables:	stage.UCCParty

-- Tables modified: None

-- Arguments:		
--					
-- Outputs:			Returns deupped set of records

-- Where used:		acris.tfnUCCPartyDataDailyImport Table Valued Function
-- =============================================

CREATE VIEW [stage].[vwUCCPartyNoDups]
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
FROM	[stage].[UCCParty] a
INNER JOIN (SELECT	MAX(RecordId) AS RecordId
			FROM	[stage].[UCCParty]
			GROUP BY UniqueKey
				   ,PartyType
				   ,[Name]
		   ) b ON a.RecordId = b.RecordId;

GO
