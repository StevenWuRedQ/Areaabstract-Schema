SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [Acris].[fnGetPartyNamesByType](@UniqueKey VARCHAR(16), @PartyType VARCHAR(1))
RETURNS VARCHAR(MAX)
AS
BEGIN
	
	DECLARE @PartyName VARCHAR(MAX)='';

	SELECT @PartyName=@PartyName + IIF(@PartyName ='', '',' / ') + LTRIM(RTRIM(ap.Name)) FROM acris.ACRIS_Parties ap WHERE ap.Unique_key=@UniqueKey AND ap.Party_type=@PartyType 
	
	RETURN @PartyName;
END;

--CHAR(10) + CHAR(13)
GO
