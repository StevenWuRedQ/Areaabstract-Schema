SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/* This is a temporary view */

/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [Acris].[vwMortgageDeedCrossReference]
AS
--INSERT INTO [Acris].[MortgageDeedCrossReferenceOpenData]
SELECT Utilities.[util].[fnTrim]([DOCUMENT ID]) AS [UniqueKey]
	  , CASE 
			WHEN [REFERENCE BY CRFN ] IS NULL THEN NULL
			WHEN LEN(LTRIM([REFERENCE BY CRFN ]))=0 THEN NULL
			ELSE Utilities.[util].[fnTrim]([REFERENCE BY CRFN ])
		END AS CRFN 
	  , CASE 
			WHEN [REFERENCE BY DOC ID] IS NULL THEN NULL
			WHEN LEN(LTRIM([REFERENCE BY DOC ID]))=0 THEN NULL
			ELSE Utilities.[util].[fnTrim]([REFERENCE BY DOC ID])
		END AS [DocumentIdReference]
      ,IIF(LEN(Utilities.[util].[fnTrim]([REFERENCE BY REEL YEAR]))=0,'0000',Utilities.[util].[fnLPadString](Utilities.[util].[fnTrim]([REFERENCE BY REEL YEAR]),'0',4)) AS ReelYear
      ,IIF(LEN(Utilities.[util].[fnTrim]([REFERENCE BY REEL BOROUGH]))=0,'0',SUBSTRING([REFERENCE BY REEL BOROUGH],1,1)) AS [ReelBorough]
      ,IIF(LEN(Utilities.[util].[fnTrim]([REFERENCE BY REEL NBR]))=0,'00000',Utilities.[util].[fnLPadString](Utilities.[util].[fnTrim]([REFERENCE BY REEL NBR]),'0',5)) AS [ReelNumber]
      ,IIF(LEN(Utilities.[util].[fnTrim]([REFERENCE BY REEL PAGE]))=0,'00000',Utilities.[util].[fnLPadString](Utilities.[util].[fnTrim]([REFERENCE BY REEL PAGE]),'0',5)) AS [ReelPage]
      ,NULL AS [DateLastUpdated]
  FROM [stage].[MortgageDeedReferences_NYCOpendata_20161008]
  WHERE ((LEN(Utilities.[util].[fnTrim]([REFERENCE BY DOC ID]))<=16 )
		AND (LEN(Utilities.[util].[fnTrim]([REFERENCE BY CRFN ]))<=13 )
		AND LEN(Utilities.[util].[fnTrim]([DOCUMENT ID]))=16
		AND (LEN(Utilities.[util].[fnTrim]([REFERENCE BY REEL YEAR]))<=4) 
		AND (LEN(Utilities.[util].[fnTrim]([REFERENCE BY REEL NBR]))<=5)
		AND (LEN(Utilities.[util].[fnTrim]([REFERENCE BY REEL PAGE]))<=5))



GO
