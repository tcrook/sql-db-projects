CREATE TABLE [dbo].[NSCARB_SAND_CURRENCIES] (
    [CURRENCY_EXTID]     INT          DEFAULT ((0)) NULL,
    [CURRENCY_ID]        INT          DEFAULT ((0)) NULL,
    [DATE_LAST_MODIFIED] DATETIME     DEFAULT ('1900/01/01') NULL,
    [IS_INACTIVE]        VARCHAR (2)  DEFAULT ('') NULL,
    [NAME]               VARCHAR (17) DEFAULT ('') NULL,
    [PRECISION_0]        INT          DEFAULT ((2)) NULL,
    [SYMBOL]             VARCHAR (3)  DEFAULT ('') NULL
);

