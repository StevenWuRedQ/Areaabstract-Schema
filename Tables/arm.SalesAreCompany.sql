CREATE TABLE [arm].[SalesAreCompany]
(
[DeedUniqueKey] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Name] [varchar] (70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PartyType] [int] NOT NULL,
[IsSellerACompany] [bit] NULL,
[IsBuyerACompany] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [arm].[SalesAreCompany] ADD CONSTRAINT [PK_IsSalesAcompany] PRIMARY KEY CLUSTERED  ([DeedUniqueKey], [PartyType]) WITH (IGNORE_DUP_KEY=ON) ON [PRIMARY]
GO
