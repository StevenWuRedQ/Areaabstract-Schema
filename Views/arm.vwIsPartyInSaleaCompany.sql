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

CREATE VIEW [arm].[vwIsPartyInSaleaCompany]
AS
SELECT	a.DeedUniqueKey
	   ,a.Name
	   ,a.Partytype AS Party_Type
	   ,a.IsSellerACompany
	   ,a.IsBuyerACompany
FROM	(SELECT	t.DeedUniqueKey
			   ,t.Name
			   ,t.PartyType
			   ,t.IsSellerACompany
			   ,t.IsBuyerACompany
			   ,ROW_NUMBER() OVER (PARTITION BY t.DeedUniqueKey, t.Partytype ORDER BY t.Partytype) AS row_Num
			--,0 AS ArmsLength
		 FROM	(SELECT	s.DeedUniqueKey
					   ,p.Name
					   ,n.token AS NameToken
					   ,c.Token AS CompanyToken
					   ,p.PartyType
					   ,s.ArmsLength
					   ,CASE WHEN n.token = c.Token
								  AND p.PartyType = 1 THEN 1
							 ELSE 0
						END AS IsSellerACompany
					   ,CASE WHEN n.token = c.Token
								  AND p.PartyType = 2 THEN 1
							 ELSE 0
						END AS IsBuyerACompany
				 FROM	arm.[ArmsLengthSales] s
				 INNER JOIN  [Acris].[MortgageDeedParty] p ON p.Uniquekey = s.DeedUniqueKey
				 CROSS APPLY Utilities.util.tfnTokenize(p.Name, ', "#().&/') AS n
				 LEFT OUTER JOIN Utilities.dbo.CompanyNameToken AS c ON n.token = c.Token
				) t
		 WHERE	t.IsSellerACompany = 1
				OR t.IsBuyerACompany = 1
		) a
WHERE	a.row_Num = 1;
   


GO
