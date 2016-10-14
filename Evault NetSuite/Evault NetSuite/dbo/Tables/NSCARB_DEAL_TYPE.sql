﻿CREATE TABLE [dbo].[NSCARB_DEAL_TYPE] (
    [DATE_CREATED]       DATETIME2 (7)  NULL,
    [DEAL_TYPE_EXTID]    NVARCHAR (255) NULL,
    [IS_RECORD_INACTIVE] NVARCHAR (1)   NULL,
    [LAST_MODIFIED_DATE] DATETIME2 (7)  NULL,
    [LIST_ID]            FLOAT (53)     NULL,
    [LIST_ITEM_NAME]     NVARCHAR (999) NULL
);

