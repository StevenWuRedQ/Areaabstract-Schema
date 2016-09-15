SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:					Raj Sethi

-- Creation date:			09/13/2016

-- Mofifications dates:		09/14/2016

-- Description:				This stored procedure inserts and updates new records in acris.UCCCrossReference table based on acris.tfnUCCCrossReferenceDataDaily
--							function. It also inserts audit records for all data inserted and updated.
 

-- Input tables:			acris.UCCCrossReference
--							acris.tfnUCCCrossReferenceDataDaily
--							

-- Tables modified:			acris.UCCCrossReference

-- Arguments:				@DateTimeStampStr - DateTimeStamp of when the actual daily import file was created

-- Outputs:					dbo.RowTransactionsCommitted

-- Where used:				In [acris].[UCCDataDailyImport] stored procedure

-- =============================================
CREATE PROCEDURE [Acris].[UCCCrossReferenceDataDailyImport](@DateTimeStampStr AS VARCHAR(20))
AS
BEGIN
	
	DECLARE @Mode AS VARCHAR(5)='PROD'
	
	SET NOCOUNT ON;
	DECLARE @DateTimeStamp AS DATETIME
	DECLARE @tableName AS VARCHAR(150) = 'acris.UCCCrossReference'
	DECLARE @IdentifyingColumnName AS VARCHAR(255) = 'UniqueKey'
	
	
	BEGIN TRY
		SET @DateTimeStamp = CONVERT(DATETIME, @DateTimeStampStr,120)
	END TRY
	BEGIN CATCH
		THROW 50004,'Invalid Datetime stamp value',1;
	END CATCH

	DECLARE @InTransaction AS BIT=0
	IF (@@TranCount>0)
		SET @InTransaction=1

	BEGIN TRY
		IF (@InTransaction=1)
			SAVE TRANSACTION LTUCCCrossRefDataDailyImport --abbreviated for length restrictions
		ELSE
			BEGIN TRANSACTION
			
			---------------------------------------------------------------------------
			-- UPDATE RECORDS
			---------------------------------------------------------------------------

			-- Insert audit records for rows updated
			INSERT INTO dbo.RowTransactionCommitted
			--DECLARE @DateTimeStamp AS DATETIME = CONVERT(DATETIME,'2016-04-18 00:00:00',120)
			--DECLARE @tableName AS VARCHAR(150) = 'acris.UCCCrossReference'
			--DECLARE @IdentifyingColumnName AS VARCHAR(255) = 'UniqueKey'
			SELECT @tableName, @IdentifyingColumnName
			       ,a.UniqueKey
				   ,0, 0, 1, @DateTimeStamp, GETDATE() 
			FROM[stage].[tfnUCCCrossReferenceDataDaily]('U') a
				

			--FOR DEBUGGING DO NOT DELETE
			--DECLARE @DateTimeStamp AS DATETIME = CONVERT(DATETIME,'2016-04-18 00:00:00',120)
			--DECLARE @tableName AS VARCHAR(150) = 'acris.UCCCrossReference'
			--DECLARE @IdentifyingColumnName AS VARCHAR(255) = 'UniqueKey'

			-- Insert Columns changed in each row with old and new value
			DECLARE @outStr AS NVARCHAR(MAX)=N''
			DECLARE @cmdStr AS NVARCHAR(MAX)=N''
			
			-- Create the Audit statement
			EXEC Utilities.util.[CreateValuesFragementForAudit] 'AreaAbstractNew', 'UCCCrossReference', 'UniqueKey, DateLastUpdated', @outStr OUTPUT, @cmdStr OUTPUT, 'acris'
			
			SET @outStr = N' INSERT INTO dbo.ColumnTransactionCommitted' +
						  N' SELECT '+Utilities.util.fninQuotes(@tableName)+N' AS TableName'
						+ N','+ Utilities.util.fninQuotes(@IdentifyingColumnName)+N' AS IdentifyingColumnName'
						+ N', R1.UniqueKey AS IdentifyingValue'
						+ N',C.COL AS [ColumnName]'
						+ N',C.VAL1 AS NewValue'
						+ N',C.VAL2 AS OldValue'
						+ N',@inDateTimeStamp AS TransactionDateTime'
						+ N',GETDATE() AS DateTimeProcessed' 
						+ N' FROM  stage.tfnUCCCrossReferenceDataDaily(''U'') R1'
						+ N' INNER JOIN acris.UCCCrossReference R2 ON R1.UniqueKey=R2.UniqueKey'
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
			--DECLARE @tableName AS VARCHAR(150) = 'acris.UCCCrossReference'
			--DECLARE @IdentifyingColumnName AS VARCHAR(255) = 'UniqueKey'
			--DECLARE @outStr AS NVARCHAR(MAX)=N''
			--DECLARE @cmdStr AS NVARCHAR(MAX)=N''
			
			-- Create the Update statement
			SET @outStr=''
			SET @cmdStr=''
			EXEC Utilities.util.[CreateSetFragementForUpdate] 'AreaAbstractNew', 'UCCCrossReference', 'UniqueKey', @outStr OUTPUT, @cmdStr OUTPUT, 'acris'

			SET @outStr = N' UPDATE a '
						+ @outStr +
						+ N' FROM acris.UCCCrossReference a, stage.tfnUCCCrossReferenceDataDaily(''U'') b'
						+ N' WHERE a.UniqueKey=b.UniqueKey'
						
			--FOR DEBUGGING DO NOT DELETE
			--SELECT  @outStr OUTPUT, @cmdStr OUTPUT

			IF @Mode<>'DEBUG' 
			BEGIN
				--Execute the Update statement to update actual DocumentExtract records
				EXEC sp_executesql @outStr
			END

			---------------------------------------------------------------------------
			-- INSERT RECORDS
			---------------------------------------------------------------------------
			
			-- Insert audit records for new rows to be inserted
			INSERT INTO dbo.RowTransactionCommitted
			--DECLARE @DateTimeStamp AS DATETIME = CONVERT(DATETIME,'2016-04-18 00:00:00',120)
			--DECLARE @tableName AS VARCHAR(150) = 'acris.UCCCrossReference'
			--DECLARE @IdentifyingColumnName AS VARCHAR(255) = 'UniqueKey'
			SELECT	@tableName
					,@IdentifyingColumnName
					,a.UniqueKey
					, 1, 0, 0
					,@DateTimeStamp
					,GETDATE() 
			FROM  [stage].[tfnUCCCrossReferenceDataDaily]('A') a
		

			if @Mode<>'DEBUG'
			--Actually Insert Records
				INSERT INTO acris.UCCCrossReference
				SELECT a.* FROM [stage].[tfnUCCCrossReferenceDataDaily]('A') a


		IF (@InTransaction=0)
			COMMIT TRANSACTION
		RETURN 0
	END TRY
	BEGIN CATCH
		IF (@InTransaction=0)
			ROLLBACK TRANSACTION;
		ELSE
			ROLLBACK TRANSACTION LTUCCCrossRefDataDailyImport;
		THROW;
	END CATCH
END;

GO
