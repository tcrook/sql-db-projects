CREATE TABLE [advanced].[CustomerFinancialAgg] (
    [Customer_End_User_SFDC_ID] NVARCHAR (4000) NULL,
    [GBRate_Contracted_Latest]  FLOAT (53)      NULL,
    [GBRate_Actual_Latest]      FLOAT (53)      NULL,
    [Expectation_Ratio_Latest]  FLOAT (53)      NULL,
    [GB_Overage_Total]          FLOAT (53)      NULL,
    [Payment_Overages_Total]    NUMERIC (38, 2) NULL,
    [GBRate_Overage_Effective]  FLOAT (53)      NULL
);

