SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vwCOSorMOCAfterLatestDeed]
AS
SELECT	a.BBLE 
		,IIF (((f.BBLE IS NULL) OR (f.BBLE IS NOT NULL AND f.DocumentDate<a.DocumentDate)), 0, 1) AS COSPresent
FROM [dbo].LatestDeedDocument a
LEFT OUTER JOIN AreaAbstractNew.[dbo].LatestContractOfSaleorMemorandumofContract f ON a.BBLE=f.BBLE
GO
