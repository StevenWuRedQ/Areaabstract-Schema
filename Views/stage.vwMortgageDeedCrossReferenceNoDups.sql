SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- =============================================
-- Author:			Raj Sethi

-- Date Created:	09/06/2016
	
-- Dates Modified:	09/09/2016, 09/15/2016, 10/26/2016, 11/03/2016

-- Description:		This view removes duplicate records in an stagging table. 
--					The latest version of the record is considered for the import based on the Identity column RecordId.			

-- Input tables:	stage.[MortgageDeedCrossReference]

-- Tables modified: None

-- Arguments:		
--					
-- Outputs:			Returns deupped set of records

-- Where used:		acris.tfnMortgageDeedCrossReferenceDataDailyImport Table Valued Function
-- =============================================

CREATE VIEW [stage].[vwMortgageDeedCrossReferenceNoDups]
AS 
SELECT a.[RecordId]
      ,[Unique Key] AS UniqueKey
      , CASE 
			WHEN a.[CRFN] IS NULL THEN NULL
			WHEN LEN(Utilities.[util].[fnTrim]([CRFN]))=0 THEN NULL
			ELSE Utilities.[util].[fnTrim]([CRFN])
		END AS CRFN 
      ,CASE 
			WHEN a.[Doc_id_Ref] IS NULL THEN NULL
			WHEN LEN(Utilities.[util].[fnTrim](a.[Doc_id_Ref]))=0 THEN NULL
			ELSE Utilities.[util].[fnTrim](a.[Doc_id_Ref])
		END AS [DocumentIdReference]
      ,IIF(LEN(Utilities.[util].[fnTrim]([Reel_yr]))=0,'0000', Utilities.[util].[fnLPadString](Utilities.[util].[fnTrim]([Reel_yr]),'0',4)) AS ReelYear
	  ,IIF(LEN(Utilities.[util].[fnTrim]([Reel_Borough]))=0,'0', SUBSTRING(Utilities.[util].[fnTrim]([Reel_Borough]),1,1)) AS ReelBorough
      ,IIF(LEN(Utilities.[util].[fnTrim]([Reel_nbr]))=0,'00000', Utilities.[util].[fnLPadString](Utilities.[util].[fnTrim]([Reel_nbr]),'0', 5)) AS ReelNumber
      ,IIF(LEN(Utilities.[util].[fnTrim]([Reel_pg]))=0,'00000', Utilities.[util].[fnLPadString](Utilities.[util].[fnTrim]([Reel_pg]),'0',5)) AS ReelPage
FROM  [stage].[MortgageDeedCrossReference] a


GO
