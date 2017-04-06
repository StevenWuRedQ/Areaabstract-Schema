SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:					Raj Sethi

-- Creation date:			12/07/2016

-- Mofifications dates:		

-- Description:				This stored procedure call all other stored procedures that need to be run ona daily basis after data in imported

-- Input tables:			None
--						
-- Tables modified:			None

-- Arguments:				

-- Outputs:					ErrorCode

-- Where used:				In SSIS packages in AreaAbstractACRISImport

-- =============================================
CREATE PROCEDURE [dbo].[RunDailyAfterImport]
AS
BEGIN
	SET NOCOUNT ON;

	EXEC [dbo].[GetAllPropertiesNotInAssessment]
	EXEC [dbo].[GetLatestContractOfSaleOrMemorandumOfContract]
	EXEC [dbo].[GetLatestDeedDocumentForAllProperties]
	EXEC [dbo].[GetLatestDeedPartiesForAllProperties]
	EXEC [dbo].[GetLatestValidSaleDeedDocumentForAllProperties]
	EXEC [arm].[InsertArmsLengthSales]
	EXEC [arm].[InsertIntoSalesAreCompany]
END

GO
