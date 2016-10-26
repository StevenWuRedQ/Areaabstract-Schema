SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:			George Vinsky

-- Date Created:	

-- Dates Modified:	

-- Description:		

-- Input tables:	
--
-- Tables modified: 

-- Arguments:		

-- Outputs:			

-- Where used:		
-- =============================================
CREATE PROCEDURE [arm].[InsertArmsLengthSales]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--Init
	TRUNCATE TABLE arm.[ArmsLengthSales];

	INSERT	INTO arm.[ArmsLengthSales]
			([BBLE]
			,[DeedUniqueKey]
			,[DocumentDate]
			,[DocumentAmount]
			,[ArmsLength]
			)
	SELECT	[BBLE]
		   ,[DeedUniqueKey]
		   ,[DocumentDate]
		   ,[DocumentAmount]
		   ,CASE WHEN [Acris].[isArmsLenghsFilterByDocUniqueKey]([DeedUniqueKey]) = 0
				 THEN 1
				 ELSE 0
			END AS ArmsLength
	FROM	[arm].[vwFilterSalesForArmsLengthCheck];
				

END;
GO
