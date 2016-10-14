
CREATE VIEW [dbo].[V__NS_SW_SM_Contract_Lines] AS


SELECT

 [c].[CONTRACT_ID] [Contract_ID]
, [cl].[CONTRACT_LINE_ID] [Contract_Line_ID]

, [c].[CONTRACT_NAME] [Contract_Name]
, [cl].[CONTRACT_LINE_NAME] [Contract_Line_Name]

, [cls].[LIST_ITEM_NAME] [Contract_Line_Status]

, [customer].[COMPANYNAME] [Customer]
, [reseller].[COMPANYNAME] [Reseller]
, [end_user].[COMPANYNAME] [End_User]
, COALESCE([End_User].[COMPANYNAME], [customer].[COMPANYNAME]) [Customer_End_User]

, [customer].[CUSTOMER_ID] [Customer_ID]
, [reseller].[CUSTOMER_ID] [Reseller_ID]
, [end_user].[CUSTOMER_ID] [End_User_ID]
, COALESCE([End_User].[CUSTOMER_ID], [customer].[CUSTOMER_ID]) [Customer_End_User_ID]

, [customer].[SALESFORCE_ID] [Customer_SFDC_ID]
, [reseller].[SALESFORCE_ID] [Reseller_SFDC_ID]
, [end_user].[SALESFORCE_ID] [End_User_SFDC_ID]
, COALESCE([End_User].[SALESFORCE_ID], [customer].[SALESFORCE_ID]) [Customer_End_User_SFDC_ID]

, [customer].[NAME] [Customer_NS_Number]
, [reseller].[NAME] [Reseller_NS_Number]
, [end_user].[NAME] [End_User_NS_Number]
, COALESCE([End_User].[NAME], [customer].[NAME]) [Customer_End_User_NS_Number]



,	CASE
		WHEN [end_user].[CUSTOMER_ID] IS NULL THEN
			'Direct'
		WHEN [end_user].[CUSTOMER_ID] = [customer].[CUSTOMER_ID] THEN -- this scenario is rare.
			'Direct'
		WHEN [end_user].[CUSTOMER_ID] IS NOT NULL AND [reseller].[CUSTOMER_ID] IS NOT NULL AND [reseller].[CUSTOMER_ID]<>[end_user].[CUSTOMER_ID] AND [reseller].[CUSTOMER_ID]=[customer].[CUSTOMER_ID] THEN
			'Indirect'
		WHEN [end_user].[CUSTOMER_ID] IS NOT NULL AND [reseller].[CUSTOMER_ID] IS NOT NULL AND [reseller].[CUSTOMER_ID] <> [end_user].[CUSTOMER_ID] AND [reseller].[CUSTOMER_ID]<>[customer].[CUSTOMER_ID] AND [customer].[CUSTOMER_ID] <> [end_user].[CUSTOMER_ID] THEN
			'Distributor'
		WHEN [end_user].[CUSTOMER_ID] IS NOT NULL AND [reseller].[CUSTOMER_ID] IS NOT NULL AND [end_user].[CUSTOMER_ID] = [reseller].[CUSTOMER_ID] AND [reseller].[CUSTOMER_ID]<>[customer].[CUSTOMER_ID] THEN
			'Distributor without Reseller'
		WHEN [end_user].[CUSTOMER_ID] IS NOT NULL AND [reseller].[CUSTOMER_ID] IS NULL AND [end_user].[CUSTOMER_ID]<>[customer].[CUSTOMER_ID] THEN
			'Distributor without Reseller'
		ELSE
			'Unknown'
	END [Direct_Indirect_Distributor]

,	CAST([sfdc_end_user].[Contract_Date__c] AS DATE) [Initial_Contract_Date]

,	[sfdc_customer].[TYPE] [Customer_Account_Type]

,	[oltt].[LIST_ITEM_NAME] [Order_Line_Transaction_Type]




, [spg].[LIST_ITEM_NAME] [Sales_Product_Group]
, [spt].[LIST_ITEM_NAME] [Sales_Product_Type]
, [pg].[NAME] [Pricing_Group]
, [pt].[LIST_ITEM_NAME] [Product_Type]
, [bc].[LIST_ITEM_NAME] [Booking_Category]
, [bpg].[LIST_ITEM_NAME] [Booking_Product_Group]

, [cl].[PRODUCT_TYPE] [Contract_Line_Product_Type]


, [related_i].[DISPLAYNAME] [Item]
, [cl_sfdc].[Id] [Contract_Line_SFDC_ID]
, [related_i].[PRODUCTCODESKU] [SKU]

, [cl].[QTY] [Quantity]
, [cl].[INCLUDED_USAGE] [Included_Usage_GB]
, [cl].[CALCULATED_INCLUDED_STORAGE] [Calculated_Included_Usage_GB]

, [cl].[RATE] [Contracted_Unit_Rate]
, CAST([cl].[RATE] * [cer].[Exchange_Rate] AS NUMERIC(15,2)) [Contracted_Unit_Rate_USD]
, [cl].[AMOUNT] [Contracted_Amount]
, CAST([cl].[AMOUNT] * [cer].[Exchange_Rate] AS NUMERIC(15,2)) [Contracted_Amount_USD]

, [cl].[MONTHLY_VALUE] [Monthly_Value]
, [cl].[QUARTERLY_VALUE] [Quarterly_Value]
, [cl].[SEMIANNUAL_VALUE] [Semiannual_Value]
, [cl].[ANNUAL_VALUE] [Annual_Value]
, [currency].[SYMBOL] [Currency]

,	[cl].[SUPERSEDED_BY_ID] [Superseded_By_ID]
,	[cl].[SUPERSEDES_ID] [Supersedes_ID]

, [cl].[START_DATE] [Start_Date]
, [cl].[END_DATE] [End_Date]
, [cl].[RENEW_DATE] [Renew_Date]
, [cl].[CONTRACT_TERM_MONTHS] [Term_Month]
, [eota].[LIST_ITEM_NAME] [End_of_Term_Action]


FROM [dbo].[NSCARB_contract] [c]
LEFT OUTER JOIN [dbo].[NSCARB_contract_line] [cl] ON [cl].[CONTRACT_ID] = [c].[CONTRACT_ID] --AND [cl].[CUSTOMER_ID] = [c].[CUSTOMER_ID]
LEFT OUTER JOIN [dbo].[NSCARB_contract_line_status] [cls] ON [cls].[LIST_ID] = [cl].[STATUS_ID]
LEFT OUTER JOIN [dbo].[NSCARB_ORDER_LINE_TRANSACTION_TYPE] [oltt] WITH (NOLOCK) ON [oltt].[LIST_ID] = [cl].[ORDER_LINE_TRANSACTION_TYPE_ID]

LEFT OUTER JOIN [Evault SFDC].dbo.[EV_SF_CONTRACT_LINE_ITEM__C] [cl_sfdc] WITH (NOLOCK) ON [cl_sfdc].[NS_Contract_line_ID__c]=[cl].[CONTRACT_LINE_ID]

LEFT OUTER JOIN [dbo].[NSCARB_items] [related_i] WITH (NOLOCK) ON [related_i].[ITEM_ID] = [cl].[RELATED_SWAPPLIANCE_ITEM_ID]

LEFT OUTER JOIN [dbo].[NSCARB_sales_product_group] [spg] WITH (NOLOCK) ON [spg].[LIST_ID] = [related_i].[SALES_PRODUCT_GROUP_ID]
LEFT OUTER JOIN [dbo].[NSCARB_sales_product_type] [spt] WITH (NOLOCK) ON [spt].[LIST_ID] = [related_i].[SALES_PRODUCT_TYPE_ID]
LEFT OUTER JOIN [dbo].[NSCARB_pricing_groups] [pg] WITH (NOLOCK) ON [pg].[PRICING_GROUP_ID] = [related_i].[PRICING_GROUP_ID]
LEFT OUTER JOIN [dbo].[NSCARB_product_type] [pt] WITH (NOLOCK) ON [pt].[LIST_ID] = [related_i].[PRODUCT_TYPE_ID]
LEFT OUTER JOIN [dbo].[NSCARB_booking_category] [bc] WITH (NOLOCK) ON [bc].[LIST_ID] = [related_i].[BOOKING_CATEGORY_ID]
LEFT OUTER JOIN [dbo].[NSCARB_booking_product_group] [bpg] WITH (NOLOCK) ON [bpg].[LIST_ID] = [related_i].[BOOKING_PRODUCT_GROUP_ID]



LEFT OUTER JOIN [dbo].[NSCARB_tav_category] [tc] WITH (NOLOCK) ON [tc].[LIST_ID] = [related_i].[TAV_CATEGORY_ID]


LEFT OUTER JOIN [dbo].[NSCARB_contract_endofterm_action] [eota] WITH (NOLOCK) ON [eota].[LIST_ID] = [cl].[ENDOFTERM_ACTION_ID]

LEFT OUTER JOIN [dbo].[NSCARB_currencies] [currency] WITH (NOLOCK) ON [currency].[CURRENCY_ID] = [c].[CURRENCY_ID]
LEFT OUTER JOIN [dbo].[V__Current_Currency_Exchange_Rates_2] [cer] ON [cer].[CurrencyIsoCode] = [currency].[SYMBOL]

LEFT OUTER JOIN [dbo].[NSCARB_customers] [end_user] ON [end_user].[CUSTOMER_ID] = [cl].[END_USER_ID]
LEFT OUTER JOIN [dbo].[NSCARB_customers] [reseller] ON [reseller].[CUSTOMER_ID] = [cl].[RESELLER_ID]
LEFT OUTER JOIN [dbo].[NSCARB_customers] [customer] ON [customer].[CUSTOMER_ID] = [cl].[CUSTOMER_ID]

LEFT OUTER JOIN [Evault SFDC].[dbo].[EV_SF_Account] [sfdc_end_user] WITH (NOLOCK) ON [sfdc_end_user].[ID] = COALESCE([End_User].[SALESFORCE_ID], [customer].[SALESFORCE_ID])
LEFT OUTER JOIN [Evault SFDC].[dbo].[EV_SF_Account] [sfdc_customer] WITH (NOLOCK) ON [sfdc_customer].[Id] = [customer].[SALESFORCE_ID]


-- these are legacy seagate fiscal months. no longer needed for carbonite.
--LEFT OUTER JOIN [dbo].[CEM_MRR_Fiscal_Month_Start_End_Dates] [fc_start_date] WITH (NOLOCK) ON [cl].[START_DATE] BETWEEN [fc_start_date].[FM Start Date] AND [fc_start_date].[FM End Date]
--LEFT OUTER JOIN [dbo].[CEM_MRR_Fiscal_Month_Start_End_Dates] [fc_end_date] WITH (NOLOCK) ON [cl].[END_DATE] BETWEEN [fc_end_date].[FM Start Date] AND [fc_end_date].[FM End Date]



WHERE 1=1
AND ([cl].[PRODUCT_TYPE]='support and maintenance' OR [cl].[CONTRACT_ITEM_TYPE_ID]=2)













