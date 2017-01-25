CREATE TABLE [dbo].[UniqueNames]
(
[NameId] [bigint] NOT NULL IDENTITY(1, 1),
[Name] [varchar] (70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsCompany] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UniqueNames] ADD CONSTRAINT [PK_UniqueNamesId] PRIMARY KEY CLUSTERED  ([NameId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_UniqueNames_IsCompany] ON [dbo].[UniqueNames] ([IsCompany]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_UniqueNames] ON [dbo].[UniqueNames] ([NameId]) ON [PRIMARY]
GO
CREATE FULLTEXT INDEX ON [dbo].[UniqueNames] KEY INDEX [PK_UniqueNamesId] ON [Names]
GO
ALTER FULLTEXT INDEX ON [dbo].[UniqueNames] ADD ([Name] LANGUAGE 0)
GO
