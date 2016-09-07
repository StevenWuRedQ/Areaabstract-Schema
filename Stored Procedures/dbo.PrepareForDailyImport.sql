SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:					Raj Sethi

-- Creation date:			08/31/2016

-- Mofifications dates:		

-- Description:				The procedure creates a log entry in [dbo].[DailyImportLog] indicating start of an import processess and then truncates the daily staging file
 

-- Input tables:			[dbo].[DailyImportLog]
--						
-- Tables modified:			[dbo].[DailyImportLog], various staging tables see the code below

-- Arguments:				@TableMnemonic	-	3 to 10 character mnemonic for the staging table 
--							@FullFileName	-	Full path of the import file name
--							@FileName		-	Unique file name (within a zip folder) without the path

-- Outputs:					ErrrorCode

-- Where used:				In SSIS packages in AreaAbstractACRISImport

-- =============================================
CREATE PROCEDURE [dbo].[PrepareForDailyImport](@FullFileName AS VARCHAR(255), @FileName AS VARCHAR(255), @TableMnemonic AS VARCHAR(10))
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @rowFound AS INTEGER
	DECLARE @Success AS BIT
	
	SELECT @rowFound=COUNT(*), @Success=SUM(Successful) FROM [dbo].[DailyImportLog] WHERE [FileName]=@FileName 	

	IF (@rowFound=1) AND (@Success=1)
	--  File already processed
		RETURN 1 
		
	SET @TableMnemonic=LTRIM(RTRIM(@TableMnemonic))

	BEGIN TRY
		IF (@rowFound=1)
		BEGIN
		-- Found but was not successful
			UPDATE  [dbo].[DailyImportLog]
			SET
				[DateTimeStarted]=GETDATE(),
				[DateTimeCompleted]=NULL,
				[Successful]=0
			WHERE [FileName]=@FileName
		END
		ELSE
		BEGIN
			INSERT INTO [dbo].[DailyImportLog]	VALUES (@FullFileName,@FileName,@TableMnemonic,GETDATE(),NULL,0)
		END	
			
		IF @TableMnemonic='MORTDEED'
		BEGIN
			TRUNCATE TABLE [stage].[MortgageDeedCrossReference]
			TRUNCATE TABLE [stage].[MortgageDeedLot]
			TRUNCATE TABLE [stage].[MortgageDeedParty]
			TRUNCATE TABLE [stage].[MortgageDeedMaster]
			TRUNCATE TABLE [stage].[MortgageDeedRemark]
		END
		ELSE
			RETURN 2
	END TRY
	BEGIN CATCH
		RETURN ERROR_NUMBER() 
	END CATCH
	RETURN 0
END

GO
