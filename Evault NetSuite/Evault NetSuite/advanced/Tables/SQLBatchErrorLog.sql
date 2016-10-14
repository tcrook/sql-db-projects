CREATE TABLE [advanced].[SQLBatchErrorLog] (
    [QueryID]               UNIQUEIDENTIFIER NULL,
    [Date]                  DATE             NULL,
    [ErrorTime]             DATETIME         NULL,
    [ErrorLine]             VARCHAR (5)      NULL,
    [ProcedureName]         VARCHAR (100)    NULL,
    [ErrorMessage]          VARCHAR (1000)   NULL,
    [GeneratedErrorMessage] VARCHAR (1500)   NULL
);

