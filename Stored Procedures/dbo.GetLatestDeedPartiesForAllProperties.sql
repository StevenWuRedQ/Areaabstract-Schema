SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[GetLatestDeedPartiesForAllProperties]
AS
BEGIN
--SET NOCOUNT ON added to prevent extra result sets from
--interfering with SELECT statements.
	SET NOCOUNT ON;

	TRUNCATE TABLE [dbo].[LatestDeedParty];
	
	INSERT INTO [dbo].[LatestDeedParty]
	SELECT * FROM [Acris].[vwLatestDeedParties]

END



GO
