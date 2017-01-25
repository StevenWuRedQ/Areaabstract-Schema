SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [Acris].[vwReleasedOrWithdrawnFederalLien]
AS
SELECT a.UniqueKey FROM
(SELECT a.* FROM [Acris].[UCCMaster] a
WHERE a.DocumentTypeCode IN ('FL','CNFL')
) a
INNER JOIN 
(SELECT c.* FROM [Acris].[UCCMaster] a
INNER JOIN [Acris].[UCCCrossReference] c on c.UniqueKey=a.UniqueKey
WHERE a.DocumentTypeCode IN ('WFL','RFL')
) b ON a.CRFN=b.CRFN AND LEN(b.CRFN)>0
UNION ALL
SELECT a.UniqueKey FROM
(SELECT a.* FROM [Acris].[UCCMaster] a
WHERE a.DocumentTypeCode IN ('FL','CNFL')
) a
INNER JOIN 
(SELECT c.* FROM [Acris].[UCCMaster] a
INNER JOIN [Acris].[UCCCrossReference] c on c.UniqueKey=a.UniqueKey
WHERE a.DocumentTypeCode IN ('WFL','RFL')
) b ON a.UniqueKey=b.DocumentIdReference
UNION ALL
SELECT a.UniqueKey FROM
(SELECT a.* FROM [Acris].[UCCMaster] a
WHERE a.DocumentTypeCode IN ('FL','CNFL')
) a
INNER JOIN 
(SELECT c.* FROM [Acris].[UCCMaster] a
INNER JOIN [Acris].[UCCCrossReference] c on c.UniqueKey=a.UniqueKey
WHERE a.DocumentTypeCode IN ('WFL','RFL')
) b ON a.FileNumber=b.FileNumber AND LEN(a.FileNumber)>0
GO
