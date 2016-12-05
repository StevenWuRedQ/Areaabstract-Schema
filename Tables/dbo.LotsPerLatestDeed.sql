CREATE TABLE [dbo].[LotsPerLatestDeed]
(
[DeedUniqueKey] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[NumberOfLots] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LotsPerLatestDeed] ADD CONSTRAINT [PK_LotsPerLatestDeed] PRIMARY KEY CLUSTERED  ([DeedUniqueKey]) ON [PRIMARY]
GO
