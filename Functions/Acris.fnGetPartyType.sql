SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [Acris].[fnGetPartyType](@UniqueKey VARCHAR(16), @PartyTypeCode VARCHAR(1))
RETURNS VARCHAR(MAX)
AS
BEGIN
	
	DECLARE @PartyType VARCHAR(MAX)='';

	SELECT	@PartyType = Acris.fnGetPartyTypeDescription(@PartyTypeCode, adoc.Party1Type, adoc.Party2Type, adoc.Party3Type)
	FROM	Acris.MortgageDeedMaster AS am
	INNER JOIN Acris.DocumentControlCodes AS adoc ON am.DocumentTypeCode = adoc.DocumentType
	WHERE	am.UniqueKey = @UniqueKey;
	
	RETURN @PartyType;
END;
GO
