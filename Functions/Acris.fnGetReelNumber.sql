SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [Acris].[fnGetReelNumber](@Remark VARCHAR(MAX))
RETURNS VARCHAR(5)
AS
BEGIN
	--DECLARE @Remark VARCHAR(MAX)='DISC 11/19/02 R6655 P1545'
	DECLARE @ReelNumber VARCHAR(5)='';
	DECLARE @Length INTEGER = 6;
	DECLARE @Location INTEGER=0;
	DECLARE @Pattern VARCHAR(50)
	DECLARE @offset INTEGER = 1

	WHILE (@Length>1) AND (@Location=0)
	BEGIN
		SET @Length=@Length-1
		SELECT @Location=PATINDEX('%R'+REPLICATE('[0-9]',@Length)+'%',@Remark)
	END
	IF @Location=0
	BEGIN
		SET @Length=6
		WHILE (@Length>1) AND (@Location=0)
		BEGIN
			SET @Length=@Length-1
			SELECT @Location=PATINDEX('%L'+REPLICATE('[0-9]',@Length)+'%',@Remark)
		END
	END
	IF @Location=0
	BEGIN
		SET @offset = 2
		SET @Length=6
		WHILE (@Length>1) AND (@Location=0)
		BEGIN
			SET @Length=@Length-1
			SELECT @Location=PATINDEX('%R.'+REPLICATE('[0-9]',@Length)+'%',@Remark)
		END
	END
	IF @Location=0
	BEGIN
		SET @offset = 2
		SET @Length=6
		WHILE (@Length>1) AND (@Location=0)
		BEGIN
			SET @Length=@Length-1
			SELECT @Location=PATINDEX('%L.'+REPLICATE('[0-9]',@Length)+'%',@Remark)
		END
	END
	
	IF @Location>0
	BEGIN
		SET @ReelNumber=SUBSTRING(@Remark,@Location+@offset,@Length)
	END
	SET @ReelNumber = Utilities.util.fnLPadString(@ReelNumber,'0',5)

	RETURN @ReelNumber;
END;


 --SELECT [Acris].[fnGetReelNumber]('DISC 11/19/02 L6655 P1545')
GO
