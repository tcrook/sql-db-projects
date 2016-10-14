CREATE TABLE [dbo].[NSCARB_CONTRACT_BILLING_FREQ] (
    [CONTRACT_BILLING_FREQ_EXTID] NVARCHAR (255)  NULL,
    [CONTRACT_BILLING_FREQ_ID]    FLOAT (53)      NULL,
    [CONTRACT_BILLING_FREQ_NAME]  NVARCHAR (999)  NULL,
    [DATE_CREATED]                DATETIME2 (7)   NULL,
    [IS_INACTIVE]                 NVARCHAR (1)    NULL,
    [LAST_MODIFIED_DATE]          DATETIME2 (7)   NULL,
    [MONTHS]                      FLOAT (53)      NULL,
    [PARENT_ID]                   FLOAT (53)      NULL,
    [TYPE_0]                      NVARCHAR (4000) NULL,
    [WEEKS]                       FLOAT (53)      NULL
);

