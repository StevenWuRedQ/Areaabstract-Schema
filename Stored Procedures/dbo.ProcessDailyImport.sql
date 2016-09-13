SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:					Raj Sethi

-- Creation date:			08/31/2016

-- Mofifications dates:		09/09/2016

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
		BEGIN TRANSACTION
		EXEC @errorCode=[Acris].[MortgageDeedMasterDataDailyImport] @DateTimeStampStr, @errorMessage OUTPUT
		IF @errorCode!=0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN @errorCode 
		END

		EXEC @errorCode=[Acris].[MortgageDeedPartyDataDailyImport] @DateTimeStampStr, @errorMessage OUTPUT
		IF @errorCode!=0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN @errorCode 
		END

		EXEC @errorCode=[Acris].[MortgageDeedLotDataDailyImport] @DateTimeStampStr, @errorMessage OUTPUT
		IF @errorCode!=0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN @errorCode 
		END

		EXEC @errorCode=[Acris].[MortgageDeedRemarkDataDailyImport] @DateTimeStampStr, @errorMessage OUTPUT
		IF @errorCode!=0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN @errorCode 
		END
		EXEC @errorCode=[Acris].[MortgageDeedCrossReferenceDataDailyImport] @DateTimeStampStr, @errorMessage OUTPUT
		IF @errorCode!=0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN @errorCode 
		END
		COMMIT TRANSACTION
	END
	ELSE IF @tableMnemonic='UCC'
	BEGIN
		BEGIN TRANSACTION
/*		EXEC @errorCode=[Acris].[UCCMasterDataDailyImport] @DateTimeStampStr, @errorMessage OUTPUT
		IF @errorCode!=0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN @errorCode 
		END

		EXEC @errorCode=[Acris].[UCCPartyDataDailyImport] @DateTimeStampStr, @errorMessage OUTPUT
		IF @errorCode!=0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN @errorCode 
		END

		EXEC @errorCode=[Acris].[UCCLotDataDailyImport] @DateTimeStampStr, @errorMessage OUTPUT
		IF @errorCode!=0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN @errorCode 
		END

		EXEC @errorCode=[Acris].[UCCRemarkDataDailyImport] @DateTimeStampStr, @errorMessage OUTPUT
		IF @errorCode!=0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN @errorCode 
		END
		EXEC @errorCode=[Acris].[UCCCrossReferenceDataDailyImport] @DateTimeStampStr, @errorMessage OUTPUT
		IF @errorCode!=0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN @errorCode 
		END
		*/
		COMMIT TRANSACTION
	END
	ELSE
		RETURN 3

	RETURN @errorCode
END

GO
