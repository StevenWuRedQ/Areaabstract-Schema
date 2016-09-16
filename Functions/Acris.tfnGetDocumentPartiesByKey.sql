SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Acris].[tfnGetDocumentPartiesByKey](@Key VARCHAR(16), @PartyType varchar(20)=null)
RETURNS @UniqueDocKeys TABLE 
(
    -- Columns returned by the function
	RowNo					INT PRIMARY KEY,
	UniqueKey				VARCHAR(16) NOT NULL,
	DocumentDate			DATE NULL,
	DocumentType			VARCHAR(8) NOT NULL,
	DocumentTypeDescription	VARCHAR(30) NULL,
	DocumentAmount			NUMERIC(14,2) NULL,
	DateRecorded			DATE NULL,
	DateModified			DATE NULL,
	PartyType				VARCHAR(20) NULL,
	Name					VARCHAR(70) NOT NULL,
	PartyTypeCode			VARCHAR(1) NOT NULL
    
)
BEGIN
	IF (@PartyType IS NOT NULL)
		INSERT @UniqueDocKeys      
		SELECT * FROM (SELECT ROW_NUMBER() over (ORDER BY DocumentDate DESC, UniqueKey DESC) RowNo, UniqueKey, DocumentDate, DocumentType, DocumentTypeDescription,
					   DocumentAmount, DateRecorded, DateModified, PartyType, Name, PartyTypeCode
					   FROM acris.vwDocumentPartiesByUniqueKey dpb
					   WHERE dpb.UniqueKey= @Key) tempresults
					   WHERE tempresults.PartyType like '%'+@PartyType+'%'
	ELSE
		INSERT @UniqueDocKeys 
		SELECT ROW_NUMBER() over (ORDER BY DocumentDate DESC, UniqueKey DESC) RowNo, UniqueKey, DocumentDate, DocumentType, DocumentTypeDescription,
		DocumentAmount, DateRecorded, DateModified, PartyType, Name,  PartyTypeCode
		FROM acris.vwDocumentPartiesByUNiqueKey dpb
		WHERE dpb.UniqueKey = @Key
    RETURN;
END;
GO
