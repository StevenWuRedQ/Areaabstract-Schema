SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:					Raj Sethi

-- Creation date:			09/13/2016

-- Mofifications dates:		

-- Description:				Create basedata tables from current AreaAbstract Data (base from Socrata 
 

-- Input tables:			AreaAbstract.acris.ACRIS_MASTER
--							acris.tfnUCCMasterDataDaily
--							

-- Tables modified:			acris.UCCMasterBase20160909
--							acris.UCCLotBase20160909
--							acris.UCCPartyBase20160909
--							acris.UCCCrossReferenceBase20160909
--							acris.UCCRemarkBase20160909

-- Arguments:				
-- Outputs:					
-- Where used:				

-- =============================================
CREATE PROCEDURE [Acris].[CreateBaseTablesForUCC]
AS
BEGIN
	
	SELECT	[Unique_Key] AS UniqueKey
		   ,[Date_File_Created] AS DateFileCreated
		   ,LTRIM(RTRIM([CRFN])) AS CRFN
		   ,[Recorded_Borough] AS RecordedBorough
		   ,[Doc_Type] AS DocumentTypeCode
		   ,[Document_Amt] AS DocumentAmount
		   ,[Recorded_Date] AS DateRecorded
		   ,[Ucc_collateral] AS UCCCollateral
		   ,LTRIM(RTRIM([Fedtax_serial_nbr])) AS FederalTaxSerialNumber
		   ,LTRIM(RTRIM([Fedtax_assessment_date])) AS FederalTaxAssessmentDate
		   ,LTRIM(RTRIM(Rpttl_nbr)) AS RPTTLNumber
		   ,[Modified_date] AS DateModified
		   ,[Reel_yr] AS ReelYear
		   ,[Reel_nbr] AS RealNumber
		   ,[Reel_pg] AS ReelPage
		   ,LTRIM(RTRIM([File_nbr])) AS FileNumber
		   ,[LastUpdated] AS DateLastUpdated
	INTO	Acris.UCCMasterBase20160909
	FROM	AreaAbstract.[UCC].[UCC_MASTER];

	SELECT	[Borough] + Utilities.util.fnLPadString([Block], '0', 5) + Utilities.util.fnLPadString([Lot], '0', 4) AS BBL	   
		   ,[Unique_Key] AS UniqueKey
		   ,[Borough]
		   ,Utilities.util.fnLPadString([Block], '0', 5) AS Block
		   ,Utilities.util.fnLPadString([Lot], '0', 4) AS Lot
		   ,[Easement]
		   ,[Partial_lot] AS PartialLot
		   ,[Air_rights] AS AirRights
		   ,[Subterranean_rights] AS SubterraneanRights
		   ,[Property_type] AS PropertyType
		   ,[Street_number] AS StreetNumber
		   ,[Street_name] AS StreetName
		   ,[Addr_unit] AS UnitNumber
		   ,[LastUpdated] AS DateLastUpdated
	INTO	Acris.UCCLotBase20160909
	FROM	AreaAbstract.[ucc].[UCC_LOTS] AS [ul];

	
	SELECT	[Unique_key] AS UniqueKey
		   ,[Party_type] AS PartyType
		   ,LTRIM(RTRIM([Name])) AS [Name]
		   ,Utilities.util.fnGetAlphaNumeric([Name]) AS CompressedName
		   ,LTRIM(RTRIM([Addr1])) AS Address1
		   ,LTRIM(RTRIM([Addr2])) AS Address2
		   ,[Country]
		   ,LTRIM(RTRIM([City])) AS City
		   ,[State]
		   ,[Zip]
		   ,[LastUpdated] AS DateLastUpdated
	INTO	stage.UCCPartyBase20160909
	FROM	AreaAbstract.[UCC].[UCC_PARTIES]; 

	SELECT	UniqueKey
		   ,PartyType
		   ,Name
	INTO	Acris.UCCPartyBase20160909Dups
	FROM	stage.UCCPartyBase20160909
	GROUP BY UniqueKey
		   ,PartyType
		   ,Name
	HAVING	COUNT(*) > 1;

	SELECT	[Unique_key] AS UniqueKey
		   ,LTRIM(RTRIM([CRFN])) AS CRFN
		   ,LTRIM(RTRIM([Doc_id_ref])) AS DocumentIdReference
		   ,LTRIM(RTRIM([File_nbr])) AS FileNumber
		   ,[LastUpdated] AS DateLastUpdated
	INTO	Acris.UCCCrossReferenceBase20160909
	FROM	AreaAbstract.[ucc].[UCC_REFERENCES]; 

	SELECT	[Unique_key] AS UniqueKey
			,Seq AS [Sequence]
			,LTRIM(RTRIM([Text])) AS [Text]
			,[LastUpdated] AS DateLastUpdated
	INTO	stage.UCCRemarkBase20160909
	FROM	AreaAbstract.[ucc].[UCC_REMARKS]; 

	-- All Duplicate Records
	DROP TABLE Acris.UCCRemarkBase20160909Dups;
	SELECT	ar.UniqueKey
		   ,ar.[Sequence]
		   ,ar.[Text]
		   ,ar.DateLastUpdated
	INTO	Acris.UCCRemarkBase20160909Dups
	FROM	stage.UCCRemarkBase20160909 ar
	INNER JOIN (SELECT	ar.Uniquekey
					   ,ar.[Sequence]
					   ,COUNT(*) [Count]
				FROM	stage.UCCRemarkBase20160909 ar
				GROUP BY ar.Uniquekey
					   ,ar.Sequence
				HAVING	COUNT(*) > 1
			   ) a ON a.Uniquekey = ar.Uniquekey
	ORDER BY ar.Uniquekey
		   ,ar.Sequence;
END;

GO
