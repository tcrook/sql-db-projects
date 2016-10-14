﻿CREATE TABLE [advanced].[RenewalModelData] (
    [Customer_End_User_SFDC_ID] NVARCHAR (4000) NULL,
    [Customer_End_User]         NVARCHAR (256)  NULL,
    [Active_Ind]                INT             NULL,
    [Est_First_Contract_Date]   DATE            NULL,
    [Est_Cancel_Date]           DATE            NULL,
    [Contract_Ind_Cloud]        INT             NULL,
    [Contract_Ind_SM]           INT             NULL,
    [NAICS_Code__C]             NVARCHAR (255)  NULL,
    [SIC]                       NVARCHAR (20)   NULL,
    [INDUSTRY]                  NVARCHAR (40)   NULL,
    [NUMBEROFEMPLOYEES]         INT             NULL,
    [ANNUALREVENUE]             DECIMAL (18)    NULL,
    [BillingCountry]            NVARCHAR (80)   NULL,
    [BillingState]              NVARCHAR (80)   NULL,
    [Used_Reseller]             INT             NULL,
    [Product_Type_Software]     INT             NULL,
    [Product_Type_Hardware]     INT             NULL,
    [Product_Type_Subscription] INT             NULL,
    [MAX_PURCHASED_CLOUD_GB]    INT             NULL,
    [last_posting_month]        DATE            NULL,
    [last_GB_Used]              FLOAT (53)      NULL,
    [last_GB_Purchased]         FLOAT (53)      NULL,
    [lifetime_max_GB_Purchased] FLOAT (53)      NULL,
    [peak_posting_month]        DATE            NULL,
    [peak_gb_used]              FLOAT (53)      NULL,
    [peak_gb_purchased]         FLOAT (53)      NULL,
    [GBRate_Contracted_Latest]  FLOAT (53)      NULL,
    [GBRate_Actual_Latest]      FLOAT (53)      NULL,
    [Expectation_Ratio_Latest]  FLOAT (53)      NULL,
    [GB_Overage_Total]          FLOAT (53)      NULL,
    [Payment_Overages_Total]    NUMERIC (38, 2) NULL,
    [GBRate_Overage_Effective]  FLOAT (53)      NULL,
    [restore_counts]            BIGINT          NULL,
    [restore_duration]          BIGINT          NULL,
    [restore_last_month]        DATE            NULL,
    [nmbr_support_tickets]      INT             NULL,
    [total_days_tickets_open]   INT             NULL,
    [max_days_ticket_open]      INT             NULL,
    [nmbr_priority_crit_high]   INT             NULL,
    [nmbr_priority_med_low]     INT             NULL,
    [nmbr_origin_phone]         INT             NULL,
    [nmbr_origin_other]         INT             NULL,
    [nmbr_support_lvl2]         INT             NULL,
    [nmbr_support_lvl1_lower]   INT             NULL,
    [Has_Open_Ticket]           INT             NULL,
    [Customer_End_User_ID]      FLOAT (53)      NULL
);
