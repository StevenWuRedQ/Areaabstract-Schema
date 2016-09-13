SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:			Raj Sethi

-- Date Created:	09/13/2016
	
-- Dates Modified:	

-- Description:		This function returns new records to be insert and records to be updates from stage.UCCParty
--					

-- Input tables:	stage.UCCParty and acris.UCCParty

-- Tables modified: None

-- Arguments:		@operationFlag AS VARCHAR(1) 'A' returns records to be inserted and 'U' returns records to be updated
--					
-- Outputs:			Desired set of records

-- Where used:		acris.UCCPartyDataDailyImport Stored Procedure
-- =============================================
CREATE FUNCTION [stage].[tfnUCCPartyDataDaily](@operationFlag AS VARCHAR(1))
RETURNS TABLE
AS RETURN
(	
	SELECT	a.[UniqueKey]
		   ,a.[PartyType]
		   ,a.[Name]
		   ,a.[CompressedName]
		   ,a.[Address1]
		   ,a.[Address2]
		   ,a.[Country]
		   ,a.[City]
		   ,a.[State]
		   ,a.[Zip]
		   ,GETDATE() AS DateLastUpdated
	FROM	[stage].[vwUCCPartyNoDups] a
	LEFT OUTER JOIN [Acris].[UCCParty] b ON a.UniqueKey = b.UniqueKey
											AND a.PartyType = b.PartyType
											AND a.[Name] = b.[Name]
	WHERE	(b.UniqueKey IS NULL
			 AND @operationFlag = 'A'
			)
			OR (b.UniqueKey IS NOT NULL
				AND a.Name = b.Name
				AND @operationFlag = 'U'
			   )
		
/*
	LEFT OUTER JOIN [Acris].[UCCParty] b ON a.UniqueKey = b.UniqueKey
													 AND a.PartyType = b.PartyType
													 AND a.[CompressedName] = b.[CompressedName]
	WHERE	(b.UniqueKey IS NULL
			 AND @operationFlag = 'A'
			)
			OR (b.UniqueKey IS NOT NULL
				AND a.Name != b.Name
				AND (dbo.fnCompareString(a.Address1,b.Address1)!=0
					 OR dbo.fnCompareString(a.Address2,b.Address2)!=0
					 OR dbo.fnCompareString(a.Country,b.Country)!=0
					 OR dbo.fnCompareString(a.[State],b.[State])!=0
					 OR dbo.fnCompareString(a.Zip,b.Zip)!=0
					)
				AND @operationFlag = 'A'
			   )
			OR (b.UniqueKey IS NOT NULL
				AND a.Name = b.Name
				AND @operationFlag = 'U'
			   )
			OR (b.UniqueKey IS NOT NULL
				AND a.Name != b.Name
				AND dbo.fnCompareString(a.Address1,b.Address1)=0
				AND dbo.fnCompareString(a.Address2,b.Address2)=0
				AND dbo.fnCompareString(a.Country,b.Country)=0
				AND dbo.fnCompareString(a.[State],b.[State])=0
				AND dbo.fnCompareString(a.Zip,b.Zip)=0
				AND @operationFlag = 'U'
			   )
*/
)

-- SELECT * FROM [stage].[tfnUCCPartyDataDaily]('A')
-- SELECT  



GO
