CREATE PROC [advanced].[RefreshAllContracts] AS

IF OBJECT_ID('[Evault Netsuite].advanced.AllContracts', 'U') IS NOT NULL DROP TABLE [Evault Netsuite].advanced.AllContracts;
SELECT
  'Contracts' as Source
 ,CAST(Contract_ID as VARCHAR(50)) as Contract_ID
 ,CAST(Contract_Line_ID as VARCHAR(50)) as Contract_Line_ID
 ,Contract_Name
 ,Contract_Line_Name
 ,Sales_Order_ID
 ,Transaction_Line_Unique_ID
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
 ,Order_Line_Transaction_Type
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
 ,Contracted_Unit_Rate_USD
 ,Overage_Rate
 ,Overage_Rate_USD
 ,Contracted_Amount
 ,Contracted_Monthly_Amount
 ,Contracted_Amount_USD
 ,Contracted_Monthly_Amount_USD
 ,Currency
 ,Original_List_Price
 ,Original_List_Price_USD
 ,Contracted_Discount
 ,Total_Discount
 ,DATEDIFF(month, Start_Date, End_Date) as Term_Month
 ,Billing_Frequency
 ,CAST(Superseded_By_ID as VARCHAR(50)) as Superseded_By_ID
 ,CAST(Supersedes_ID as VARCHAR(50)) as Supersedes_ID
 ,Start_Date
 ,End_Date
 ,End_of_Term_Action
 ,Cancellation_Date
 ,Contract_Line_Status
 INTO [Evault Netsuite].advanced.AllContracts
FROM
  [EVault NetSuite].dbo.V__NS_Hosted_Contract_SKU con WITH (NOLOCK)
UNION
SELECT
  'Contracts-SaaS Historical' as Source
 ,Contract_ID
 ,Contract_Line_ID
 ,Contract_Name
 ,Contract_Line_Name
 ,Sales_Order_ID
 ,Transaction_Line_Unique_ID
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
 ,Order_Line_Transaction_Type
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
 ,Contracted_Unit_Rate_USD
 ,Overage_Rate
 ,Overage_Rate_USD
 ,Contracted_Amount
 ,Contracted_Monthly_Amount
 ,Contracted_Amount_USD
 ,Contracted_Monthly_Amount_USD
 ,Currency
 ,Original_List_Price
 ,Original_List_Price_USD
 ,Contracted_Discount
 ,Total_Discount
 ,Term_Month
 ,Billing_Frequency
 ,Superseded_By_ID
 ,Supersedes_ID
 ,Start_Date
 ,End_Date
 ,End_of_Term_Action
 ,Cancellation_Date
 ,Contract_Line_Status
FROM
  [EVault NetSuite].advanced.Contracts_SaaS_Historical
UNION
SELECT
 'SM Contracts'
 ,CAST(Contract_ID as VARCHAR(50)) as Contract_ID
 ,CAST(Contract_Line_ID as VARCHAR(50)) as Contract_Line_ID
 ,Contract_Name
 ,Contract_Line_Name
 ,CAST(NULL as FLOAT)
 ,CAST(NULL as NVARCHAR(4000))
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
 ,Order_Line_Transaction_Type
 ,Sales_Product_Group
 ,Sales_Product_Type
 ,Pricing_Group
 ,Product_Type
 ,Booking_Category
 ,Booking_Product_Group
 ,'YRR'
 ,Item
 ,Contract_Line_SFDC_ID
 ,SKU
 ,CAST(NULL as NVARCHAR(4000))
 ,Quantity
 ,Included_Usage_GB
 ,Calculated_Included_Usage_GB
 ,Contracted_Unit_Rate
 ,Contracted_Unit_Rate_USD
 ,CAST(NULL as FLOAT)
 ,CAST(NULL as FLOAT)
 ,Contracted_Amount
 ,Contracted_Amount / CASE WHEN DATEDIFF(month, Start_Date, End_Date) <= 0 THEN 1 ELSE DATEDIFF(month, Start_Date, End_Date) END
 ,Contracted_Amount_USD
 ,Contracted_Amount_USD / CASE WHEN DATEDIFF(month, Start_Date, End_Date) <= 0 THEN 1 ELSE DATEDIFF(month, Start_Date, End_Date) END
 ,Currency
 ,CAST(NULL as FLOAT)
 ,CAST(NULL as FLOAT)
 ,CAST(NULL as FLOAT)
 ,CAST(NULL as FLOAT)
 ,DATEDIFF(month, Start_Date, End_Date)
 ,NULL
 ,CAST(Superseded_By_ID as VARCHAR(50))
 ,CAST(Supersedes_ID as VARCHAR(50))
 ,Start_Date
 ,End_Date
 ,End_of_Term_Action
 ,Renew_Date
 ,Contract_Line_Status
FROM
  [EVault NetSuite].dbo.V__NS_SW_SM_Contract_Lines smcon WITH (NOLOCK)
UNION
SELECT
  'Contracts-SM Historical' as Source
 ,Contract_ID
 ,Contract_Line_ID
 ,Contract_Name
 ,Contract_Line_Name
 ,Sales_Order_ID
 ,Transaction_Line_Unique_ID
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
 ,Order_Line_Transaction_Type
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
 ,Contracted_Unit_Rate_USD
 ,Overage_Rate
 ,Overage_Rate_USD
 ,Contracted_Amount
 ,Contracted_Monthly_Amount
 ,Contracted_Amount_USD
 ,Contracted_Monthly_Amount_USD
 ,Currency
 ,Original_List_Price
 ,Original_List_Price_USD
 ,Contracted_Discount
 ,Total_Discount
 ,Term_Month
 ,Billing_Frequency
 ,Superseded_By_ID
 ,Supersedes_ID
 ,Start_Date
 ,End_Date
 ,End_of_Term_Action
 ,Renew_Date
 ,Contract_Line_Status
FROM
  [EVault NetSuite].advanced.Contracts_SM_Historical