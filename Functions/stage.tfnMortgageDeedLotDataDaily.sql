SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:			Raj Sethi

-- Date Created:	09/06/2016
	
-- Dates Modified:	

-- Description:		This function returns new records to be insert and records to be updates from stage.MortgageDeedLot
--					

-- Input tables:	stage.MortgageDeedLot and acris.MortgageDeedLot

-- Tables modified: None

-- Arguments:		@operationFlag AS VARCHAR(1) 'A' returns records to be inserted and 'U' returns records to be updated
--					
-- Outputs:			Desired set of records

-- Where used:		acris.MortgageDeedLotDataDailyImport Stored Procedure
-- =============================================
CREATE FUNCTION [stage].[tfnMortgageDeedLotDataDaily](@operationFlag AS VARCHAR(1))
RETURNS TABLE
AS RETURN
(	
	SELECT	a.[Borough] + a.[Block] + a.[Lot] AS BBL
		   ,a.[UniqueKey]
		   ,a.[Borough]
		   ,a.[Block]
		   ,a.[Lot]
		   ,a.[Easement]
		   ,a.[PartialLot]
		   ,a.[AirRights]
		   ,a.[SubterraneanRights]
		   ,a.[PropertyTypeCode]
		   ,a.[StreetNumber]
		   ,a.[StreetName]
		   ,a.[UnitNumber]
		   ,GETDATE() AS DateLastUpdated
	FROM	[stage].[vwMortgageDeedLotNoDups] a
	LEFT OUTER JOIN [Acris].[MortgageDeedLot] b ON a.UniqueKey = b.UniqueKey
												   AND a.Borough = b.Borough
												   AND a.Block = b.block
												   AND a.lot = b.lot
												   AND a.Easement = b.Easement
	WHERE	(b.UniqueKey IS NULL
			 AND @operationFlag = 'A'
			)
			OR (b.UniqueKey IS NOT NULL
				AND @operationFlag = 'U'
			   )
)

-- SELECT * FROM [stage].[tfnMortgageDeedLotDataDaily]('U')



GO
