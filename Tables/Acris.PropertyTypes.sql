CREATE TABLE [Acris].[PropertyTypes]
(
[PropCode] [nvarchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PropTypeDescription] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Acris].[PropertyTypes] ADD CONSTRAINT [PK_PropertyTypes] PRIMARY KEY CLUSTERED  ([PropCode]) ON [PRIMARY]
GO
