﻿CREATE TABLE [dbo].[NSCARB_PRODUCT_TYPE] (
    [DATE_CREATED]       DATETIME2 (7)  NULL,
    [IS_RECORD_INACTIVE] NVARCHAR (1)   NULL,
    [LAST_MODIFIED_DATE] DATETIME2 (7)  NULL,
    [LIST_ID]            FLOAT (53)     NULL,
    [LIST_ITEM_NAME]     NVARCHAR (999) NULL,
    [PRODUCT_TYPE_EXTID] NVARCHAR (255) NULL
);
