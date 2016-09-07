SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [Acris].[fnGetPartyType](@UniqueKey VARCHAR(16), @PartyTypeCode VARCHAR(1))
RETURNS VARCHAR(MAX)
AS
BEGIN
	
	DECLARE @PartyType VARCHAR(MAX)='';

	SELECT @PartyType=acris.fnGetPartyTypeDescription(@PartyTypeCode, adoc.[PARTY1 TYPE], adoc.[PARTY2 TYPE], adoc.[PARTY3 TYPE])
	FROM	acris.ACRIS_Master am	            
	INNER JOIN	acris.MD_Document_Control_Codes adoc ON am.Doc_Type=adoc.[DOC  TYPE]    
	WHERE am.Unique_Key=@UniqueKey
	
	RETURN @PartyType;
END;
GO
