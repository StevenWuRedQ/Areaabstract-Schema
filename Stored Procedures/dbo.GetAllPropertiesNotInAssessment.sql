SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[GetAllPropertiesNotInAssessment]
AS
BEGIN
	--SET NOCOUNT ON added to prevent extra result sets from
	
	SET NOCOUNT ON;

	TRUNCATE TABLE [dbo].[PropertyNotInAssessment];

	IF (NYCDOF.dof.UseMergedAssementAndValuation()=1)
		INSERT INTO [dbo].[PropertyNotInAssessment]
		SELECT	a.*
		FROM	(SELECT	*, ROW_NUMBER() OVER (PARTITION BY BBL ORDER BY StreetNumber DESC, StreetName DESC) AS RowNumber
				 FROM	[Acris].[MortgageDeedLot]
				) a
		LEFT OUTER JOIN NYCDOF.dof.vwTaxValuationMergedTentative b ON a.BBL = b.BBLE
		WHERE	RowNumber = 1
				AND b.BBLE IS NULL; 
	ELSE
		INSERT INTO [dbo].[PropertyNotInAssessment]
		SELECT	a.*
		FROM	(SELECT	*, ROW_NUMBER() OVER (PARTITION BY BBL ORDER BY StreetNumber DESC, StreetName DESC) AS RowNumber
				 FROM	[Acris].[MortgageDeedLot]
				) a
		LEFT OUTER JOIN NYCDOF.dof.vwFinalTaxAssessmentAndValuation b ON a.BBL = b.BBLE
		WHERE	RowNumber = 1
				AND b.BBLE IS NULL; 
	
END;


GO
