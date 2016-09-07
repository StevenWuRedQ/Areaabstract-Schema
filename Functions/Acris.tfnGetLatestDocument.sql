SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [Acris].[tfnGetLatestDocument](@BBLE VARCHAR(11), @DocumentType VARCHAR(8)=NULL)
RETURNS @LatestDoc TABLE
(
--Columns returned by the function
RowNo INT PRIMARY KEY,
BBLE VARCHAR(11) NOT NULL,
UniqueKey VARCHAR(16) NOT NULL,
PropertyType VARCHAR(2) NULL,
DocumentType VARCHAR(8) NOT NULL,
DocumentTypeDescription VARCHAR(30) NULL,
DocumentClassCodeDescription VARCHAR(27),
DocumentDate DATE NULL,
DocumentAmount NUMERIC(14,2) NULL,
PercentageOfTransaction NUMERIC(15,6) NULL,
DateRecorded DATE NULL,
DateModified DATE NULL,
BoroughOfRecord VARCHAR(1) NULL,
Remarks VARCHAR(MAX) NULL,
LastUpdatedDate DATETIME NULL,
URL VARCHAR(500)
)
BEGIN
INSERT INTO @LatestDoc
SELECT TOP 1 * FROM acris.tfnGetDocuments(@BBLE,@DocumentType)
RETURN;
END;
GO
