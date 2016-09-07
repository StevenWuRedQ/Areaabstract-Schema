CREATE TABLE [Acris].[DocumentControlCodes]
(
[RecordType] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DocumentType] [varchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DocumentTypeDescription] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ClassCodeDescription] [varchar] (27) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Party1Type] [varchar] (19) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Party2Type] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Party3Type] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Acris].[DocumentControlCodes] ADD CONSTRAINT [PK_DocumentControlCodes] PRIMARY KEY CLUSTERED  ([DocumentType]) ON [PRIMARY]
GO
