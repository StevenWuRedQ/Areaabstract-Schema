SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:					Raj Sethi

-- Creation date:			09/06/2016

-- Mofifications dates:		

-- Description:				This stored procedure inserts and updates new records in acris.MortgageDeedLot table based on acris.tfnMortgageDeedLotDataDaily
--							function. It also inserts audit records for all data inserted and updated.
 

-- Input tables:			acris.MortgageDeedLot
--							acris.tfnMortgageDeedLotDataDaily
--							

-- Tables modified:			acris.MortgageDeedLot

-- Arguments:				@DateTimeStampStr - DateTimeStamp of when the actual daily import file was created

-- Outputs:					dbo.RowTransactionsCommitted

-- Where used:				In [acris].[MortgageDeedDataDailyImport] stored procedure

-- =============================================
CREATE PROCEDURE [Acris].[MortgageDeedLotDataDailyImport](@DateTimeStampStr AS VARCHAR(20), @ErrorMessage AS VARCHAR(MAX) OUTPUT)
AS
BEGIN
	
	DECLARE @Mode AS VARCHAR(5)='PROD'
	
	SET NOCOUNT ON;
	DECLARE @DateTimeStamp AS DATETIME
	DECLARE @tableName AS VARCHAR(150) = 'acris.MortgageDeedLot'
	DECLARE @IdentifyingColumnName AS VARCHAR(255) = 'BBL + UniqueKey + Easement'
	
	
	BEGIN TRY
		SET @DateTimeStamp = CONVERT(DATETIME, @DateTimeStampStr,120)
	END TRY
	BEGIN CATCH
		RETURN 3
	END CATCH

	BEGIN TRY
		BEGIN TRANSACTION
			
			---------------------------------------------------------------------------
			-- INSERT RECORDS
			---------------------------------------------------------------------------
			
			-- Insert audit records for new rows to be inserted
			INSERT INTO dbo.RowTransactionCommitted
			--DECLARE @DateTimeStamp AS DATETIME = CONVERT(DATETIME,'2016-04-18 00:00:00',120)
			--DECLARE @tableName AS VARCHAR(150) = 'acris.MortgageDeedLot'
			--DECLARE @IdentifyingColumnName AS VARCHAR(255) = 'BBL + UniqueKey + Easement'
			SELECT	@tableName
					,@IdentifyingColumnName
					,a.BBL + ',' + a.UniqueKey + ',' + a.Easement 
					, 1, 0, 0
					,@DateTimeStamp
					,GETDATE() 
			FROM  [stage].[tfnMortgageDeedLotDataDaily]('A') a
		

			if @Mode<>'DEBUG'
			--Actually Insert Records
				INSERT INTO acris.MortgageDeedLot
				SELECT a.* FROM [stage].[tfnMortgageDeedLotDataDaily]('A') a
				

			---------------------------------------------------------------------------
			-- UPDATE RECORDS
			---------------------------------------------------------------------------

			-- Insert audit records for rows updated
			INSERT INTO dbo.RowTransactionCommitted
			--DECLARE @DateTimeStamp AS DATETIME = CONVERT(DATETIME,'2016-04-18 00:00:00',120)
			--DECLARE @tableName AS VARCHAR(150) = 'acris.MortgageDeedLot'
			--DECLARE @IdentifyingColumnName AS VARCHAR(255) ='BBL + UniqueKey + Easement'
			SELECT @tableName, @IdentifyingColumnName
			       ,a.BBL + ',' + a.UniqueKey + ',' + a.Easement
				   ,0, 0, 1, @DateTimeStamp, GETDATE() 
			FROM[stage].[tfnMortgageDeedLotDataDaily]('U') a
				

			--FOR DEBUGGING DO NOT DELETE
			--DECLARE @DateTimeStamp AS DATETIME = CONVERT(DATETIME,'2016-04-18 00:00:00',120)
			--DECLARE @tableName AS VARCHAR(150) = 'acris.MortgageDeedLot'
			--DECLARE @IdentifyingColumnName AS VARCHAR(255) = 'BBL + UniqueKey + Easement'

			-- Insert Columns changed in each row with old and new value
			DECLARE @outStr AS NVARCHAR(MAX)=N''
			DECLARE @cmdStr AS NVARCHAR(MAX)=N''
			

			+ N', R1.BBL +'',''+ R1.UniqueKey +'',''+R1.Easment AS IdentifyingValue'

			-- Create the Audit statement
			EXEC Utilities.util.[CreateValuesFragementForAudit] 'AreaAbstract', 'MortgageDeedLot', 'UniqueKey, DateLastUpdated', @outStr OUTPUT, @cmdStr OUTPUT, 'acris'
			
			SET @outStr = N' INSERT INTO dbo.ColumnTransactionCommitted' +
						  N' SELECT '+Utilities.util.fninQuotes(@tableName)+N' AS TableName'
						+ N','+ Utilities.util.fninQuotes(@IdentifyingColumnName)+N' AS IdentifyingColumnName'
						+ N', R1.BBL +'',''+ R1.UniqueKey +'',''+R1.Easment AS IdentifyingValue'
						+ N',C.COL AS [ColumnName]'
						+ N',C.VAL1 AS NewValue'
						+ N',C.VAL2 AS OldValue'
						+ N',@inDateTimeStamp AS TransactionDateTime'
						+ N',GETDATE() AS DateTimeProcessed' 
						+ N' FROM  stage.tfnMortgageDeedLotDataDaily(''U'') R1'
						+ N' INNER JOIN acris.MortgageDeedLot R2 ON R1.BBL=R2.BBL AND R1.UniqueKey=R2.UniqueKey AND R1.Easement=R2.Easement'
						+ N' CROSS APPLY	( '
						+ @outStr + N') '
						+ N' C (COL, VAL1, VAL2)'
						+ N' WHERE (C.Val1<>C.Val2) OR (C.Val1 IS NOT NULL AND C.Val2 IS NULL) OR (C.Val1 IS NULL AND C.Val2 IS NOT NULL)'
						+ N' ORDER BY R1.UniqueKey'
			
			--FOR DEBUGGING DO NOT DELETE
			--SELECT  @outStr OUTPUT, @cmdStr OUTPUT

			--Execute the Insert statement for update audit records
			EXEC sp_executesql @outStr, N'@inDateTimeStamp DATETIME', @inDateTimeStamp = @DateTimeStamp
			
			--FOR DEBUGGING DO NOT DELETE
			--DECLARE @DateTimeStamp AS DATETIME = CONVERT(DATETIME,'2016-04-18 00:00:00',120)
			--DECLARE @tableName AS VARCHAR(150) = 'acris.MortgageDeedLot'
			--DECLARE @IdentifyingColumnName AS VARCHAR(255) = 'BBL + UniqueKey + Easement'
			--DECLARE @outStr AS NVARCHAR(MAX)=N''
			--DECLARE @cmdStr AS NVARCHAR(MAX)=N''
			
			-- Create the Update statement
			SET @outStr=''
			SET @cmdStr=''
			EXEC Utilities.util.[CreateSetFragementForUpdate] 'AreaAbstract', 'MortgageDeedLot', 'BBL + UniqueKey + Easement', @outStr OUTPUT, @cmdStr OUTPUT, 'acris'

			SET @outStr = N' UPDATE a '
						+ @outStr +
						+ N' FROM acris.MortgageDeedLot a, stage.tfnMortgageDeedLotDataDaily(''U'') b'
						+ N' WHERE a.BBL=b.BBL AND a.UniqueKey=b.UniqueKey AND a.Easement=b.Easement'
						
			--FOR DEBUGGING DO NOT DELETE
			--SELECT  @outStr OUTPUT, @cmdStr OUTPUT

			IF @Mode<>'DEBUG' 
			BEGIN
				EXEC sp_executesql @outStr
			END
		COMMIT TRANSACTION
		RETURN 0
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		SET @ErrorMessage=ERROR_MESSAGE()
		RETURN ERROR_NUMBER() 
	END CATCH
END;

GO
