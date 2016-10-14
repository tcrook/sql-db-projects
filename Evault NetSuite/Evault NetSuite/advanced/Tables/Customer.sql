CREATE TABLE [advanced].[Customer] (
    [Customer_End_User_ID]      FLOAT (53)      NULL,
    [Customer_End_User]         NVARCHAR (256)  NULL,
    [Customer_End_User_SFDC_ID] NVARCHAR (4000) NULL,
    [Active_Ind]                INT             NULL,
    [Est_First_Contract_Date]   DATE            NULL,
    [Est_Cancel_Date]           DATE            NULL,
    [Used_Reseller]             INT             NULL,
    [Product_Type_Software]     INT             NULL,
    [Product_Type_Hardware]     INT             NULL,
    [Product_Type_Subscription] INT             NULL,
    [Contract_Ind_Cloud]        INT             NULL,
    [Contract_Ind_SM]           INT             NULL
);

