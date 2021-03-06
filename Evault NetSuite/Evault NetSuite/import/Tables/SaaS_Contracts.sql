﻿CREATE TABLE [import].[SaaS_Contracts] (
    [Contract_ID]                   VARCHAR (999)    NULL,
    [Contract_Line_ID]              VARCHAR (999)    NULL,
    [Original_NS_CL_ID]             NVARCHAR (4000)  NULL,
    [Contract_Name]                 NVARCHAR (999)   NULL,
    [Contract_Line_Name]            NVARCHAR (999)   NULL,
    [Contract_Line_Billing_ID]      NVARCHAR (4000)  NULL,
    [Sales_Order_ID]                BIGINT           NULL,
    [Transaction_Line_Unique_ID]    NVARCHAR (4000)  NULL,
    [Customer]                      NVARCHAR (256)   NULL,
    [Reseller]                      NVARCHAR (256)   NULL,
    [End_User]                      NVARCHAR (256)   NULL,
    [Customer_ID]                   BIGINT           NULL,
    [Reseller_ID]                   BIGINT           NULL,
    [End_User_ID]                   BIGINT           NULL,
    [Customer_SFDC_ID]              NVARCHAR (100)   NULL,
    [Reseller_SFDC_ID]              NVARCHAR (100)   NULL,
    [End_User_SFDC_ID]              NVARCHAR (100)   NULL,
    [Customer_NS_Number]            NVARCHAR (99)    NULL,
    [Reseller_NS_Number]            NVARCHAR (99)    NULL,
    [End_User_NS_Number]            NVARCHAR (99)    NULL,
    [Customer_End_User]             NVARCHAR (256)   NULL,
    [Customer_End_User_ID]          BIGINT           NULL,
    [Customer_End_User_SFDC_ID]     NVARCHAR (100)   NULL,
    [Customer_End_User_NS_Number]   NVARCHAR (99)    NULL,
    [Initial_Contract_Date]         DATE             NULL,
    [Direct_Indirect_Distributor]   VARCHAR (50)     NOT NULL,
    [Sales_Product_Group]           NVARCHAR (999)   NULL,
    [Sales_Product_Type]            NVARCHAR (999)   NULL,
    [Pricing_Group]                 NVARCHAR (60)    NULL,
    [Product_Type]                  NVARCHAR (999)   NULL,
    [Booking_Category]              NVARCHAR (999)   NULL,
    [Booking_Product_Group]         NVARCHAR (999)   NULL,
    [TAV_Category]                  NVARCHAR (999)   NULL,
    [Item]                          NVARCHAR (4000)  NULL,
    [Contract_Line_SFDC_ID]         NVARCHAR (99)    NULL,
    [SKU]                           NVARCHAR (4000)  NULL,
    [Storage_Type]                  NVARCHAR (4000)  NULL,
    [Quantity]                      FLOAT (53)       NULL,
    [Included_Usage_GB]             FLOAT (53)       NULL,
    [Calculated_Included_Usage_GB]  FLOAT (53)       NULL,
    [Contracted_Unit_Rate]          FLOAT (53)       NULL,
    [Overage_Rate]                  FLOAT (53)       NULL,
    [Contracted_Amount]             FLOAT (53)       NULL,
    [Contracted_Unit_Rate_USD]      NUMERIC (15, 2)  NULL,
    [Overage_Rate_USD]              NUMERIC (16, 2)  NULL,
    [Contracted_Monthly_Amount_USD] NUMERIC (26, 13) NULL,
    [Currency]                      NVARCHAR (4)     NULL,
    [Order_Line_Transaction_Type]   NVARCHAR (999)   NULL,
    [Term_Month]                    FLOAT (53)       NULL,
    [End_of_Term_Action]            NVARCHAR (999)   NULL,
    [Billing_Frequency]             NVARCHAR (999)   NULL,
    [Start_Date]                    DATE             NULL,
    [End_Date]                      DATE             NULL,
    [Cancellation_Date]             DATE             NULL,
    [Contract_Line_Status]          NVARCHAR (999)   NULL,
    [Superseded_By_ID]              VARCHAR (999)    NULL,
    [Supersedes_ID]                 VARCHAR (999)    NULL
);

