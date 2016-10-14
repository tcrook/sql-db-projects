CREATE TABLE [dbo].[NSCARB_INVOICE_LINK] (
    [BILLING_DATE]                  DATETIME2 (7)   NULL,
    [CONSOLIDATED_INVOICE_LINE_ID]  NVARCHAR (4000) NULL,
    [CONTRACT_LINE_AMOUNT_CHARGED]  FLOAT (53)      NULL,
    [CONTRACT_LINE_ID]              FLOAT (53)      NULL,
    [CONTRACT_RECORD_ID]            FLOAT (53)      NULL,
    [CONTRACT_USAGE_AMOUNT_CHARGED] FLOAT (53)      NULL,
    [DATE_CREATED]                  DATETIME2 (7)   NULL,
    [INVOICE_LINK_EXTID]            NVARCHAR (255)  NULL,
    [INVOICE_LINK_ID]               FLOAT (53)      NULL,
    [INVOICE_LINK_PARENT_ID]        FLOAT (53)      NULL,
    [INVOICE_RECORD_ID]             FLOAT (53)      NULL,
    [IS_INACTIVE]                   NVARCHAR (1)    NULL,
    [LAST_MODIFIED_DATE]            DATETIME2 (7)   NULL,
    [PARENT_ID]                     FLOAT (53)      NULL,
    [USAGE_RECORD_ID]               FLOAT (53)      NULL
);

