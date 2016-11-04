SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:					Raj Sethi

-- Creation date:			10/26/2016

-- Mofifications dates:		11/02/2016, 11/02/2016 

-- Description:				Process ACRIS Cross Reference Table from Socrata and compares it with existing tables to find missing rows and add them to the table
 

-- Input tables:			
--							

-- Tables modified:			
-- Arguments:				
-- Outputs:					
-- Where used:				

-- =============================================
CREATE PROCEDURE [Acris].[InsertMissingACRISCRRows]
AS
BEGIN
	TRUNCATE TABLE stage.[MortgageDeedCrossReferenceOpenData];
	INSERT	INTO stage.[MortgageDeedCrossReferenceOpenData]
	SELECT	Utilities.[util].[fnTrim]([DOCUMENT ID]) AS [UniqueKey]
		   ,CASE WHEN [REFERENCE BY CRFN ] IS NULL THEN NULL
				 WHEN LEN(LTRIM([REFERENCE BY CRFN ])) = 0 THEN NULL
				 ELSE Utilities.[util].[fnTrim]([REFERENCE BY CRFN ])
			END AS CRFN
		   ,CASE WHEN [REFERENCE BY DOC ID] IS NULL THEN NULL
				 WHEN LEN(LTRIM([REFERENCE BY DOC ID])) = 0 THEN NULL
				 ELSE Utilities.[util].[fnTrim]([REFERENCE BY DOC ID])
			END AS [DocumentIdReference]
		   ,IIF(LEN(Utilities.[util].[fnTrim]([REFERENCE BY REEL YEAR])) = 0, '0000', Utilities.[util].[fnLPadString](Utilities.[util].[fnTrim]([REFERENCE BY REEL YEAR]),
															  '0', 4)) AS ReelYear
		   ,IIF(LEN(Utilities.[util].[fnTrim]([REFERENCE BY REEL BOROUGH])) = 0, '0', SUBSTRING([REFERENCE BY REEL BOROUGH],
															  1, 1)) AS [ReelBorough]
		   ,IIF(LEN(Utilities.[util].[fnTrim]([REFERENCE BY REEL NBR])) = 0, '00000', Utilities.[util].[fnLPadString](Utilities.[util].[fnTrim]([REFERENCE BY REEL NBR]),
															  '0', 5)) AS [ReelNumber]
		   ,IIF(LEN(Utilities.[util].[fnTrim]([REFERENCE BY REEL PAGE])) = 0, '00000', Utilities.[util].[fnLPadString](Utilities.[util].[fnTrim]([REFERENCE BY REEL PAGE]),
															  '0', 5)) AS [ReelPage]
		   ,NULL AS [DateLastUpdated]
	FROM	[stage].[MortgageDeedReferences_NYCOpendata_20161008]
	WHERE	((LEN(Utilities.[util].[fnTrim]([REFERENCE BY DOC ID])) <= 16)
			 AND (LEN(Utilities.[util].[fnTrim]([REFERENCE BY CRFN ])) <= 13)
			 AND LEN(Utilities.[util].[fnTrim]([DOCUMENT ID])) = 16
			 AND (LEN(Utilities.[util].[fnTrim]([REFERENCE BY REEL YEAR])) <= 4)
			 AND (LEN(Utilities.[util].[fnTrim]([REFERENCE BY REEL NBR])) <= 5)
			 AND (LEN(Utilities.[util].[fnTrim]([REFERENCE BY REEL PAGE])) <= 5)
			);

	DECLARE	@COUNT1 AS INTEGER
		   ,@COUNT2 AS INTEGER;


	SELECT	@COUNT1 = COUNT(*)
	FROM	[stage].[MortgageDeedReferences_NYCOpendata_20161008];
	SELECT	@COUNT1 = COUNT(*)
	FROM	[stage].[MortgageDeedCrossReferenceOpenData];

	IF @COUNT1 <> @COUNT2
		RETURN -1;

	TRUNCATE TABLE [stage].[MortgageDeedCrossReference_Missing];
	INSERT	INTO [stage].[MortgageDeedCrossReference_Missing]
	SELECT	a.*
		   ,NULL AS DateLastUpdated
	FROM	(SELECT	[UniqueKey]
				   ,[CRFN]
				   ,[DocumentIdReference]
				   ,[ReelYear]
				   ,[ReelBorough]
				   ,[ReelNumber]
				   ,[ReelPage]
			 FROM	stage.[MortgageDeedCrossReferenceOpenData]
			 EXCEPT
			 SELECT	[UniqueKey]
				   ,[CRFN]
				   ,[DocumentIdReference]
				   ,[ReelYear]
				   ,[ReelBorough]
				   ,[ReelNumber]
				   ,[ReelPage]
			 FROM	[Acris].[MortgageDeedCrossReference]
			) a;

	INSERT INTO [Acris].[MortgageDeedCrossReference]
	SELECT * FROM [stage].[MortgageDeedCrossReference_Missing]

END;

/*
SELECT * FROM [stage].[MortgageDeedCrossReference_Missing] where uniquekey='2010101100538001'
UNION
SELECT * FROM [acris].[MortgageDeedCrossReference] where uniquekey='2010101100538001'

INSERT INTO [Acris].[MortgageDeedCrossReference_20161103]
SELECT * FROM [Acris].[MortgageDeedCrossReference]
*/
GO
