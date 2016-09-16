SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Acris].[fnUCCGetDocumentPartyNames](@DocUniqueKey VARCHAR(16), @PartyType AS VARCHAR(1))
RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @PartyNames VARCHAR(MAX);

	SELECT @PartyNames=COALESCE(@PartyNames +' -- AND -- ','') + LTRIM(RTRIM(up.Name)) FROM acris.UCCParty AS up WHERE up.UniqueKey=@DocUniqueKey AND up.PartyType=@PartyType 

	RETURN @PartyNames;
END;
GO
