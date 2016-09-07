SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Acris].[fnGetDocumentPartyNames](@DocUniqueKey VARCHAR(16), @PartyType AS VARCHAR(1))
RETURNS VARCHAR(MAX)
AS
BEGIN
DECLARE @PartyNames VARCHAR(MAX);

SELECT @PartyNames=COALESCE(@PartyNames,' -AND- ') + LTRIM(RTRIM(ap.Name)) FROM acris.ACRIS_PARTIES ap WHERE ap.unique_key=@DocUniqueKey AND ap.Party_type=@PartyType 

RETURN @PartyNames;
END;
GO
