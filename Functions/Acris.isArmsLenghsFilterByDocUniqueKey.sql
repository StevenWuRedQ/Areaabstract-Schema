SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE FUNCTION [Acris].[isArmsLenghsFilterByDocUniqueKey]
    (
      @DeedDocumentUniqueKey VARCHAR(16)
    )
RETURNS VARCHAR(20)
AS -- Returns the stock level for the product.
    BEGIN
  
        DECLARE @ret AS INT;

        SET @ret = ( SELECT COUNT(*)
                     FROM  [Acris].tfnGetSimilarBuyersAndSellersOnDeed(@DeedDocumentUniqueKey) tk
                          -- WHERE Utilities.dbo.fnIsStopWord(tk.CommonToken)=0
                   )

        RETURN @ret;
    
    END;
GO
