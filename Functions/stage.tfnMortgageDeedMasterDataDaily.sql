SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:			Raj Sethi

-- Date Created:	09/06/2016
	
-- Dates Modified:	

-- Description:		This function returns new records to be insert and records to be updates from stage.MortgageDeedMaster
--					

-- Input tables:	stage.MortgageDeedMaster and acris.MortgageDeedMaster

-- Tables modified: None

-- Arguments:		@operationFlag AS VARCHAR(1) 'A' returns records to be inserted and 'U' returns records to be updated
--					
-- Outputs:			Desired set of records

-- Where used:		acris.MortgageDeedMasterDataDailyImport Stored Procedure
-- =============================================
CREATE FUNCTION [stage].[tfnMortgageDeedMasterDataDaily](@operationFlag AS VARCHAR(1))
RETURNS TABLE
AS RETURN
(	
	SELECT	a.[UniqueKey]
		   ,CONVERT(DATE,REPLACE(a.[DateFileCreated],'/','-'),110) AS [DateFileCreated]
		   ,a.[CRFN]
		   ,a.[RecordedBorough]
		   ,a.[DocumentTypeCode]
		   ,CONVERT(DATE,REPLACE(a.[DocumentDate],'/','-'),110) AS [DocumentDate]
		   ,CONVERT(NUMERIC(14,2),a.[DocumentAmount]) AS [DocumentAmount]
		   ,CONVERT(DATE,REPLACE(a.[DateRecorded],'/','-'),110) AS [DateRecorded]
		   ,CONVERT(DATE,REPLACE(a.[DateModified],'/','-'),110) AS [DateModified]
		   ,a.[ReelYear]
		   ,a.[ReelNumber]
		   ,a.[ReelPage]
		   ,CONVERT(NUMERIC(15,6),IIF(a.[PercentageOftransaction]=' ', NULL,a.[PercentageOftransaction])) AS [PercentageOftransaction]
		   ,GETDATE() AS DateLastUpdated
	FROM	[stage].[vwMortgageDeedMasterNoDups] a
	LEFT OUTER JOIN [Acris].[MortgageDeedMaster] b ON a.UniqueKey = b.UniqueKey
	WHERE	(b.UniqueKey IS NULL
			 AND @operationFlag = 'A'
			)
			OR (b.UniqueKey IS NOT NULL
				AND @operationFlag = 'U'
			   )
)

--SELECT * FROM stage.tfnMortgageDeedMasterDataDaily('A')

GO
