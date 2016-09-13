CREATE TABLE [stage].[UCCCrossReference]
(
[RecordId] [bigint] NOT NULL IDENTITY(1, 1),
[UniqueKey] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CRFN] [varchar] (13) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Doc_id_ref] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[File_nbr] [varchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
