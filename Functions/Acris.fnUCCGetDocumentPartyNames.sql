SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Acris].[fnUCCGetDocumentPartyNames](@DocUniqueKey VARCHAR(16), @PartyType AS VARCHAR(1))
RETURNS VARCHAR(MAX)
AS
BEGIN
DECLARE @PartyNames VARCHAR(MAX);

SELECT @PartyNames=COALESCE(@PartyNames +' -- AND -- ','') + LTRIM(RTRIM(up.Name)) FROM ucc.Ucc_PARTIES up WHERE up.unique_key=@DocUniqueKey AND up.Party_type=@PartyType 

RETURN @PartyNames;
END;
GO
