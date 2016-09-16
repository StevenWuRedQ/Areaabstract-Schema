SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:					Raj Sethi

-- Creation date:			08/31/2016

-- Mofifications dates:		09/09/2016, 09/14/2016

-- Description:				This stored procedure is used In SSIS packages in AreaAbstractACRISImport project. 
--							The procedure calls the appropriate stored procedure depending on the tablemnemonic to process the daily import
 
-- Input tables:			None
--						
-- Tables modified:			None

-- Arguments:				@DateTimeStampStr - DateTimeStamp of when the actual daily import file was created 
--							@tableMnemonic	-	3 to 10 character mnemonic for the staging table 

-- Outputs:					ErrorCode

-- Where used:				In SSIS packages in AreaAbstractACRISImport

-- =============================================
CREATE PROCEDURE [dbo].[ProcessDailyImport](@DateTimeStampStr AS VARCHAR(20), @tableMnemonic AS VARCHAR(10))
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @errorCode AS INTEGER
	DECLARE @errorMessage AS VARCHAR(MAX)
	
	SET @tableMnemonic=LTRIM(RTRIM(@tableMnemonic))
			
	IF @tableMnemonic='MORTDEED'
	BEGIN
		BEGIN TRY 
			BEGIN TRANSACTION
				EXEC @errorCode=[Acris].[MortgageDeedMasterDataDailyImport] @DateTimeStampStr
		
				EXEC @errorCode=[Acris].[MortgageDeedPartyDataDailyImport] @DateTimeStampStr
		
				EXEC @errorCode=[Acris].[MortgageDeedLotDataDailyImport] @DateTimeStampStr
		
				EXEC @errorCode=[Acris].[MortgageDeedRemarkDataDailyImport] @DateTimeStampStr
		
				EXEC @errorCode=[Acris].[MortgageDeedCrossReferenceDataDailyImport] @DateTimeStampStr
		
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION;
			THROW;
		END CATCH
	END
	ELSE IF @tableMnemonic='UCC'
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION

				EXEC @errorCode=[Acris].[UCCMasterDataDailyImport] @DateTimeStampStr;
		
				EXEC @errorCode=[Acris].[UCCPartyDataDailyImport] @DateTimeStampStr;
			
				EXEC @errorCode=[Acris].[UCCLotDataDailyImport] @DateTimeStampStr;
			
				EXEC @errorCode=[Acris].[UCCRemarkDataDailyImport] @DateTimeStampStr;
			
				EXEC @errorCode=[Acris].[UCCCrossReferenceDataDailyImport] @DateTimeStampStr;
			
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION;
			THROW;
		END CATCH
	END
	ELSE
		THROW 50003,'Invalid TableMnemonic', 1

	RETURN @errorCode
END

/*
Test Harness to insure imports are working
1) Rename the original table with an org (or any other) suffix
2) Create a new "target table" using the definition of the original table. Rename Primary Key before saving the new target table definition.
3) Run the SSIS package only upto to the point where staging table/(s) are populated
4) Run the script below (it will only execute the insert portion of the code since target table is empty)
5) Check results to confirm records match staging table data, dbo.RowTransactionCommitted, dbo.ColumnTransactionCommitted, vwXXXXXNoDups Views, tfnxxxxDailyImport() and target table 
6) Now modify single or multiple rows in the staging table to test the remaining parts of the stored procedure
7) Run the script below again
8) Confirm the results in dbo.RowTransactionCommitted, dbo.ColumnTransactionCommitted, vwXXXXXNoDups Views, tfnxxxxDailyImport() and target table 
9) Once the tests are finished delete the new target table and rename the original table back to its original name  
*/
/*
DECLARE @errorCode AS INTEGER=0
--EXEC @errorCode=[dbo].[ProcessDailyImport] '2015-08-31 00:00:00', 'UCC'
--EXEC @errorCode=[Acris].[UCCMasterDataDailyImport] '2015-08-31 00:00:00';
--EXEC @errorCode=[Acris].[MortgageDeedMasterDataDailyImport] '2015-09-09 00:00:00';
--EXEC @errorCode=[Acris].[MortgageDeedCrossReferenceDataDailyImport] '2015-09-09 00:00:00';
--EXEC @errorCode=[Acris].[MortgageDeedLotDataDailyImport] '2015-09-09 00:00:00';
--EXEC @errorCode=[Acris].[MortgageDeedPartyDataDailyImport] '2015-09-09 00:00:00';
EXEC @errorCode=[Acris].[MortgageDeedRemarkDataDailyImport] '2015-09-09 00:00:00';
SELECT  @errorCode
*/
GO
