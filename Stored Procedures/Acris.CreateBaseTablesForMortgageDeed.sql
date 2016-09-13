SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:					Raj Sethi

-- Creation date:			09/09/2016

-- Mofifications dates:		

-- Description:				Create basedata tables from current AreaAbstract Data (base from Socrata 
 

-- Input tables:			AreaAbstract.acris.ACRIS_MASTER
--							acris.tfnMortgageDeedMasterDataDaily
--							

-- Tables modified:			acris.MortgageDeedMaster

-- Arguments:				
-- Outputs:					
-- Where used:				

-- =============================================
CREATE PROCEDURE [Acris].[CreateBaseTablesForMortgageDeed]
AS
BEGIN
	
	SELECT	[Unique_Key] AS UniqueKey
		   ,[Date_File_Created] AS DateFileCreated
		   ,[CRFN]
		   ,[Recorded_Borough] AS RecordedBorough
		   ,[Doc_Type] AS DocumentTypeCode
		   ,[Document_Date] AS DocumentDate
		   ,[Document_Amt] AS DocumentAmount
		   ,[Recorded_Date] AS DateRecorded
		   ,[Modified_date] AS DateModified
		   ,[Reel_yr] AS ReelYear
		   ,[Reel_nbr] AS RealNumber
		   ,[Reel_pg] AS ReelPage
		   ,IIF([Percent_trans] = 0.0, NULL, [Percent_trans]) AS PercentageOfTransaction
		   ,[LastUpdated] AS DateLastUpdated
	INTO	Acris.MortgageDeedMasterBase20160909
	FROM	AreaAbstract.[Acris].[ACRIS_MASTER];

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
	INTO	Acris.MortgageDeedLotBase20160909
	FROM	AreaAbstract.[Acris].[ACRIS_LOTS];

	
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
	INTO	stage.MortgageDeedPartyBase20160909
	FROM	AreaAbstract.[Acris].[ACRIS_PARTIES]; 

	SELECT *, ROW_NUMBER() OVER(PARTITION BY UniqueKey,PartyType,Name ORDER BY UniqueKey,PartyType,Name) AS RowNumber 
	INTO acris.MortgageDeedPartyBase20160909WithDupMarker
	FROM stage.MortgageDeedPartyBase20160909

	SELECT	UniqueKey
		   ,PartyType
		   ,Name
	INTO	Acris.MortgageDeedPartyBase20160909Dups
	FROM	stage.MortgageDeedPartyBase20160909
	GROUP BY UniqueKey
		   ,PartyType
		   ,Name
	HAVING	COUNT(*) > 1;

	SELECT	[Unique_key] AS UniqueKey
		   ,LTRIM(RTRIM([CRFN])) AS CRFN
		   ,LTRIM(RTRIM([Doc_id_ref])) AS DocumentIdReference
		   ,[Reel_yr] AS ReelYear
		   ,[Reel_borough] AS ReelBorough
		   ,[Reel_nbr] AS ReelNumber
		   ,[Reel_pg] AS ReelPage
		   ,[LastUpdated] AS DateLastUpdated
	INTO	Acris.MortgageDeedCrossReferenceBase20160909
	FROM	AreaAbstract.[Acris].[ACRIS_REFERENCES]; 

	SELECT	[Unique_key] AS UniqueKey
			,Utilities.util.fnLPadString(Seq,'0',2) AS [Sequence]
			,LTRIM(RTRIM([Text])) AS [Text]
			,[LastUpdated] AS DateLastUpdated
	INTO	stage.MortgageDeedRemarkBase20160909
	FROM	AreaAbstract.[Acris].[ACRIS_REMARKS]; 

	-- All Duplicate Records
	DROP TABLE Acris.MortgageDeedRemarkBase20160909Dups;
	SELECT	ar.UniqueKey
		   ,ar.[Sequence]
		   ,ar.[Text]
		   ,ar.DateLastUpdated
	INTO	Acris.MortgageDeedRemarkBase20160909Dups
	FROM	stage.MortgageDeedRemarkBase20160909 ar
	INNER JOIN (SELECT	ar.Uniquekey
					   ,ar.[Sequence]
					   ,COUNT(*) [Count]
				FROM	stage.MortgageDeedRemarkBase20160909 ar
				GROUP BY ar.Uniquekey
					   ,ar.Sequence
				HAVING	COUNT(*) > 1
			   ) a ON a.Uniquekey = ar.Uniquekey
	ORDER BY ar.Uniquekey
		   ,ar.Sequence;
END;

GO
