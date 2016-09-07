CREATE TABLE [dbo].[Imports_Flat_Files]
(
[FileName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FileType] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Imports_Flat_Files] ADD CONSTRAINT [PK_Imports_Flat_Files] PRIMARY KEY CLUSTERED  ([FileName]) ON [PRIMARY]
GO
