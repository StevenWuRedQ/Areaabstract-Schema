SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:			Raj Sethi

-- Date Created:	09/13/2016
	
-- Dates Modified:	

-- Description:		This function returns new records to be insert and records to be updates from stage.UCCMaster
--					

-- Input tables:	stage.UCCMaster and acris.UCCMaster

-- Tables modified: None

-- Arguments:		@operationFlag AS VARCHAR(1) 'A' returns records to be inserted and 'U' returns records to be updated
--					
-- Outputs:			Desired set of records

-- Where used:		acris.UCCMasterDataDailyImport Stored Procedure
-- =============================================
CREATE FUNCTION [stage].[tfnUCCMasterDataDaily](@operationFlag AS VARCHAR(1))
RETURNS TABLE
AS RETURN
(	
	SELECT	a.[UniqueKey]
		   ,CONVERT(DATE,REPLACE(a.[Date File Created],'/','-'),110) AS [DateFileCreated]
		   ,a.[CRFN]
		   ,a.[Recorded_borough] AS RecordedBorough
		   ,a.[Doc_Type] AS [DocumentTypeCode]
		   ,CONVERT(NUMERIC(14,2),a.[Document_amt]) AS [DocumentAmount]
		   ,CONVERT(DATE,REPLACE(a.[Recorded_datetime],'/','-'),110) AS [DateRecorded]
		   ,a.[Ucc_Collateral] AS UCCCollateral
		   ,LTRIM(RTRIM(a.[Fedtax_serial_nbr])) AS FederalTaxSerialNumber
		   ,CONVERT(DATE,REPLACE(a.[Fedtax_assessment_date],'/','-'),110) AS [FederalTaxAssessmentDate]
		   ,LTRIM(RTRIM(a.[Rpttl_nbr])) AS RPTTLNumber
		   ,CONVERT(DATE,REPLACE(a.[Modified date],'/','-'),110) AS [DateModified]
		   ,a.[Reel_yr] AS ReelYear
		   ,a.[Reel_nbr] AS ReelNumber
		   ,a.[Reel_pg] AS ReelPage
		   ,LTRIM(RTRIM(a.[File_nbr])) AS FileNumber
		   ,GETDATE() AS DateLastUpdated
	FROM	[stage].[vwUCCMasterNoDups] a
	LEFT OUTER JOIN [Acris].[UCCMaster] b ON a.UniqueKey = b.UniqueKey
	WHERE	(b.UniqueKey IS NULL
			 AND @operationFlag = 'A'
			)
			OR (b.UniqueKey IS NOT NULL
				AND @operationFlag = 'U'
			   )
)



GO
