SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [Acris].[vwLatestDeedParties]
AS
SELECT	a.BBLE
	   ,a.DeedUniqueKey
	   ,b.Name AS PartyName
	   ,b.Address1
	   ,b.Address2
	   ,b.City
	   ,b.[State]
	   ,b.Zip
	   ,b.Country
	   ,CASE b.PartyType
		  WHEN '2' THEN 'Buyer'
		  WHEN '1' THEN 'Seller'
		END AS PartyType
FROM	dbo.LatestDeedDocument a
LEFT OUTER JOIN Acris.MortgageDeedParty b ON a.DeedUniqueKey = b.UniqueKey;
  

GO
