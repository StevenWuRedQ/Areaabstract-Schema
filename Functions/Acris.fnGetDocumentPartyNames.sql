SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Acris].[fnGetDocumentPartyNames](@DocUniqueKey VARCHAR(16), @PartyType AS VARCHAR(1))
RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @PartyNames VARCHAR(MAX);

	SELECT @PartyNames=COALESCE(@PartyNames,' -AND- ') + LTRIM(RTRIM(ap.Name)) FROM acris.MortgageDeedParty ap WHERE ap.UniqueKey=@DocUniqueKey AND ap.PartyType=@PartyType 

	RETURN @PartyNames;
END;
GO
