CREATE TABLE [advanced].[SQLBatchLog] (
    [QueryID]       UNIQUEIDENTIFIER NULL,
    [Date]          DATE             NULL,
    [Step]          INT              NULL,
    [ProcedureName] VARCHAR (100)    NULL,
    [CompleteTime]  DATETIME         NULL
);

