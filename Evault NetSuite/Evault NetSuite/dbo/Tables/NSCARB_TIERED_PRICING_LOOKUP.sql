﻿CREATE TABLE [dbo].[NSCARB_TIERED_PRICING_LOOKUP] (
    [DATE_CREATED]                DATETIME2 (7)  NULL,
    [FROM_QUANTITY]               FLOAT (53)     NULL,
    [INCLUDED_STORAGE]            FLOAT (53)     NULL,
    [IS_INACTIVE]                 NVARCHAR (256) NULL,
    [LAST_MODIFIED_DATE]          DATETIME2 (7)  NULL,
    [LEAD_ITEM_ID]                FLOAT (53)     NULL,
    [PARENT_ID]                   FLOAT (53)     NULL,
    [SKU_1_YEAR_TERM]             NVARCHAR (256) NULL,
    [SKU_2_YEAR_TERM]             NVARCHAR (256) NULL,
    [SKU_3_YEAR_TERM]             NVARCHAR (256) NULL,
    [SUBSCRIPTION_PLAN_NAME]      NVARCHAR (256) NULL,
    [SYNNEX_SKU]                  NVARCHAR (256) NULL,
    [TIERED_PRICING_LOOKUP_EXTID] FLOAT (53)     NULL,
    [TIERED_PRICING_LOOKUP_ID]    FLOAT (53)     NULL,
    [TIERED_PRICING_LOOKUP_NAME]  NVARCHAR (256) NULL,
    [TO_QUANTITY]                 FLOAT (53)     NULL
);
