SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:			George Vinsky, Raj Sethi

-- Date Created:	

-- Dates Modified:	10/19/2016

-- Description:		

-- Input tables:	
--
-- Tables modified: 

-- Arguments:		

-- Outputs:			

-- Where used:		
-- =============================================
CREATE VIEW [arm].[vwFilterSalesForArmsLengthCheck]
AS
    SELECT  s.BBLE,
            s.DeedUniqueKey,
            s.DocumentDate,
            s.DocumentAmount
    FROM    [dbo].[LatestValidSaleDeedDocument] s
    WHERE   (s.DocumentAmount > 10000 ) 
	AND (s.DocumentDate>=DATEADD(YEAR, -2, GETDATE()))



GO
