﻿CREATE TABLE [dbo].[vw_Booking_Test] (
    [Source_type]                          VARCHAR (8)     NOT NULL,
    [Contracted_Item_Type]                 VARCHAR (15)    NULL,
    [NonContracted_Item_Type]              VARCHAR (19)    NULL,
    [Item_Type]                            VARCHAR (19)    NULL,
    [customer]                             NVARCHAR (83)   NULL,
    [reseller]                             NVARCHAR (83)   NULL,
    [end_user]                             NVARCHAR (83)   NULL,
    [customer_end_user]                    NVARCHAR (83)   NULL,
    [customer_id]                          FLOAT (53)      NULL,
    [reseller_id]                          FLOAT (53)      NULL,
    [end_user_id]                          FLOAT (53)      NULL,
    [customer_end_user_id]                 FLOAT (53)      NULL,
    [Channel_Type]                         VARCHAR (8)     NULL,
    [Customer_SFDC_ID]                     NVARCHAR (4000) NULL,
    [Reseller_SFDC_ID]                     NVARCHAR (4000) NULL,
    [End_User_SFDC_ID]                     NVARCHAR (4000) NULL,
    [Customer_End_User_SFDC_ID]            NVARCHAR (4000) NULL,
    [GEO__C]                               NVARCHAR (1300) NULL,
    [subsidiary]                           NVARCHAR (83)   NULL,
    [TRANDATE]                             DATETIME2 (7)   NULL,
    [tranid]                               NVARCHAR (138)  NULL,
    [transaction_id]                       FLOAT (53)      NULL,
    [STATUS]                               NVARCHAR (480)  NULL,
    [CM_reason_code]                       NVARCHAR (256)  NULL,
    [CM_original_invoice_id]               INT             NULL,
    [accounting_period]                    NVARCHAR (64)   NULL,
    [Accounting_period_start_date]         DATETIME2 (7)   NULL,
    [GL_Name]                              NVARCHAR (93)   NULL,
    [CONTRACT_ID]                          FLOAT (53)      NULL,
    [CONTRACT_LINE_ID]                     FLOAT (53)      NULL,
    [contract_start_date]                  DATETIME2 (7)   NULL,
    [contract_end_date]                    DATETIME2 (7)   NULL,
    [contract_cancelled_date]              DATETIME2 (7)   NULL,
    [SUPERSEDED_BY_ID]                     FLOAT (53)      NULL,
    [SUPERSEDES_ID]                        FLOAT (53)      NULL,
    [Sales_order_number]                   NVARCHAR (138)  NULL,
    [item_name]                            NVARCHAR (180)  NULL,
    [Product_type_name]                    NVARCHAR (999)  NULL,
    [TAV_category_name]                    NVARCHAR (999)  NULL,
    [booking_product_group_name]           NVARCHAR (999)  NULL,
    [custom_prod_grouping]                 NVARCHAR (999)  NULL,
    [Finance_Product_grouping]             VARCHAR (255)   NULL,
    [order_type]                           NVARCHAR (999)  NULL,
    [Subscription_Type]                    NVARCHAR (999)  NULL,
    [Customer_sort]                        BIGINT          NULL,
    [customer_type]                        VARCHAR (18)    NULL,
    [Bill_to_Customer_sort]                BIGINT          NULL,
    [Bill_to_customer_type]                VARCHAR (18)    NULL,
    [Foreign_currency_Symbol]              NVARCHAR (4)    NULL,
    [booking_amount_foreign]               FLOAT (53)      NULL,
    [Exchange_rate_to_subsidiary_currency] FLOAT (53)      NULL,
    [Average_Exchange_rate_to_Dollar]      FLOAT (53)      NULL,
    [booking_amount_usd]                   FLOAT (53)      NULL
);

