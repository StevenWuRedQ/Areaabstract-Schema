SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE FUNCTION [app].[tfnGetReelNumberAndPageV2](@Remark VARCHAR(MAX))
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
	DECLARE @Counter INTEGER = 0

	DECLARE @i AS INTEGER = 1
	DECLARE @State AS INTEGER = 0
	DECLARE @token VARCHAR(100)=''
	DECLARE @char CHAR(1)=''
	SET @Remark = LTRIM(RTRIM(@Remark))
	SET @Remark = @Remark + '~'
	WHILE (@i<=LEN(@Remark))
	BEGIN
		SET @char = UPPER(SUBSTRING(@Remark,@i,1))
		IF (@char<>' ')
		BEGIN
			IF (@state=0)
			BEGIN
				SET @state = CASE 
								WHEN @char='L' THEN 1
								WHEN @char='R' THEN 1
								ELSE 0
							 END
			END
			ELSE IF (@state=1)
			BEGIN
				SET @state = CASE
								WHEN @char='.' THEN 2
								WHEN @char>='0' AND @char<='9' THEN 2
								ELSE 0
							 END
				IF (@state=2)
					SET @token = @char
			END
			ELSE IF (@state=2)
			BEGIN
				SET @state = CASE 
								WHEN @char>='0' AND @char<='9' THEN 2
								WHEN @char='P' THEN 3
								WHEN @char='/' THEN 4
								ELSE 0
							 END
				IF (@state=2)
					SET @token = @token + @char
				ELSE
				BEGIN
					IF (LEN(@token)<>0)
					BEGIN
						SET @ReelNumber=@token
						SET @ReelNumber = Utilities.util.fnLPadString(@ReelNumber,'0',5)
						IF (@state =3)
							SET @token= @char	
						ELSE	
							SET @token=''		
					END 
					ELSE
						SET @State=0
				END
			END
			ELSE IF (@state=3)
			BEGIN
				SET @state = CASE 
								WHEN @char='G' THEN 3
								WHEN @char='.' THEN 4
								WHEN @char>='0' AND @char<='9' THEN 4
								ELSE 0
							 END
				IF (@state=4) AND (@char<>'.')
					SET @token = @char
			END
			ELSE IF (@state=4)
			BEGIN
				SET @state = CASE 
								WHEN @char>='0' AND @char<='9' THEN 4
								WHEN @char='L' THEN 1
								WHEN @char='R' THEN 1
								ELSE 0
							 END
				IF (@state=4)
					SET @token = @token + @char
				ELSE
				BEGIN
					IF (LEN(@token)<>0)
					BEGIN
						SET @ReelPage=@token
						SET @ReelPage = Utilities.util.fnLPadString(@ReelPage,'0',5)
						SET @token=''		
	
						SET @Counter= @Counter + 1

						INSERT INTO @CrossReferenceReelInfo
						SELECT @Counter, @ReelNumber,@ReelPage
	
					END 
					ELSE
						SET @State=0
				END
			END
		END
		SET @i = @i+1
	END

	RETURN
END;

--SELECT * FROM [app].[tfnGetReelNumberAndPageV2]('SATISFACTION/MTGE   DISCHGS L5490 P183  L5572 P106 R165 P94')
--SELECT * FROM [app].[tfnGetReelNumberAndPageV2]('DISC 11/19/02 R6655 P1545   ')
--SELECT * FROM [app].[tfnGetReelNumberAndPageV2]('SATISFACTION/MTGE   DISCHGS L5312 P368  L5811/1 L6057/53 L5920/20 L6105/283  R117 P586 R253/676')
--SELECT * FROM [app].[tfnGetReelNumberAndPageV2]('SAT/MTGE            DISCHGS L192 P96    L286 P155 L4838/170 L4912/467 L5406/539')

GO
