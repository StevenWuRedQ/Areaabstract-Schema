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
CREATE PROCEDURE [arm].[InsertIntoSalesAreCompany]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	TRUNCATE TABLE arm.SalesAreCompany;
       
	INSERT	INTO arm.SalesAreCompany
	SELECT	*
	FROM	[arm].[vwIsPartyInSaleaCompany];

END;
GO
