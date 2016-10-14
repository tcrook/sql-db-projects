﻿CREATE TABLE [dbo].[NSCARB_REVENUE_PLAN_LINES] (
    [ACCOUNTING_PERIOD_ID]           FLOAT (53)      NULL,
    [ACTUAL_USAGE]                   NVARCHAR (1)    NULL,
    [ADDON_PRODUCT]                  NVARCHAR (1)    NULL,
    [ADD_TO_RENEWAL]                 NVARCHAR (1)    NULL,
    [AMOUNT]                         FLOAT (53)      NULL,
    [APPLIANCE_SERIAL_NUMBER]        NVARCHAR (4000) NULL,
    [ASSOCIATED_SHIPPING_COST]       FLOAT (53)      NULL,
    [ASSOCIATED_SHIPPING_ITEM_ID]    FLOAT (53)      NULL,
    [BILLING_ID]                     NVARCHAR (4000) NULL,
    [BOOKING_PRODUCT_GROUP]          NVARCHAR (4000) NULL,
    [BUNDLE_COMPONENT_TAV]           NVARCHAR (4000) NULL,
    [CALCULATED_INCLUDED_STORAGE]    FLOAT (53)      NULL,
    [CDR_CERTIFICATION_COMPLETE_L]   NVARCHAR (1)    NULL,
    [CDR_CERTIFICATION_NEEDED]       NVARCHAR (1)    NULL,
    [CDR_PRETEST_COMPLETE_L]         NVARCHAR (1)    NULL,
    [CDR_PRETEST_NEEDED]             NVARCHAR (1)    NULL,
    [CONSOLIDATED_INVOICE_LINE_ID]   NVARCHAR (4000) NULL,
    [CONTRACTED_DISCOUNT]            FLOAT (53)      NULL,
    [CONTRACTED_DISCOUNT_]           FLOAT (53)      NULL,
    [CONTRACT_BILLING_FREQ_ID]       FLOAT (53)      NULL,
    [CONTRACT_ENDOFTERM_ACTION_ID]   FLOAT (53)      NULL,
    [CONTRACT_ITEM]                  NVARCHAR (1)    NULL,
    [CONTRACT_ITEM_TYPE_ID]          FLOAT (53)      NULL,
    [CONTRACT_LINE_FOR_COTERMING_ID] FLOAT (53)      NULL,
    [CONTRACT_LINE_TO_CANCEL]        NVARCHAR (4000) NULL,
    [CONTRACT_LINE_TO_RENEW_ID]      FLOAT (53)      NULL,
    [CONTRACT_LINE_TO_RETURN_ID]     FLOAT (53)      NULL,
    [CONTRACT_LINE_TO_SUPERSEDE_ID]  FLOAT (53)      NULL,
    [CONTRACT_RATE]                  FLOAT (53)      NULL,
    [CONTRACT_TERM_MONTHS]           FLOAT (53)      NULL,
    [CONTRACT_TERM_RENEWAL_LINE]     FLOAT (53)      NULL,
    [CREDENTIAL_EMAIL_PROVISIONING]  NVARCHAR (1)    NULL,
    [CREDENTIAL_EMAIL_PROVISIONIN_0] NVARCHAR (1)    NULL,
    [CUSTOM_QUANTITY]                FLOAT (53)      NULL,
    [DAILY_NET_SALES_RATE]           FLOAT (53)      NULL,
    [DATE_CREATED]                   DATETIME2 (7)   NULL,
    [DATE_LAST_MODIFIED]             DATETIME2 (7)   NULL,
    [DATE_PROVISIONED]               DATETIME2 (7)   NULL,
    [END_DATE]                       DATETIME2 (7)   NULL,
    [END_USER_ID]                    FLOAT (53)      NULL,
    [EXTERNAL_ID]                    NVARCHAR (4000) NULL,
    [EXTERNAL_NAME]                  NVARCHAR (4000) NULL,
    [FIRST_RECURRING_BILL_DATE]      DATETIME2 (7)   NULL,
    [FROM_CONTRACT_LINE_ID]          FLOAT (53)      NULL,
    [FROM_CONTRACT_USAGE_ID]         FLOAT (53)      NULL,
    [GROSS_AMOUNT]                   FLOAT (53)      NULL,
    [GROSS_AMOUNT1]                  FLOAT (53)      NULL,
    [HARDWARE_CLASSIFICATION_ID]     FLOAT (53)      NULL,
    [HISTORICAL_TAX_AMOUNT_FROM_EV]  NVARCHAR (4000) NULL,
    [INCLUDED_USAGE]                 FLOAT (53)      NULL,
    [IS_RECOGNIZED]                  NVARCHAR (3)    NULL,
    [ITEM_PRICING_GROUP_ID]          FLOAT (53)      NULL,
    [JOURNAL_ID]                     FLOAT (53)      NULL,
    [LICENSE_PROVISIONING_NEEDED]    NVARCHAR (1)    NULL,
    [LICENSING_PROVISIONING_COMPLE]  NVARCHAR (1)    NULL,
    [LINE_ID]                        NVARCHAR (4000) NULL,
    [LINE_ITEM_TAV]                  FLOAT (53)      NULL,
    [LINE_ITEM_TCV]                  FLOAT (53)      NULL,
    [LINKED_CONTRACT_LINES_ID]       FLOAT (53)      NULL,
    [LIST_PRICE]                     FLOAT (53)      NULL,
    [MANAGED_SERVICES_PROVISIONING]  NVARCHAR (1)    NULL,
    [MANAGED_SERVICES_PROVISIONIN_0] NVARCHAR (1)    NULL,
    [MANUAL_RATE]                    NVARCHAR (1)    NULL,
    [MID_TIER_TICKET_ID_L]           NVARCHAR (4000) NULL,
    [ORDER_LINE_CANCELATION_DATE]    DATETIME2 (7)   NULL,
    [ORDER_LINE_TRANSACTION_TYPE_ID] FLOAT (53)      NULL,
    [ORIGINAL_LIST_PRICE]            FLOAT (53)      NULL,
    [ORIGINAL_ORDER_NETSUITE_LINE_]  NVARCHAR (4000) NULL,
    [ORIGINAL_RR_DELAY]              NVARCHAR (1)    NULL,
    [ORIGINAL_RR_END_DATE]           DATETIME2 (7)   NULL,
    [ORIGINAL_RR_SCHEDULE]           NVARCHAR (4000) NULL,
    [ORIGINAL_RR_START_DATE]         DATETIME2 (7)   NULL,
    [OVERAGE_FEES_APPLY]             NVARCHAR (1)    NULL,
    [OVERAGE_RATE_DISCOUNT]          FLOAT (53)      NULL,
    [OVERAGE_RATE_LIST]              FLOAT (53)      NULL,
    [OVERAGE_RATE_NET]               FLOAT (53)      NULL,
    [PARENT_LINE_ID]                 NVARCHAR (4000) NULL,
    [PICK_UP]                        NVARCHAR (1)    NULL,
    [PLAN_ID]                        FLOAT (53)      NULL,
    [PROCUREMENT_PROVISIONING_COMP]  NVARCHAR (1)    NULL,
    [PROCUREMENT_PROVISIONING_NEED]  NVARCHAR (1)    NULL,
    [PRODUCT_CHARGE_TYPE]            NVARCHAR (4000) NULL,
    [PRODUCT_CODESKU]                NVARCHAR (4000) NULL,
    [PRODUCT_TYPE]                   NVARCHAR (4000) NULL,
    [PROMOTION_DISCOUNT]             FLOAT (53)      NULL,
    [PROMOTION_ITEM]                 NVARCHAR (1)    NULL,
    [PROMOTION_OVERAGE_FEE_DISCOUN]  FLOAT (53)      NULL,
    [PROMOTION_TYPE]                 NVARCHAR (4000) NULL,
    [PROVISION_NEEDED_]              NVARCHAR (1)    NULL,
    [PRO_SERVICES_PROVISIONING_COM]  NVARCHAR (1)    NULL,
    [PRO_SERVICES_PROVISIONING_NEE]  NVARCHAR (1)    NULL,
    [PS_HOURS]                       FLOAT (53)      NULL,
    [PURCHASING_PRODUCT_TYPE_ID]     FLOAT (53)      NULL,
    [RECONTRACT]                     NVARCHAR (1)    NULL,
    [RELATED_ASSET_ID]               FLOAT (53)      NULL,
    [RELATED_SWAPPLIANCE_ITEM_DESC]  NVARCHAR (4000) NULL,
    [RELATED_SWAPPLIANCE_ITEM_ID]    FLOAT (53)      NULL,
    [RELATED_SWAPPLIANCE_ITEM_SKU]   NVARCHAR (4000) NULL,
    [RELATED_SWAPPLIANCE_ITEM_TOTA]  FLOAT (53)      NULL,
    [RELATED_SWAPPLIANCE_LIST_PRIC]  FLOAT (53)      NULL,
    [RENEWAL_TRANSACTION_TYPE_ID]    FLOAT (53)      NULL,
    [RESELLER_ID]                    FLOAT (53)      NULL,
    [ROLLOVER_BILLING_FREQ_ID]       FLOAT (53)      NULL,
    [SALESFORCE_ID]                  NVARCHAR (4000) NULL,
    [SALESFORCE_QUOTE_LINE_ID]       NVARCHAR (4000) NULL,
    [SEEDING_DEVICE_ID]              FLOAT (53)      NULL,
    [SERVER_ENVIRONMENT_ID]          FLOAT (53)      NULL,
    [SERVER_QUANTITY]                FLOAT (53)      NULL,
    [SF_ITEM_ID]                     NVARCHAR (4000) NULL,
    [SHIPTO_ADDRESS__LINE_LEVEL]     NVARCHAR (4000) NULL,
    [SHIPTO_ENTITYUSE_CODE_ID]       FLOAT (53)      NULL,
    [SHIPTO_LATITUDE]                NVARCHAR (4000) NULL,
    [SHIPTO_LONGITUDE]               NVARCHAR (4000) NULL,
    [START_DATE]                     DATETIME2 (7)   NULL,
    [STORAGE_TYPE]                   NVARCHAR (4000) NULL,
    [TERM_IN_DAYS]                   FLOAT (53)      NULL,
    [TOTAL_DISCOUNT]                 FLOAT (53)      NULL,
    [TRACK_USAGE]                    NVARCHAR (1)    NULL,
    [TRAINING_PROVISIONING_COMPLET]  NVARCHAR (1)    NULL,
    [TRAINING_PROVISIONING_NEEDED_]  NVARCHAR (1)    NULL,
    [TRANSACTION_LINE_UNIQUE_ID]     NVARCHAR (4000) NULL,
    [VAULT_PROVISIONING_COMPLETE_L]  NVARCHAR (1)    NULL,
    [VAULT_PROVISION_NEEDED]         NVARCHAR (1)    NULL
);

