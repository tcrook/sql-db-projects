﻿CREATE TABLE [dbo].[NSCARB_ACCOUNTING_PERIODS] (
    [ACCOUNTING_PERIOD_ID]       FLOAT (53)     NULL,
    [CLOSED]                     NVARCHAR (3)   NULL,
    [CLOSED_ACCOUNTS_PAYABLE]    NVARCHAR (3)   NULL,
    [CLOSED_ACCOUNTS_RECEIVABLE] NVARCHAR (3)   NULL,
    [CLOSED_ALL]                 NVARCHAR (3)   NULL,
    [CLOSED_ON]                  DATETIME2 (7)  NULL,
    [CLOSED_PAYROLL]             NVARCHAR (3)   NULL,
    [DATE_LAST_MODIFIED]         DATETIME2 (7)  NULL,
    [ENDING]                     DATETIME2 (7)  NULL,
    [FISCAL_CALENDAR_ID]         FLOAT (53)     NULL,
    [FULL_NAME]                  NVARCHAR (597) NULL,
    [ISINACTIVE]                 NVARCHAR (3)   NULL,
    [LOCKED_ACCOUNTS_PAYABLE]    NVARCHAR (3)   NULL,
    [LOCKED_ACCOUNTS_RECEIVABLE] NVARCHAR (3)   NULL,
    [LOCKED_ALL]                 NVARCHAR (3)   NULL,
    [LOCKED_PAYROLL]             NVARCHAR (3)   NULL,
    [NAME]                       NVARCHAR (64)  NULL,
    [PARENT_ID]                  FLOAT (53)     NULL,
    [QUARTER]                    NVARCHAR (3)   NULL,
    [STARTING]                   DATETIME2 (7)  NULL,
    [YEAR_0]                     NVARCHAR (3)   NULL,
    [YEAR_ID]                    FLOAT (53)     NULL
);

