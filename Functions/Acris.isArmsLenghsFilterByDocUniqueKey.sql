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

CREATE FUNCTION [Acris].[isArmsLenghsFilterByDocUniqueKey](@DeedDocumentUniqueKey VARCHAR(16))
RETURNS VARCHAR(20)
AS 
BEGIN
  
	DECLARE	@ret AS INT;

	SET @ret = (SELECT	COUNT(*)
				FROM	[Acris].tfnGetSimilarBuyersAndSellersOnDeed(@DeedDocumentUniqueKey) tk
               
			   );

	RETURN @ret;
    
END;
GO
