SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:					Raj Sethi

-- Creation date:			09/13/2016

-- Mofifications dates:		

-- Description:				rebase Mortgage and Deed Tables based on base tables created as og 09/09/2016
 

-- Input tables:			acris.UCCMasterBase20160909
--							acris.UCCLotBase20160909
--							acris.UCCPartyBase20160909WithDupMarker
--							acris.UCCCrossReferenceBase20160909
--							acris.UCCRemarkBase20160909
--							acris.UCCRemarkBase20160909Dups
--							

-- Tables modified:			acris.UCCMaster
--							acris.UCCLot
--							acris.UCCParty
--							acris.UCCCrossReference
--							acris.UCCRemark
-- Arguments:				
-- Outputs:					
-- Where used:				

-- =============================================
CREATE PROCEDURE [Acris].[ReBaseUCCTables]
AS
BEGIN
	TRUNCATE TABLE [Acris].[UCCMaster]
	INSERT INTO [Acris].[UCCMaster]
	SELECT * FROM  stage.UCCMasterBase20160909

	TRUNCATE TABLE acris.UCCLot
	INSERT INTO acris.UCCLot
	SELECT  *  FROM stage.UCCLotBase20160909

	TRUNCATE TABLE acris.UCCParty
	INSERT INTO acris.UCCParty
	SELECT [UniqueKey]
		  ,[PartyType]
		  ,[Name]
		  ,Utilities.[util].[fnGetAlphaNumeric]([Name]) AS [CompressedName]
		  ,[Address1]
		  ,[Address2]
		  ,[Country]
		  ,[City]
		  ,[State]
		  ,[Zip]
		  ,[DateLastUpdated]
	FROM stage.UCCPartyBase20160909WithDupMarker
	WHERE RowNumber=1

	TRUNCATE TABLE acris.UCCCrossReference
	INSERT INTO acris.UCCCrossReference
	SELECT  *  FROM stage.UCCCrossReferenceBase20160909


	TRUNCATE TABLE acris.UCCRemark
	INSERT	INTO Acris.UCCRemark
	SELECT	a.*
	FROM stage.UCCRemarkBase20160909 a
	LEFT OUTER JOIN stage.UCCRemarkBase20160909Dups b ON a.UniqueKey=b.UniqueKey
	WHERE b.UniqueKey IS NULL;
END;

GO
