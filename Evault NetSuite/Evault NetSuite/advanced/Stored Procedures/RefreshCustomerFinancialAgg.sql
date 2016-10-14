CREATE PROC [advanced].[RefreshCustomerFinancialAgg] AS

IF OBJECT_ID('[Evault NetSuite].advanced.AllCIU', 'U') IS NOT NULL DROP TABLE [Evault NetSuite].advanced.AllCIU;
SELECT
  Contract_ID
  ,Contract_Line_ID
  ,Contract_Name
  ,Contract_Line_Name
  ,Contract_Line_Billing_ID
  ,Customer
  ,Reseller
  ,End_User
  ,Customer_ID
  ,Reseller_ID
  ,End_User_ID
  ,Customer_SFDC_ID
  ,Reseller_SFDC_ID
  ,End_User_SFDC_ID
  ,Customer_NS_Number
  ,Reseller_NS_Number
  ,End_User_NS_Number
  ,Customer_End_User
  ,Customer_End_User_ID
  ,Customer_End_User_SFDC_ID
  ,Customer_End_User_NS_Number
  ,Direct_Indirect_Distributor
  ,Initial_Contract_Date
  ,Customer_Account_Type
  ,Sales_Product_Group
  ,Sales_Product_Type
  ,Pricing_Group
  ,Product_Type
  ,Booking_Category
  ,Booking_Product_Group
  ,TAV_Category
  ,Item
  ,Contract_Line_SFDC_ID
  ,SKU
  ,Storage_Type
  ,Quantity
  ,Included_Usage_GB
  ,Calculated_Included_Usage_GB
  ,Contracted_Unit_Rate
  ,Overage_Rate
  ,Contracted_Amount
  ,Contracted_Unit_Rate_USD
  ,Overage_Rate_USD
  ,Contracted_Amount_USD
  ,Contract_Currency
  ,Order_Line_Transaction_Type
  ,Term_Month
  ,End_of_Term_Action
  ,Billing_Frequency
  ,Start_Date
  ,End_Date
  ,Cancellation_Date
  ,Contract_Line_Status
  ,Superseded_By_ID
  ,Supersedes_ID
  ,Billing_Date
  ,Invoice_Number
  ,Invoice_Currency
  ,Invoice_Status
  ,Total_Usage_GB
  ,Overage_GB
  ,Contract_Line_Amount_Charged
  ,Contract_Usage_Amount_Charged
  ,Invoice_Total
  ,Contract_Line_Amount_Charged_USD
  ,Contract_Usage_Amount_Charged_USD
  ,Invoice_Total_USD
  ,Approved_Invoice
  ,Transaction_ID
  ,Transaction_Date
  ,Sales_Effective_Date
  ,Posting_Period
  ,Posting_Period_Month
  ,Invoice_Create_Date
  INTO [Evault NetSuite].advanced.AllCIU
FROM [Evault NetSuite].advanced.CIU_Historical
UNION
SELECT
  CAST(Contract_ID as VARCHAR(50))
  ,CAST(Contract_Line_ID as VARCHAR(50))
  ,Contract_Name
  ,Contract_Line_Name
  ,Contract_Line_Billing_ID
  ,Customer
  ,Reseller
  ,End_User
  ,Customer_ID
  ,Reseller_ID
  ,End_User_ID
  ,Customer_SFDC_ID
  ,Reseller_SFDC_ID
  ,End_User_SFDC_ID
  ,Customer_NS_Number
  ,Reseller_NS_Number
  ,End_User_NS_Number
  ,Customer_End_User
  ,Customer_End_User_ID
  ,Customer_End_User_SFDC_ID
  ,Customer_End_User_NS_Number
  ,Direct_Indirect_Distributor
  ,Initial_Contract_Date
  ,Customer_Account_Type
  ,Sales_Product_Group
  ,Sales_Product_Type
  ,Pricing_Group
  ,Product_Type
  ,Booking_Category
  ,Booking_Product_Group
  ,TAV_Category
  ,Item
  ,Contract_Line_SFDC_ID
  ,SKU
  ,Storage_Type
  ,Quantity
  ,Included_Usage_GB
  ,Calculated_Included_Usage_GB
  ,Contracted_Unit_Rate
  ,Overage_Rate
  ,Contracted_Amount
  ,Contracted_Unit_Rate_USD
  ,Overage_Rate_USD
  ,Contracted_Amount_USD
  ,Contract_Currency
  ,Order_Line_Transaction_Type
  ,Term_Month
  ,End_of_Term_Action
  ,Billing_Frequency
  ,Start_Date
  ,End_Date
  ,Cancellation_Date
  ,Contract_Line_Status
  ,CAST(Superseded_By_ID as VARCHAR(50))
  ,CAST(Supersedes_ID as VARCHAR(50))
  ,Billing_Date
  ,Invoice_Number
  ,Invoice_Currency
  ,Invoice_Status
  ,Total_Usage_GB
  ,Overage_GB
  ,Contract_Line_Amount_Charged
  ,Contract_Usage_Amount_Charged
  ,Invoice_Total
  ,Contract_Line_Amount_Charged_USD
  ,Contract_Usage_Amount_Charged_USD
  ,Invoice_Total_USD
  ,Approved_Invoice
  ,Transaction_ID
  ,Transaction_Date
  ,Sales_Effective_Date
  ,Posting_Period
  ,Posting_Period_Month
  ,Invoice_Create_Date
FROM [Evault NetSuite].dbo.V__NS_Hosted_Contract_Invoice_Usage_SKU ciu WITH (NOLOCK)


SELECT
       Customer_End_User_SFDC_ID,
       Billing_Frequency,
       CAST(Transaction_Date AS DATE) AS Transaction_Date,
       SUM(Calculated_Included_Usage_GB) as GB_Purchased,
       SUM(Total_Usage_GB - Overage_GB) AS GB_Incl_Used,
       SUM(Overage_GB) AS GB_Overage,
       SUM(Total_Usage_GB) AS GB_Total,
       SUM(Contract_Line_Amount_Charged_USD) as Payment_Contract_Total,
       SUM(CASE WHEN Calculated_Included_Usage_GB <= 0 THEN 0 ELSE Contract_Line_Amount_Charged_USD END) as Payment_GB_Total,
       SUM(Contract_Usage_Amount_Charged_USD) as Payment_Overages,
       SUM(Invoice_Total_USD) as Payment_Actual,
       ROW_NUMBER() OVER (PARTITION BY Customer_End_User_SFDC_ID ORDER BY CAST(Transaction_Date AS DATE) DESC) as Row_Num
       INTO #evault_cust_financial
  FROM [Evault NetSuite].advanced.AllCIU
  WHERE Booking_Product_Group NOT IN ('EVault Endpoint Protection', 'LTS2')
  GROUP BY
       Customer_End_User_SFDC_ID,
       Billing_Frequency,
       CAST(Transaction_Date AS DATE)

IF OBJECT_ID('[Evault NetSuite].advanced.CustomerFinancialAgg', 'U') IS NOT NULL DROP TABLE [Evault NetSuite].advanced.CustomerFinancialAgg;
SELECT
  ecf.Customer_End_User_SFDC_ID
  ,CASE WHEN GB_Purchased > 0 THEN Payment_GB_Total / GB_Purchased ELSE NULL END as GBRate_Contracted_Latest
  ,CASE WHEN GB_Total > 0 THEN (Payment_GB_Total + Payment_Overages) / CASE WHEN GB_Total > GB_Purchased THEN GB_Total ELSE GB_Purchased END ELSE NULL END as GBRate_Actual_Latest
  ,CASE WHEN GB_Purchased > 0 AND Payment_GB_Total > 0 THEN
  CASE WHEN GB_Total > 0 THEN (Payment_GB_Total + Payment_Overages) / CASE WHEN GB_Total > GB_Purchased THEN GB_Total ELSE GB_Purchased END  ELSE NULL END / 
    CASE WHEN GB_Purchased > 0 THEN Payment_GB_Total / GB_Purchased ELSE NULL END 
    ELSE NULL END as Expectation_Ratio_Latest
  ,ecf2.GB_Overage_Total
  ,ecf2.Payment_Overages_Total
  ,ecf2.GBRate_Overage_Effective
  INTO [Evault NetSuite].advanced.CustomerFinancialAgg
FROM #evault_cust_financial ecf
  LEFT JOIN 
    (SELECT
      Customer_End_User_SFDC_ID
      ,SUM(GB_Overage) as GB_Overage_Total
      ,SUM(Payment_Overages) as Payment_Overages_Total
      ,CASE WHEN SUM(GB_Overage) = 0 THEN NULL ELSE SUM(Payment_Overages) / SUM(GB_Overage) END as GBRate_Overage_Effective
    FROM #evault_cust_financial
    GROUP BY Customer_End_User_SFDC_ID) ecf2
ON ecf.Customer_End_User_SFDC_ID = ecf2.Customer_End_User_SFDC_ID
WHERE Row_Num = 1