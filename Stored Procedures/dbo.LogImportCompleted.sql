SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:					Raj Sethi

-- Creation date:			08/31/2016

-- Mofifications dates:		

-- Description:				This stored procedure is used in SSIS packages in AreaAbstractACRISImport to mark a daily import for a table complete
 

-- Input tables:			[dbo].[DailyImportLog]
--						
-- Tables modified:			[dbo].[DailyImportLog]

-- Arguments:				@FullFileName	-	Full path of the import file name
--							@FileName		-	Unique file name (inside a zip folder) without file path				

-- Outputs:					Error Code

-- Where used:				In SSIS packages in AreaAbstractACRISImport
-- =============================================
CREATE PROCEDURE [dbo].[LogImportCompleted](@FullFileName AS VARCHAR(255), @FileName AS VARCHAR(255))
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @rowFound AS INTEGER
	DECLARE @Success AS BIT
	
	SELECT @rowFound=COUNT(*), @Success=SUM(Successful) FROM [dbo].[DailyImportLog] WHERE [FileName]=@FileName 	

	IF (@rowFound=0) 
	--  No file found hence canot end 
		RETURN 2
	
	IF (@rowFound=1) AND (@Success=0)	
		UPDATE  [dbo].[DailyImportLog]
		SET
			[DateTimeCompleted]=GETDATE(),
			[Successful]=1
		WHERE [FileName]=@FileName
	
	RETURN 0
END;

GO
