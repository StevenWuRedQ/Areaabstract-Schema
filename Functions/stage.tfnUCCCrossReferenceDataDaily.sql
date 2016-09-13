SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:			Raj Sethi

-- Date Created:	09/13/2016
	
-- Dates Modified:	

-- Description:		This function returns new records to be insert and records to be updates from stage.UCCCrossReference
--					

-- Input tables:	stage.UCCCrossReference and acris.UCCCrossReference

-- Tables modified: None

-- Arguments:		@operationFlag AS VARCHAR(1) 'A' returns records to be inserted and 'U' returns records to be updated
--					
-- Outputs:			Desired set of records

-- Where used:		acris.UCCCrossReferenceDataDailyImport Stored Procedure
-- =============================================
CREATE FUNCTION [stage].[tfnUCCCrossReferenceDataDaily](@operationFlag AS VARCHAR(1))
RETURNS TABLE
AS RETURN
(	
	SELECT	a.[UniqueKey]
		   ,a.[CRFN]
		   ,a.[DocumentIdReference]
		   ,a.FileNumber 	
		   ,GETDATE() AS DateLastUpdated
	FROM	[stage].[vwUCCCrossReferenceNoDups] a
	LEFT OUTER JOIN [Acris].[UCCCrossReference] b ON a.UniqueKey = b.UniqueKey
	WHERE	(b.UniqueKey IS NULL
			 AND @operationFlag = 'A'
			)
			OR (b.UniqueKey IS NOT NULL
				AND @operationFlag = 'U'
			   )
)



--SELECT * FROM [stage].[tfnUCCCrossReferenceDataDaily]('A')
GO
