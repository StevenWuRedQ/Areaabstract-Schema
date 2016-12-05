SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Acris].[tfnGetDocumentParties](@UniqueKey VARCHAR(16), @PartyType varchar(20)=null)
RETURNS @UniqueDocKeys TABLE 
(
    -- Columns returned by the function
	UniqueKey				VARCHAR(16) NOT NULL,
	PartyType				VARCHAR(20) NULL,
	Name					VARCHAR(70) NOT NULL,
	PartyTypeCode			VARCHAR(1) NOT NULL,
	Address1				VARCHAR(60) NULL,
	Address2				VARCHAR(60) NULL,
	City					VARCHAR(30) NULL,
	State					VARCHAR(2) NULL,
	Zip						VARCHAR(9) NULL,
    Country					VARCHAR(2) NULL
)
BEGIN
	IF (@PartyType IS NOT NULL)
		INSERT @UniqueDocKeys      
		SELECT	ap.UniqueKey
			   ,Acris.fnGetPartyTypeDescription(ap.PartyType, adoc.Party1Type, adoc.Party2Type, adoc.Party3Type) AS PartyType
			   ,ap.Name
			   ,ap.PartyType AS PartyTypeCode
			   ,ap.Address1
			   ,ap.Address2
			   ,ap.City
			   ,ap.State
			   ,ap.Zip
			   ,ap.Country
		FROM	Acris.MortgageDeedMaster AS am
		INNER JOIN Acris.MortgageDeedParty AS ap ON am.UniqueKey = ap.UniqueKey
		INNER JOIN Acris.DocumentControlCodes adoc ON am.DocumentTypeCode = adoc.DocumentType   
		WHERE am.UniqueKey=@UniqueKey
			  AND Acris.fnGetPartyTypeDescription(ap.PartyType, adoc.Party1Type, adoc.Party2Type, adoc.Party3Type) LIKE '%'+@PartyType+'%'
	ELSE
		INSERT @UniqueDocKeys   
		SELECT	ap.UniqueKey
			   ,Acris.fnGetPartyTypeDescription(ap.PartyType, adoc.Party1Type, adoc.Party2Type, adoc.Party3Type) AS PartyType
			   ,ap.Name
			   ,ap.PartyType AS PartyTypeCode
			   ,ap.Address1
			   ,ap.Address2
			   ,ap.City
			   ,ap.State
			   ,ap.Zip
			   ,ap.Country
		FROM	Acris.MortgageDeedMaster AS am
		INNER JOIN Acris.MortgageDeedParty AS ap ON am.UniqueKey = ap.UniqueKey
		INNER JOIN Acris.DocumentControlCodes adoc ON am.DocumentTypeCode = adoc.DocumentType  
		WHERE am.UniqueKey=@UniqueKey
    RETURN;
END;
GO
