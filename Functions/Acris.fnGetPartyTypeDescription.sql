SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [Acris].[fnGetPartyTypeDescription](@PartyType INT, @Party1 VARCHAR(19), @Party2 VARCHAR(20), @Party3 VARCHAR(20))
RETURNS VARCHAR(20) 
AS 
-- Returns the stock level for the product.
BEGIN
    DECLARE @ret VARCHAR(20);
	SET @ret = CASE @PartyType 
             WHEN 1 THEN @Party1
             WHEN 2 THEN @Party2
             WHEN 3 THEN @Party3
             ELSE 'ERROR'
           END;
     IF (@ret IS NULL) 
        SET @ret = 'ERROR';
    RETURN @ret;
END;
GO
