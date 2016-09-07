SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Acris].[fnGetDocumentRemarks](@DocUniqueKey VARCHAR(16))
RETURNS VARCHAR(4096)
AS
BEGIN
DECLARE @remark VARCHAR(MAX);

SELECT @remark=COALESCE(@remark,'') + ar.[Text] FROM acris.ACRIS_Remarks ar WHERE ar.unique_key=@DocUniqueKey ORDER BY ar.SEQ

RETURN @remark;
END;
GO
