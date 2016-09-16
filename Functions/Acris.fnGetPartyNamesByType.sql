SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [Acris].[fnGetPartyNamesByType](@UniqueKey VARCHAR(16), @PartyType VARCHAR(1))
RETURNS VARCHAR(MAX)
AS
BEGIN
	
	DECLARE @PartyName VARCHAR(MAX)='';

	SELECT @PartyName=@PartyName + IIF(@PartyName ='', '',' / ') + LTRIM(RTRIM(ap.Name)) FROM acris.MortgageDeedParty AS ap WHERE ap.UniqueKey=@UniqueKey AND ap.PartyType=@PartyType 
	
	RETURN @PartyName;
END;

--CHAR(10) + CHAR(13)
GO
