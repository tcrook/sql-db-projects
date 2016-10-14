CREATE TABLE [advanced].[RenewalModelScored_20161014] (
    [Customer_End_User_SFDC_ID] NVARCHAR (4000) NULL,
    [Customer_End_User]         NVARCHAR (256)  NULL,
    [ActiveIndicator]           INT             NULL,
    [UsedReseller]              NVARCHAR (5)    NULL,
    [SMContract]                NVARCHAR (5)    NULL,
    [BillingCountry]            NVARCHAR (80)   NULL,
    [CustYears]                 BIGINT          NULL,
    [ProdTypeSoftware]          NVARCHAR (5)    NULL,
    [ProdTypeHardware]          NVARCHAR (5)    NULL,
    [NAIC2Digit]                NVARCHAR (10)   NULL,
    [RevenueType]               NVARCHAR (20)   NULL,
    [Revenue]                   FLOAT (53)      NULL,
    [MaxGBUsed]                 FLOAT (53)      NULL,
    [GBRate]                    FLOAT (53)      NULL,
    [ExpRatio]                  FLOAT (53)      NULL,
    [HadRestore]                NVARCHAR (5)    NULL,
    [HadCSContact]              BIGINT          NULL,
    [RenewalProbabiltyScore]    FLOAT (53)      NULL
);

