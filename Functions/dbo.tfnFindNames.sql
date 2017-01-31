SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:			Raj Sethi

-- Date Created:	
	
-- Dates Modified:	

-- Description:		
--					

-- Input tables:	

-- Tables modified: None

-- Arguments:		
--					
-- Outputs:			

-- Where used:		
-- =============================================
CREATE FUNCTION [dbo].[tfnFindNames](@Name VARCHAR(250))
RETURNS TABLE
AS RETURN
(	
	SELECT Name FROM dbo.UniqueNames WHERE CONTAINS(Name,@Name)
)



--SELECT * FROM [stage].[tfnUCCRemarkDataDaily]('A')
GO
