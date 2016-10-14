﻿CREATE TABLE [dbo].[NSCARB_CONTRACT] (
    [ANNUAL_VALUE]             FLOAT (53)      NULL,
    [BILLING_DAY]              FLOAT (53)      NULL,
    [CANCELLATION_DATE]        DATETIME2 (7)   NULL,
    [CLASS_ID]                 FLOAT (53)      NULL,
    [CONTRACT_EXTID]           NVARCHAR (255)  NULL,
    [CONTRACT_ID]              FLOAT (53)      NULL,
    [CONTRACT_NAME]            NVARCHAR (999)  NULL,
    [CURRENCY_ID]              FLOAT (53)      NULL,
    [CUSTOMER_ID]              FLOAT (53)      NULL,
    [DATE_CREATED]             DATETIME2 (7)   NULL,
    [DEPARTMENT_ID]            FLOAT (53)      NULL,
    [EMAIL_TRANSACTIONS]       NVARCHAR (1)    NULL,
    [IS_INACTIVE]              NVARCHAR (1)    NULL,
    [LAST_BILLED_DATE]         DATETIME2 (7)   NULL,
    [LAST_MODIFIED_DATE]       DATETIME2 (7)   NULL,
    [LAST_USAGE_BILL_DATE]     DATETIME2 (7)   NULL,
    [LOCATION_ID]              FLOAT (53)      NULL,
    [MONTHLY_VALUE]            FLOAT (53)      NULL,
    [NEXT_BILL_DATE]           DATETIME2 (7)   NULL,
    [NEXT_USAGE_BILL_DATE]     DATETIME2 (7)   NULL,
    [ORIGINAL_NS_CONTRACT_ID]  NVARCHAR (4000) NULL,
    [PARENT_ID]                FLOAT (53)      NULL,
    [PAYMENT_METHOD_ID]        FLOAT (53)      NULL,
    [QUARTERLY_VALUE]          FLOAT (53)      NULL,
    [SEMIANNUAL_VALUE]         FLOAT (53)      NULL,
    [STATUS_ID]                FLOAT (53)      NULL,
    [TEMPPOSSIBLE_DUPE]        NVARCHAR (1)    NULL,
    [USAGE_BILLING_FREQ_ID]    FLOAT (53)      NULL,
    [USE_ORIGINAL_NETSUITE_ID] NVARCHAR (1)    NULL,
    [WEEKLY_BILLING_DAY_ID]    FLOAT (53)      NULL,
    [WEEKLY_VALUE]             FLOAT (53)      NULL
);
