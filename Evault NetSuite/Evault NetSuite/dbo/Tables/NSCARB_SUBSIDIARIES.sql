﻿CREATE TABLE [dbo].[NSCARB_SUBSIDIARIES] (
    [ADDRESS]                      NVARCHAR (999)  NULL,
    [ADDRESS1]                     NVARCHAR (150)  NULL,
    [ADDRESS2]                     NVARCHAR (150)  NULL,
    [BASE_CURRENCY_ID]             FLOAT (53)      NULL,
    [CHAMBER_OF_COMMERCE]          NVARCHAR (4000) NULL,
    [CHAMBER_OF_COMMERCE_LABEL]    NVARCHAR (4000) NULL,
    [CITY]                         NVARCHAR (50)   NULL,
    [COUNTRY]                      NVARCHAR (2)    NULL,
    [CREDIT_MEMO_TAX_CODE_ID]      FLOAT (53)      NULL,
    [DATE_LAST_MODIFIED]           DATETIME2 (7)   NULL,
    [DEPRECIATION_DIVISION_ID]     FLOAT (53)      NULL,
    [DIVISION_NUMBER]              NVARCHAR (4000) NULL,
    [DROPSHIP_COGS_COST_CENTER_ID] FLOAT (53)      NULL,
    [EDITION]                      NVARCHAR (20)   NULL,
    [FEDERAL_NUMBER]               NVARCHAR (15)   NULL,
    [FISCAL_CALENDAR_ID]           FLOAT (53)      NULL,
    [FULL_NAME]                    NVARCHAR (1791) NULL,
    [ISINACTIVE]                   NVARCHAR (3)    NULL,
    [IS_ELIMINATION]               NVARCHAR (3)    NULL,
    [IS_MOSS]                      NVARCHAR (3)    NULL,
    [LEGAL_NAME]                   NVARCHAR (83)   NULL,
    [MOSS_NEXUS_ID]                FLOAT (53)      NULL,
    [NAME]                         NVARCHAR (83)   NULL,
    [PARENT_ID]                    FLOAT (53)      NULL,
    [PURCHASEORDERAMOUNT]          FLOAT (53)      NULL,
    [PURCHASEORDERQUANTITY]        FLOAT (53)      NULL,
    [PURCHASEORDERQUANTITYDIFF]    FLOAT (53)      NULL,
    [PURCHASING_BILLTO_ADDRESS]    NVARCHAR (4000) NULL,
    [RECEIPTAMOUNT]                FLOAT (53)      NULL,
    [RECEIPTQUANTITY]              FLOAT (53)      NULL,
    [RECEIPTQUANTITYDIFF]          FLOAT (53)      NULL,
    [RETURN_ADDRESS]               NVARCHAR (999)  NULL,
    [RETURN_ADDRESS1]              NVARCHAR (150)  NULL,
    [RETURN_ADDRESS2]              NVARCHAR (150)  NULL,
    [RETURN_CITY]                  NVARCHAR (50)   NULL,
    [RETURN_COUNTRY]               NVARCHAR (50)   NULL,
    [RETURN_STATE]                 NVARCHAR (50)   NULL,
    [RETURN_ZIPCODE]               NVARCHAR (36)   NULL,
    [SHIPPING_ADDRESS]             NVARCHAR (999)  NULL,
    [SHIPPING_ADDRESS1]            NVARCHAR (150)  NULL,
    [SHIPPING_ADDRESS2]            NVARCHAR (150)  NULL,
    [SHIPPING_CITY]                NVARCHAR (50)   NULL,
    [SHIPPING_COUNTRY]             NVARCHAR (50)   NULL,
    [SHIPPING_STATE]               NVARCHAR (50)   NULL,
    [SHIPPING_ZIPCODE]             NVARCHAR (36)   NULL,
    [STATE]                        NVARCHAR (20)   NULL,
    [STATE_TAX_NUMBER]             NVARCHAR (20)   NULL,
    [SUBSIDIARY_EXTID]             NVARCHAR (255)  NULL,
    [SUBSIDIARY_ID]                FLOAT (53)      NULL,
    [TAX_ID]                       NVARCHAR (4000) NULL,
    [TAX_ID_LABEL]                 NVARCHAR (4000) NULL,
    [TRAN_NUM_PREFIX]              NVARCHAR (8)    NULL,
    [URL]                          NVARCHAR (64)   NULL,
    [VAT_COMMENT]                  NVARCHAR (4000) NULL,
    [ZIPCODE]                      NVARCHAR (36)   NULL
);

