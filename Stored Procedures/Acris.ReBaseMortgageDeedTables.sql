SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:					Raj Sethi

-- Creation date:			09/13/2016

-- Mofifications dates:		

-- Description:				rebase Mortgage and Deed Tables based on base tables created as og 09/09/2016
 

-- Input tables:			acris.MortgageDeedMasterBase20160909
--							acris.MortgageDeedLotBase20160909
--							acris.MortgageDeedPartyBase20160909WithDupMarker
--							acris.MortgageDeedCrossReferenceBase20160909
--							acris.MortgageDeedRemarkBase20160909
--							acris.MortgageDeedRemarkBase20160909Dups
--							

-- Tables modified:			acris.MortgageDeedMaster
--							acris.MortgageDeedLot
--							acris.MortgageDeedParty
--							acris.MortgageDeedCrossReference
--							acris.MortgageDeedRemark
-- Arguments:				
-- Outputs:					
-- Where used:				

-- =============================================
CREATE PROCEDURE [Acris].[ReBaseMortgageDeedTables]
AS
BEGIN
	TRUNCATE TABLE [Acris].[MortgageDeedMaster]
	INSERT INTO [Acris].[MortgageDeedMaster]
	SELECT * FROM  stage.MortgageDeedMasterBase20160909

	TRUNCATE TABLE acris.MortgageDeedLot
	INSERT INTO acris.MortgageDeedLot
	SELECT  *  FROM stage.MortgageDeedLotBase20160909

	TRUNCATE TABLE acris.MortgageDeedParty
	INSERT INTO acris.MortgageDeedParty
	SELECT [UniqueKey]
		  ,[PartyType]
		  ,[Name]
		  ,[CompressedName]
		  ,[Address1]
		  ,[Address2]
		  ,[Country]
		  ,[City]
		  ,[State]
		  ,[Zip]
		  ,[DateLastUpdated]
	FROM stage.MortgageDeedPartyBase20160909WithDupMarker
	WHERE RowNumber=1

	TRUNCATE TABLE acris.MortgageDeedCrossReference
	INSERT INTO acris.MortgageDeedCrossReference
	SELECT  *  FROM stage.MortgageDeedCrossReferenceBase20160909


	TRUNCATE TABLE acris.MortgageDeedRemark
	INSERT	INTO Acris.MortgageDeedRemark
	SELECT	a.*
	FROM stage.MortgageDeedRemarkBase20160909 a
	LEFT OUTER JOIN stage.MortgageDeedRemarkBase20160909Dups b ON a.UniqueKey=b.UniqueKey
	WHERE b.UniqueKey IS NULL;
END;

GO
