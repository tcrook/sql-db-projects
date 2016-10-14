CREATE TABLE [dbo].[NSCARB_SAND_CURRENCYRATES] (
    [ANCHOR_CURRENCY_ID]       VARCHAR (4)      NULL,
    [BASE_CURRENCY_ID]         INT              NULL,
    [CURRENCYRATE_ID]          INT              NULL,
    [CURRENCYRATE_PROVIDER_ID] VARCHAR (4)      NULL,
    [CURRENCY_ID]              INT              NULL,
    [DATE_EFFECTIVE]           DATETIME2 (7)    NULL,
    [DATE_LAST_MODIFIED]       DATETIME2 (7)    NULL,
    [EXCHANGE_RATE]            NUMERIC (19, 15) NULL,
    [IS_ANCHOR_ONLY]           VARCHAR (2)      NULL,
    [UPDATE_METHOD_ID]         VARCHAR (6)      NULL
);

