-- =============================================
-- Author:		  Jeffrey Wu
-- Create date: 9/26/16
-- Description:	SQL Batch code to be run on Evault Production Daily - Includes [Evault NetSuite] and [Evault SFDC]
-- =============================================
CREATE PROCEDURE [advanced].[SQLBatch]

AS
BEGIN

BEGIN TRY

/*
CREATE TABLE [advanced].[SQLBatchLog] (
    [QueryID] uniqueidentifier,
    [Date] date NULL,
    [Step] int NULL,
    [ProcedureName] varchar(100) NULL,
    [CompleteTime] datetime NULL)

CREATE TABLE [advanced].[SQLBatchErrorLog] (
    [QueryID] uniqueidentifier,
    [Date] date NULL,
    [ErrorTime] datetime NULL,
		[ErrorLine] varchar(5) NULL,
    [ProcedureName] varchar(100) NULL,
    [ErrorMessage] varchar(1000) NULL,
		[GeneratedErrorMessage] varchar(1500) NULL)
    
*/

DECLARE @Today DATE
SET @Today = (SELECT CAST(GETDATE() AS DATE))

DECLARE @NewQueryID uniqueidentifier
SET @NewQueryID = NEWID()

INSERT INTO [Evault NetSuite].advanced.SQLBatchLog
SELECT	
    @NewQueryID
    ,@Today
		,1
		,'InitiateProcedure'
		,GETDATE()

EXEC advanced.RefreshAllContracts;

INSERT INTO [Evault NetSuite].advanced.SQLBatchLog
SELECT	
    @NewQueryID
    ,@Today
		,2
		,'RefreshAllContracts'
		,GETDATE()

EXEC advanced.RefreshCustomer;

INSERT INTO [Evault NetSuite].advanced.SQLBatchLog
SELECT	
    @NewQueryID
    ,@Today
		,3
		,'RefreshCustomer'
		,GETDATE()

EXEC advanced.RefreshCustomerFinancialAgg;

INSERT INTO [Evault NetSuite].advanced.SQLBatchLog
SELECT	
    @NewQueryID
    ,@Today
		,4
		,'RefreshCustomerFinancialAgg'
		,GETDATE()

EXEC advanced.RefreshCustomerServiceAgg

INSERT INTO [Evault NetSuite].advanced.SQLBatchLog
SELECT	
    @NewQueryID
    ,@Today
		,5
		,'RefreshCustomerCustomerServiceAgg'
		,GETDATE()

EXEC advanced.RefreshRenewalModelData

INSERT INTO [Evault NetSuite].advanced.SQLBatchLog
SELECT	
    @NewQueryID
    ,@Today
		,6
		,'RefreshRenewalModelData'
		,GETDATE()

WAITFOR DELAY '00:00:01.000'

INSERT INTO [Evault NetSuite].advanced.SQLBatchLog
SELECT	
    @NewQueryID
    ,@Today
		,999
		,'Batch Complete'
		,GETDATE()

END TRY

BEGIN CATCH

DECLARE @messagebody VARCHAR(MAX) = 'The SQL Batch encountered an error at line ' + CAST(ERROR_LINE() AS VARCHAR) +' which corresponds to the ' + ERROR_PROCEDURE() + 'procedure. The error message was "' + ERROR_MESSAGE() + '"'

INSERT INTO [Evault NetSuite].advanced.SQLBatchErrorLog
SELECT	
    @NewQueryID
    ,@Today
    ,GETDATE()
		,CAST(ERROR_LINE() AS VARCHAR)
    ,ERROR_PROCEDURE()
    ,ERROR_MESSAGE()
		,@messagebody

/*
EXEC msdb.dbo.sp_send_dbmail
    @recipients = 'jpitman@carbonite.com;jwu@carbonite.com',
    @body = @messagebody,
    @subject = 'SQL Batch eVault Error' ;
*/

END CATCH

END