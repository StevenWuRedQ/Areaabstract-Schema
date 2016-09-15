SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:					Raj Sethi

-- Creation date:			09/08/2016

-- Mofifications dates:		09/14/2016

-- Description:				This stored procedure inserts and updates new records in acris.MortgageDeedRemark table based on acris.tfnMortgageDeedRemarkDataDaily
--							function. It also inserts audit records for all data inserted and updated.
 

-- Input tables:			acris.MortgageDeedRemark
--							acris.tfnMortgageDeedRemarkDataDaily
--							

-- Tables modified:			acris.MortgageDeedRemark

-- Arguments:				@DateTimeStampStr - DateTimeStamp of when the actual daily import file was created

-- Outputs:					dbo.RowTransactionsCommitted

-- Where used:				In [acris].[MortgageDeedDataDailyImport] stored procedure

-- =============================================
CREATE PROCEDURE [Acris].[MortgageDeedRemarkDataDailyImport](@DateTimeStampStr AS VARCHAR(20))
AS
BEGIN
	
	DECLARE @Mode AS VARCHAR(5)='PROD'
	
	SET NOCOUNT ON;
	DECLARE @DateTimeStamp AS DATETIME
	DECLARE @tableName AS VARCHAR(150) = 'acris.MortgageDeedRemark'
	DECLARE @IdentifyingColumnName AS VARCHAR(255) = 'UniqueKey + Sequence'
	
	
	BEGIN TRY
		SET @DateTimeStamp = CONVERT(DATETIME, @DateTimeStampStr,120)
	END TRY
	BEGIN CATCH
		RETURN 3
	END CATCH

	DECLARE @InTransaction AS BIT=0
	IF (@@TranCount>0)
		SET @InTransaction=1

	BEGIN TRY
		IF (@InTransaction=1)
			SAVE TRANSACTION LTMDRemarkDataDailyImport
		ELSE
			BEGIN TRANSACTION
			
			---------------------------------------------------------------------------
			-- UPDATE RECORDS
			---------------------------------------------------------------------------

			-- Insert audit records for rows updated
			INSERT INTO dbo.RowTransactionCommitted
			--DECLARE @DateTimeStamp AS DATETIME = CONVERT(DATETIME,'2016-04-18 00:00:00',120)
			--DECLARE @tableName AS VARCHAR(150) = 'acris.MortgageDeedRemark'
			--DECLARE @IdentifyingColumnName AS VARCHAR(255) = 'UniqueKey + Sequence'
			SELECT @tableName, @IdentifyingColumnName
			       ,a.UniqueKey + ',' +a.[Sequence]
				   ,0, 0, 1, @DateTimeStamp, GETDATE() 
			FROM[stage].[tfnMortgageDeedRemarkDataDaily]('U') a
				

			--FOR DEBUGGING DO NOT DELETE
			--DECLARE @DateTimeStamp AS DATETIME = CONVERT(DATETIME,'2016-04-18 00:00:00',120)
			--DECLARE @tableName AS VARCHAR(150) = 'acris.MortgageDeedRemark'
			--DECLARE @IdentifyingColumnName AS VARCHAR(255) = 'UniqueKey + Sequence'

			-- Insert Columns changed in each row with old and new value
			DECLARE @outStr AS NVARCHAR(MAX)=N''
			DECLARE @cmdStr AS NVARCHAR(MAX)=N''
			
			-- Create the Audit statement
			EXEC Utilities.util.[CreateValuesFragementForAudit] 'AreaAbstractNew', 'MortgageDeedRemark', 'UniqueKey, Sequence, DateLastUpdated', @outStr OUTPUT, @cmdStr OUTPUT, 'acris'
			
			SET @outStr = N' INSERT INTO dbo.ColumnTransactionCommitted' +
						  N' SELECT '+Utilities.util.fninQuotes(@tableName)+N' AS TableName'
						+ N','+ Utilities.util.fninQuotes(@IdentifyingColumnName)+N' AS IdentifyingColumnName'
						+ N', R1.UniqueKey +'',''+R1.Sequence AS IdentifyingValue'
						+ N',C.COL AS [ColumnName]'
						+ N',C.VAL1 AS NewValue'
						+ N',C.VAL2 AS OldValue'
						+ N',@inDateTimeStamp AS TransactionDateTime'
						+ N',GETDATE() AS DateTimeProcessed' 
						+ N' FROM  stage.tfnMortgageDeedRemarkDataDaily(''U'') R1'
						+ N' INNER JOIN acris.MortgageDeedRemark R2 ON R1.UniqueKey=R2.UniqueKey AND R1.Sequence=R2.Sequence'
						+ N' CROSS APPLY	( '
						+ @outStr + N') '
						+ N' C (COL, VAL1, VAL2)'
						+ N' WHERE (C.Val1<>C.Val2) OR (C.Val1 IS NOT NULL AND C.Val2 IS NULL) OR (C.Val1 IS NULL AND C.Val2 IS NOT NULL)'
						+ N' ORDER BY R1.UniqueKey, R1.Sequence'
			
			--FOR DEBUGGING DO NOT DELETE
			--SELECT  @outStr OUTPUT, @cmdStr OUTPUT

			--Execute the Insert statement for update audit records
			EXEC sp_executesql @outStr, N'@inDateTimeStamp DATETIME', @inDateTimeStamp = @DateTimeStamp
			
			--FOR DEBUGGING DO NOT DELETE
			--DECLARE @DateTimeStamp AS DATETIME = CONVERT(DATETIME,'2016-04-18 00:00:00',120)
			--DECLARE @tableName AS VARCHAR(150) = 'acris.MortgageDeedRemark'
			--DECLARE @IdentifyingColumnName AS VARCHAR(255) = 'UniqueKey + Sequence'
			--DECLARE @outStr AS NVARCHAR(MAX)=N''
			--DECLARE @cmdStr AS NVARCHAR(MAX)=N''
			
			-- Create the Update statement
			SET @outStr=''
			SET @cmdStr=''
			EXEC Utilities.util.[CreateSetFragementForUpdate] 'AreaAbstractNew', 'MortgageDeedRemark', 'UniqueKey, Sequence', @outStr OUTPUT, @cmdStr OUTPUT, 'acris'

			SET @outStr = N' UPDATE a '
						+ @outStr +
						+ N' FROM acris.MortgageDeedRemark a, stage.tfnMortgageDeedRemarkDataDaily(''U'') b'
						+ N' WHERE a.UniqueKey=b.UniqueKey and a.Sequence=b.Sequence'
						
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
			--DECLARE @tableName AS VARCHAR(150) = 'acris.MortgageDeedRemark'
			--DECLARE @IdentifyingColumnName AS VARCHAR(255) = 'UniqueKey + Sequence'
			SELECT	@tableName
					,@IdentifyingColumnName
					,a.UniqueKey + ',' +a.[Sequence]
					, 1, 0, 0
					,@DateTimeStamp
					,GETDATE() 
			FROM  [stage].[tfnMortgageDeedRemarkDataDaily]('A') a
		

			if @Mode<>'DEBUG'
			--Actually Insert Records
				INSERT INTO acris.MortgageDeedRemark
				SELECT a.* FROM [stage].[tfnMortgageDeedRemarkDataDaily]('A') a
		IF (@InTransaction=0)		
			COMMIT TRANSACTION
		RETURN 0
	END TRY
	BEGIN CATCH
		IF (@InTransaction=0)
			ROLLBACK TRANSACTION;
		ELSE
			ROLLBACK TRANSACTION LTMDRemarkDataDailyImport;
		THROW;
	END CATCH
END;

GO
