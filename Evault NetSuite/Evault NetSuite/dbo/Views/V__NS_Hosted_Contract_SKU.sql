

CREATE VIEW [dbo].[V__NS_Hosted_Contract_SKU] AS

SELECT
	[c].[CONTRACT_ID] [Contract_ID]
,	[cl].[CONTRACT_LINE_ID] [Contract_Line_ID]
,	[cl].[ORIGINAL_NS_CL_ID] [Original_NS_CL_ID]
,	[c].[CONTRACT_NAME] [Contract_Name]
,	[cl].[CONTRACT_LINE_NAME] [Contract_Line_Name]
,	[cl].[BILLING_ID] [Contract_Line_Billing_ID]

,	[cl].[SALES_ORDER_ID] [Sales_Order_ID]
,	[cl].[TRANSACTION_LINE_UNIQUE_ID] [Transaction_Line_Unique_ID]

,	[customer].[COMPANYNAME] [Customer]
,	[reseller].[COMPANYNAME] [Reseller]
,	[end_user].[COMPANYNAME] [End_User]
,	[customer].[CUSTOMER_ID] [Customer_ID]
,	[reseller].[CUSTOMER_ID] [Reseller_ID]
,	[end_user].[CUSTOMER_ID] [End_User_ID]
,	[customer].[SALESFORCE_ID] [Customer_SFDC_ID]
,	[reseller].[SALESFORCE_ID] [Reseller_SFDC_ID]
,	[end_user].[SALESFORCE_ID] [End_User_SFDC_ID]
,	[customer].[Name] [Customer_NS_Number]
,	[reseller].[Name] [Reseller_NS_Number]
,	[end_user].[Name] [End_User_NS_Number]

,	COALESCE([end_user].[COMPANYNAME], [customer].[COMPANYNAME]) [Customer_End_User]
,	COALESCE([end_user].[CUSTOMER_ID], [customer].[CUSTOMER_ID]) [Customer_End_User_ID]
,	COALESCE([end_user].[SALESFORCE_ID], [customer].[SALESFORCE_ID]) [Customer_End_User_SFDC_ID]
,	COALESCE([end_user].[NAME], [customer].[NAME]) [Customer_End_User_NS_Number]

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

,	[spg].[LIST_ITEM_NAME] [Sales_Product_Group]
,	[spt].[LIST_ITEM_NAME] [Sales_Product_Type]
,	[pg].[NAME] [Pricing_Group]
,	[pt].[LIST_ITEM_NAME] [Product_Type]
,	[bc].[LIST_ITEM_NAME] [Booking_Category]
,	[bpg].[LIST_ITEM_NAME] [Booking_Product_Group]

,	[tc].[LIST_ITEM_NAME] [TAV_Category]
,	[i].[DISPLAYNAME] [Item]
,	[cl_sfdc].[Id] [Contract_Line_SFDC_ID]
,	[i].[PRODUCTCODESKU] [SKU]
,	[cl].[STORAGE_TYPE] [Storage_Type]


,	[cl].[CONTRACT_ORDER_QUANTITY] [Quantity]
,	[cl].[INCLUDED_USAGE] [Included_Usage_GB]
,	[cl].[CALCULATED_INCLUDED_STORAGE] [Calculated_Included_Usage_GB]

,	[cl].[RATE] [Contracted_Unit_Rate]
,	CAST([cl].[RATE] / [cer].[Exchange_Rate] AS NUMERIC(15,2)) [Contracted_Unit_Rate_USD]

,	[cl].[OVERAGE_RATE_NET] [Overage_Rate]
,	CAST([cl].[OVERAGE_RATE_NET] / [cer].[Exchange_Rate] AS NUMERIC(16,2)) [Overage_Rate_USD]

,	[cl].[AMOUNT] [Contracted_Amount]
,	CASE
		WHEN [bf].[CONTRACT_BILLING_FREQ_NAME]='Monthly' THEN [cl].[AMOUNT]
		WHEN [bf].[CONTRACT_BILLING_FREQ_NAME]='Quarterly' THEN [cl].[AMOUNT]/3
		WHEN [bf].[CONTRACT_BILLING_FREQ_NAME]='Annually' OR [bf].[CONTRACT_BILLING_FREQ_NAME]='Paid In Full' THEN [cl].[AMOUNT]/DATEDIFF(MONTH, [cl].[START_DATE], [cl].[END_DATE])
		ELSE -1
	END [Contracted_Monthly_Amount]

,	CAST([cl].[AMOUNT] / [cer].[Exchange_Rate] AS NUMERIC(15,2)) [Contracted_Amount_USD]

,	CASE
		WHEN [bf].[CONTRACT_BILLING_FREQ_NAME]='Monthly' THEN CAST([cl].[AMOUNT] / [cer].[Exchange_Rate] AS NUMERIC(15,2))
		WHEN [bf].[CONTRACT_BILLING_FREQ_NAME]='Quarterly' THEN CAST([cl].[AMOUNT] / [cer].[Exchange_Rate] AS NUMERIC(15,2))/3
		WHEN [bf].[CONTRACT_BILLING_FREQ_NAME]='Annually' OR [bf].[CONTRACT_BILLING_FREQ_NAME]='Paid In Full' THEN CAST([cl].[AMOUNT] / [cer].[Exchange_Rate] AS NUMERIC(15,2))/DATEDIFF(MONTH, [cl].[START_DATE], [cl].[END_DATE])
		ELSE -1
	END [Contracted_Monthly_Amount_USD]



,	[currency].[SYMBOL] [Currency]

,	[cl].[ORIGINAL_LIST_PRICE] [Original_List_Price]
,	CAST([cl].[ORIGINAL_LIST_PRICE] / [cer].[Exchange_Rate] AS NUMERIC(15,2)) [Original_List_Price_USD]
,	[cl].[CONTRACTED_DISCOUNT] [Contracted_Discount]
,	[cl].[TOTAL_DISCOUNT] [Total_Discount]




,	COALESCE([so_tl].[ORIGINAL_LIST_PRICE], [previous_cl_so_tl].[ORIGINAL_LIST_PRICE]) [so__Original_List_Price]
,	CAST(COALESCE([so_tl].[ORIGINAL_LIST_PRICE], [previous_cl_so_tl].[ORIGINAL_LIST_PRICE]) / [cer].[Exchange_Rate] AS NUMERIC(15,2)) [so__Original_List_Price_USD]
,	COALESCE([so_tl].[CONTRACTED_DISCOUNT], [previous_cl_so_tl].[CONTRACTED_DISCOUNT]) [so__Contracted_Discount]
,	COALESCE([so_tl].[TOTAL_DISCOUNT], [previous_cl_so_tl].[TOTAL_DISCOUNT]) [so__Total_Discount]


,	[cl].[CONTRACT_TERM_MONTHS] [Term_Month]
,	[eota].[LIST_ITEM_NAME] [End_of_Term_Action]
,	[bf].[CONTRACT_BILLING_FREQ_NAME] [Billing_Frequency]

,	[cl].[SUPERSEDED_BY_ID] [Superseded_By_ID]
,	[cl].[SUPERSEDES_ID] [Supersedes_ID]

,	CAST([cl].[START_DATE] AS DATE) [Start_Date]
,	CAST([cl].[END_DATE] AS DATE) [End_Date]
,	CAST([cl].[CANCELLATION_DATE] AS DATE) [Cancellation_Date]

,	[cls].[LIST_ITEM_NAME] [Contract_Line_Status]


FROM [dbo].[NSCARB_contract] [c] WITH (NOLOCK)
LEFT OUTER JOIN [dbo].[NSCARB_contract_line] [cl] WITH (NOLOCK) ON [cl].[CONTRACT_ID] = [c].[CONTRACT_ID]
LEFT OUTER JOIN [dbo].[NSCARB_contract_line_status] [cls] WITH (NOLOCK) ON [cls].[LIST_ID] = [cl].[STATUS_ID]

LEFT OUTER JOIN [Evault SFDC].[dbo].[EV_SF_CONTRACT_LINE_ITEM__C] [cl_sfdc] WITH (NOLOCK) ON [cl_sfdc].[NS_Contract_line_ID__c]=[cl].[CONTRACT_LINE_ID]

LEFT OUTER JOIN [dbo].[NSCARB_currencies] [currency] WITH (NOLOCK) ON [currency].[CURRENCY_ID] = [c].[CURRENCY_ID]
LEFT OUTER JOIN [dbo].[NSCARB_items] [i] WITH (NOLOCK) ON [i].[ITEM_ID] = [cl].[ITEM_ID]

LEFT OUTER JOIN [dbo].[NSCARB_order_line_transaction_type] [oltt] WITH (NOLOCK) ON [oltt].[LIST_ID] = [cl].[ORDER_LINE_TRANSACTION_TYPE_ID]

LEFT OUTER JOIN [dbo].[NSCARB_sales_product_group] [spg] WITH (NOLOCK) ON [spg].[LIST_ID] = [i].[SALES_PRODUCT_GROUP_ID]
LEFT OUTER JOIN [dbo].[NSCARB_sales_product_type] [spt] WITH (NOLOCK) ON [spt].[LIST_ID] = [i].[SALES_PRODUCT_TYPE_ID]
LEFT OUTER JOIN [dbo].[NSCARB_pricing_groups] [pg] WITH (NOLOCK) ON [pg].[PRICING_GROUP_ID] = [i].[PRICING_GROUP_ID]
LEFT OUTER JOIN [dbo].[NSCARB_product_type] [pt] WITH (NOLOCK) ON [pt].[LIST_ID] = [i].[PRODUCT_TYPE_ID]
LEFT OUTER JOIN [dbo].[NSCARB_booking_category] [bc] WITH (NOLOCK) ON [bc].[LIST_ID] = [i].[BOOKING_CATEGORY_ID]
LEFT OUTER JOIN [dbo].[NSCARB_booking_product_group] [bpg] WITH (NOLOCK) ON [bpg].[LIST_ID] = [i].[BOOKING_PRODUCT_GROUP_ID]



LEFT OUTER JOIN [dbo].[NSCARB_tav_category] [tc] WITH (NOLOCK) ON [tc].[LIST_ID] = [i].[TAV_CATEGORY_ID]

LEFT OUTER JOIN [dbo].[NSCARB_contract_endofterm_action] [eota] WITH (NOLOCK) ON [eota].[LIST_ID] = [cl].[ENDOFTERM_ACTION_ID]
LEFT OUTER JOIN [dbo].[NSCARB_contract_billing_freq] [bf] WITH (NOLOCK) ON [bf].[CONTRACT_BILLING_FREQ_ID] = [cl].[BILLING_FREQ_ID]

LEFT OUTER JOIN [dbo].[NSCARB_customers] [customer] WITH (NOLOCK) ON [customer].[CUSTOMER_ID] = [cl].[CUSTOMER_ID]
LEFT OUTER JOIN [dbo].[NSCARB_customers] [reseller] WITH (NOLOCK) ON [reseller].[CUSTOMER_ID] = [cl].[RESELLER_ID]
LEFT OUTER JOIN [dbo].[NSCARB_customers] [end_user] WITH (NOLOCK) ON [end_user].[CUSTOMER_ID] = [cl].[END_USER_ID]

LEFT OUTER JOIN [Evault SFDC].[dbo].[EV_SF_Account] [sfdc_end_user] WITH (NOLOCK) ON [sfdc_end_user].[Id] = COALESCE([end_user].[SALESFORCE_ID], [customer].[SALESFORCE_ID])
LEFT OUTER JOIN [Evault SFDC].[dbo].[EV_SF_Account] [sfdc_customer] WITH (NOLOCK) ON [sfdc_customer].[Id] = [customer].[SALESFORCE_ID]


LEFT OUTER JOIN [dbo].[V__Current_Currency_Exchange_Rates_2] [cer] WITH (NOLOCK) ON [cer].[CurrencyIsoCode] = [currency].[SYMBOL]

LEFT OUTER JOIN [dbo].[NSCARB_TRANSACTION_LINES] [so_tl] WITH (NOLOCK) ON [so_tl].[TRANSACTION_LINE_UNIQUE_ID] = [cl].[TRANSACTION_LINE_UNIQUE_ID] AND [so_tl].[TRANSACTION_ID] = [cl].[SALES_ORDER_ID]

LEFT OUTER JOIN [dbo].[NSCARB_CONTRACT_LINE] [previous_cl] WITH (NOLOCK) ON [cl].[SALES_ORDER_ID] IS NULL AND [previous_cl].[CONTRACT_LINE_ID] = [cl].[SUPERSEDES_ID]
LEFT OUTER JOIN [dbo].[NSCARB_TRANSACTION_LINES] [previous_cl_so_tl] WITH (NOLOCK) ON [previous_cl_so_tl].[TRANSACTION_LINE_UNIQUE_ID] = [previous_cl].[TRANSACTION_LINE_UNIQUE_ID] AND [previous_cl_so_tl].[TRANSACTION_ID] = [previous_cl].[SALES_ORDER_ID]


WHERE 1=1

-- gets Hosted contract lines only
AND ([cl].[PRODUCT_TYPE]='subscription' OR [cl].[CONTRACT_ITEM_TYPE_ID]=3)
AND [tc].[LIST_ITEM_NAME] IN ('MRR', 'YRR')
AND [bpg].[LIST_ITEM_NAME] NOT IN ('CCSP')








