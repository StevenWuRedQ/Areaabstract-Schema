-- =============================================
-- Author:					Steven Wu

-- Creation date:			07/13/2017

-- Modifications dates:		

-- Description:				This view will select all the row transaction of ACRIS daily update
 
-- Relative tables:			Acris.UCCLot
--							dbo.RowTransactionCommitted
--							

-- =============================================

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [Acris].[vwUpdateTrancation]
AS
SELECT      Acris.UCCLot.BBL, 
			dbo.RowTransactionCommitted.IsInsert,
			dbo.RowTransactionCommitted.IsDelete, 
			dbo.RowTransactionCommitted.IsUpdate, 
			dbo.RowTransactionCommitted.TransactionDateTime, 
            dbo.RowTransactionCommitted.DateTimeProcessed, 
			dbo.RowTransactionCommitted.IdentifyingColumnName, 
			dbo.RowTransactionCommitted.TableName
FROM        dbo.RowTransactionCommitted INNER JOIN
            Acris.UCCLot 
			ON SUBSTRING(dbo.RowTransactionCommitted.IdentifyingValue, 1, 16) = Acris.UCCLot.UniqueKey

GO
