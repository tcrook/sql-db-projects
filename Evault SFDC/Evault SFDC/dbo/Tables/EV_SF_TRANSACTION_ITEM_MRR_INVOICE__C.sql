CREATE TABLE [dbo].[EV_SF_TRANSACTION_ITEM_MRR_INVOICE__C] (
    [ID]                                NVARCHAR (18)    NULL,
    [ISDELETED]                         INT              NULL,
    [NAME]                              NVARCHAR (80)    NULL,
    [CURRENCYISOCODE]                   NVARCHAR (3)     NULL,
    [CREATEDDATE]                       DATETIME         NULL,
    [CREATEDBYID]                       NVARCHAR (18)    NULL,
    [LASTMODIFIEDDATE]                  DATETIME         NULL,
    [LASTMODIFIEDBYID]                  NVARCHAR (18)    NULL,
    [SYSTEMMODSTAMP]                    DATETIME         NULL,
    [CONNECTIONRECEIVEDID]              NVARCHAR (18)    NULL,
    [CONNECTIONSENTID]                  NVARCHAR (18)    NULL,
    [TRANSACTION__C]                    NVARCHAR (18)    NULL,
    [ACTUAL_USAGE_CHARGED__C]           INT              NULL,
    [ACTUAL_USAGE_QUANTITY__C]          DECIMAL (18, 10) NULL,
    [CONTRACT_LINE_ITEM_DESCRIPTION__C] NVARCHAR (275)   NULL,
    [COMMITTED_PER_GB_RATE__C]          DECIMAL (18, 2)  NULL,
    [CONTRACT_AMOUNT__C]                DECIMAL (8, 2)   NULL,
    [CONTRACT_LINE_ITEM__C]             NVARCHAR (18)    NULL,
    [DISTRIBUTOR_CONTACT__C]            NVARCHAR (18)    NULL,
    [NEW_CARBONITE_NETSUITE_ID__C]      NVARCHAR (8)     NULL,
    [ORIGINAL_NS_INTERNAL_ID__C]        NVARCHAR (8)     NULL,
    [ITEM__C]                           NVARCHAR (1300)  NULL,
    [NETSUITE_ID__C]                    NVARCHAR (12)    NULL,
    [OVERAGE_FEES_APPLY__C]             INT              NULL,
    [OVERAGE_NET_RATE__C]               DECIMAL (18, 2)  NULL,
    [PRODUCT_CODE_SKU__C]               NVARCHAR (1300)  NULL,
    [RELAYWARE_ID__C]                   DECIMAL (18)     NULL,
    [RESELLER_CONTACT__C]               NVARCHAR (18)    NULL,
    [HIVE_ACTUAL_USAGE_QTY__C]          DECIMAL (18, 10) NULL,
    [TOTAL_AMOUNT__C]                   DECIMAL (8, 2)   NULL,
    [TOTAL_INCLUDED_STORAGE_GB__C]      DECIMAL (18, 2)  NULL,
    [USAGE_AMOUNT__C]                   DECIMAL (8, 2)   NULL,
    [BILL_TO_ACCOUNT__C]                NVARCHAR (18)    NULL,
    [END_USER__C]                       NVARCHAR (18)    NULL,
    [RESELLER__C]                       NVARCHAR (18)    NULL,
    [SYNCH_TO_RELAYWARE__C]             INT              NULL,
    [HIDDEN_ADMIN_TEXT_FIELD__C]        NVARCHAR (255)   NULL
);


GO
CREATE NONCLUSTERED INDEX [x1609191716298EV_SF_TRANSACTIO]
    ON [dbo].[EV_SF_TRANSACTION_ITEM_MRR_INVOICE__C]([ID] ASC);

