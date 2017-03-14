SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE FUNCTION [app].[tfnGetReelNumberAndPage](@Remark VARCHAR(MAX))
RETURNS @CrossReferenceReelInfo TABLE 
(
    -- Columns returned by the function
	[Counter]   INTEGER,
	ReelNumber	VARCHAR(5),
	ReelPage	VARCHAR(5)
)
BEGIN

    --DECLARE @Remark VARCHAR(MAX)='SATISFACTION/MTGE   DISCHGS L5312 P368  L5811/1 L6057/53 L5920/20 L6105/283  R117 P586 R253/676'
	DECLARE @ReelNumber VARCHAR(5)='';
	DECLARE @ReelPage VARCHAR(5)='';
	DECLARE @Length INTEGER = 6;
	DECLARE @MinLength INTEGER = 6;
	DECLARE @Location INTEGER=0;
	DECLARE @MinLocation INTEGER= NULL;
	DECLARE @Pattern VARCHAR(50)
	DECLARE @offset INTEGER = 1
	DECLARE @Found BIT =1 
	DECLARE @Loop INTEGER=1
	DECLARE @Prefix VARCHAR(5)
	DECLARE @Counter INTEGER = 0

	WHILE (@Found=1)
	BEGIN
		SET @ReelNumber =''
		SET @ReelPage=''
		SET @Loop = 1
		SET @MinLocation = NULL
		WHILE (@Loop<=4)
		BEGIN
			SET @Location = 0	
			SET @Prefix = CASE (@Loop)
							WHEN 1 THEN '%R'
							WHEN 2 THEN '%R.'
							WHEN 3 THEN '%L'
							WHEN 4 THEN '%L.'
						  END
			
			SET @Length = 6
			WHILE (@Length>1)
			BEGIN
				SET @Length=@Length-1
				SELECT @Location=PATINDEX(@Prefix+REPLICATE('[0-9]',@Length)+'%',@Remark)
				IF (@Location<>0 AND (@MinLocation IS NULL OR @Location<@MinLocation))
				BEGIN
					SET @MinLocation=@Location
					SET @MinLength=@Length
					SET @offset = LEN(@Prefix) - 1			   
				END
			END
			SET @Loop = @Loop + 1
		END 
		IF (@minLocation IS NOT NULL)
			SET @Location=@MinLocation			

		IF @Location>0
		BEGIN
			SET @ReelNumber=SUBSTRING(@Remark,@Location+@offset,@MinLength)
			SET @ReelNumber = Utilities.util.fnLPadString(@ReelNumber,'0',5)
			
			SET @Remark = SUBSTRING(@Remark,@Location+@offset+@MinLength,LEN(@Remark)-(@offset+@MinLength+@Location-1))
												
			-- Find Reel Page now
			SET @Loop = 1
			SET @MinLocation = NULL
			WHILE (@Loop<=5)
			BEGIN
				SET @Prefix = CASE (@Loop)
								WHEN 1 THEN '%P'
								WHEN 2 THEN '%P.'
								WHEN 3 THEN '%PG.'
								WHEN 4 THEN '%PG'
								WHEN 5 THEN '%/'
							  END
				SET @Length = 6

				WHILE (@Length>1)
				BEGIN
					SET @Length=@Length-1
					SELECT @Location=PATINDEX(@Prefix+REPLICATE('[0-9]',@Length)+'%',@Remark)
					IF (@Location<>0 AND (@MinLocation IS NULL OR @Location<@MinLocation))
					BEGIN
						SET @MinLocation=@Location
						SET @MinLength=@Length
						SET @offset = LEN(@Prefix) - 1			   
					END
				END
				SET @Loop = @Loop + 1
			END 
			IF (@minLocation IS NOT NULL)
				SET @Location=@MinLocation			
		
			IF @Location>0
			BEGIN
				SET @ReelPage=SUBSTRING(@Remark,@Location+@offset,@MinLength)
				SET @ReelPage = Utilities.util.fnLPadString(@ReelPage,'0',5)
			
				SET @Remark = SUBSTRING(@Remark,@Location+@offset+@MinLength,LEN(@Remark)-(@offset+@MinLength+@Location-1))
				
				SET @Counter= @Counter + 1

				INSERT INTO @CrossReferenceReelInfo
				SELECT @Counter, @ReelNumber,@ReelPage
			END
			ELSE
				SET @Found=0

		END
		ELSE
			SET @Found=0
	END
	RETURN
END;

--SELECT * FROM [app].[tfnGetReelNumberAndPage]('SATISFACTION/MTGE   DISCHGS L5490 P183  L5572 P106 R165 P94')
--SELECT * FROM [app].[tfnGetReelNumberAndPage]('DISC 11/19/02 R6655 P1545   ')
--SELECT * FROM [app].[tfnGetReelNumberAndPage]('SATISFACTION/MTGE   DISCHGS L5312 P368  L5811/1 L6057/53 L5920/20 L6105/283  R117 P586 R253/676')
--SELECT * FROM [app].[tfnGetReelNumberAndPage]('SAT/MTGE            DISCHGS L192 P96    L286 P155 L4838/170 L4912/467 L5406/539')

GO
