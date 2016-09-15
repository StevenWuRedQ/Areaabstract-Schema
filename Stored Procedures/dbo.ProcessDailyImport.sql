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
DECLARE @errorCode AS INTEGER=0
EXEC @errorCode=[dbo].[ProcessDailyImport] '2015-08-31 00:00:00', 'UCC'
--EXEC @errorCode=[Acris].[UCCMasterDataDailyImport] '2015-08-31 00:00:00';
SELECT  @errorCode
*/
GO
