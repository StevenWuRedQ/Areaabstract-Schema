CREATE TABLE [dbo].[Imports_Flat_Files_Log]
(
[FileName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FileType] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ImportDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Imports_Flat_Files_Log] ADD CONSTRAINT [PK_Imports_Flat_Files_log] PRIMARY KEY CLUSTERED  ([FileName]) ON [PRIMARY]
GO
