SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 

CREATE FUNCTION [Acris].[tfnGetSimilarBuyersAndSellersOnDeed]
    (
      @DeedDocumentUniqueKey VARCHAR(16)
    )
RETURNS @SimilarNames TABLE
    (
      -- Columns returned by the function
	  -- Each similar names case will yell a row with the names and the common token 
      DeedUniqueKey VARCHAR(16) ,
      BuyerFullName VARCHAR(500) NOT NULL ,
      SellerFullName VARCHAR(500) NOT NULL ,
      CommonToken VARCHAR(100)
    )
    BEGIN

 
 -- replace the exact exixting match (in this function) with a Jaro match
        INSERT  INTO @SimilarNames
                SELECT  @DeedDocumentUniqueKey AS DeedUniqueKey ,
                        SimilarNames.BuyerFullName AS BuyerFullName ,
                        SimilarNames.SellerFullName AS SellerFullName ,
                        SimilarNames.SellerToken AS CommonToken
                FROM    ( SELECT    BuyerFullName ,
                                    SellerFullName ,
                                    SellerToken
                          FROM      ( SELECT    RS.Name AS BuyerFullname ,
                                                RS.Token AS BuyerToken
                                      FROM      ( SELECT    [Name] ,
                                                            NP.Token AS Token
                                                  FROM      Acris.tfnGetDocumentPartiesByKey(@DeedDocumentUniqueKey,
                                                              'BUYER') PN
                                                            CROSS APPLY Utilities.util.tfnTokenize(PN.NAME,
                                                              ', "#().&/') NP
                                                ) RS
                                    ) Buyer
                                    INNER JOIN ( SELECT RS.Name AS SellerFullname ,
                                                        RS.Token AS SellerToken
                                                 FROM   ( SELECT
                                                              [Name] ,
                                                              NP.Token AS Token
                                                          FROM
                                                              Acris.tfnGetDocumentPartiesByKey(@DeedDocumentUniqueKey,
                                                              'SELLER') PN
                                                              CROSS APPLY Utilities.util.tfnTokenize(PN.NAME,
                                                              ', "#().&/') NP
                                                        ) RS
                                               ) Seller ON dbo.[StringDistance](LOWER(Buyer.BuyerToken), LOWER(Seller.SellerToken))>0.86-- Change to JAro >0.7
                        ) SimilarNames;

        RETURN;

    END;

GO
