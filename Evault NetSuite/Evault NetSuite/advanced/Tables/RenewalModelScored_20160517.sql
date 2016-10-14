CREATE TABLE [advanced].[RenewalModelScored_20160517] (
    [UserID]                 NVARCHAR (4000) NULL,
    [UserName]               NVARCHAR (256)  NULL,
    [ActiveIndicator]        INT             NULL,
    [UsedReseller]           NVARCHAR (5)    NULL,
    [SMContract]             NVARCHAR (5)    NULL,
    [MaxGBPurchased]         FLOAT (53)      NULL,
    [BillingCountry]         NVARCHAR (256)  NULL,
    [CustYears]              INT             NULL,
    [ProdTypeSoftware]       NVARCHAR (5)    NULL,
    [ProdTypeHardware]       NVARCHAR (5)    NULL,
    [NAIC2Digit]             NVARCHAR (10)   NULL,
    [RevenueType]            NVARCHAR (50)   NULL,
    [Revenue]                FLOAT (53)      NULL,
    [MaxGBUsed]              FLOAT (53)      NULL,
    [GBRate]                 FLOAT (53)      NULL,
    [ExpRatio]               FLOAT (53)      NULL,
    [HadRestore]             NVARCHAR (5)    NULL,
    [HadCSContact]           BIGINT          NULL,
    [RenewalProbabiltyScore] FLOAT (53)      NULL
);

