
CREATE VIEW [dbo].[V__NS_Sales_Order_Line_Items_With_CL] AS


SELECT
	[t].[TRANSACTION_NUMBER] [Transaction_Number]
,	[t].[TRANID] [Sales_Order_No]
,	[t].[TRANSACTION_ID] [Transaction_ID]
,	[t].[ORIGINALDEBOOKING_NS_ORDER_ID] [Original_Booking_or_Debooking_ID]
,	[tl].[TRANSACTION_LINE_UNIQUE_ID] [Transaction_Line_Unique_ID]
,	[tl].[SALESFORCE_QUOTE_LINE_ID] [Salesforce_Quote_Line_ID]
,	[opp].[Id] [Salesforce_Opp_ID]
,	[opp_owner].[Name] [Opp_Owner]
,	[ot].[LIST_ITEM_NAME] [Order_Type]
,	[dt].[LIST_ITEM_NAME] [Deal_Type]
,	[t].[STATUS] [Sales_Order_Status]
,	[tl_oltt].[LIST_ITEM_NAME] [Order_Line_Transaction_Type]

,	[t].[MEMO] [Transaction_Memo]

,	[t].[MID_TIER_TICKET_ID_H] [Mid_Tier_Ticket_ID_H]

,	[tl].[BILLING_ID] [Transaction_Line_Billing_ID]
,	[tl].[TRANSACTION_LINE_ID] [Transaction_Line_ID]

,	[tl].[MID_TIER_TICKET_ID_L] [Mid_Tier_Ticket_ID_L]

,	CASE [t].[MSP_AGREEMENT] WHEN 'F' THEN 'No' WHEN 'T' THEN 'Yes' END [MSP_Agreement]
,	[t].[CREATE_DATE] [Created_Date]
,	CAST([t].[TRANDATE] AS DATE) [Tran_Date]
,	CAST([t].[SALES_EFFECTIVE_DATE] AS DATE) [Sales_Effective_Date]



,	[customer].[COMPANYNAME] [Customer]
,	[customer].[CUSTOMER_ID] [Customer_ID]
,	[customer].[NAME] [Customer_Number]
,	[customer].[SALESFORCE_ID] [Customer_SFDC_ID]

,	[reseller].[COMPANYNAME] [Reseller]
,	[reseller].[CUSTOMER_ID] [Reseller_ID]
,	[reseller].[NAME] [Reseller_Number]
,	[reseller].[SALESFORCE_ID] [Reseller_SFDC_ID]

,	[end user].[COMPANYNAME] [End_User]
,	[end user].[CUSTOMER_ID] [End_User_ID]
,	[end user].[NAME] [End_User_Number]
,	[end user].[SALESFORCE_ID] [End_User_SFDC_ID]

,	COALESCE([end user].[COMPANYNAME], [customer].[COMPANYNAME]) [Customer_End_User]
,	COALESCE([end user].[CUSTOMER_ID], [customer].[CUSTOMER_ID]) [Customer_End_User_ID]
,	COALESCE([end user].[SALESFORCE_ID], [customer].[SALESFORCE_ID]) [Customer_End_User_SFDC_ID]
,	COALESCE([end user].[NAME], [customer].[NAME]) [Customer_End_User_NS_Number]

,	[sfdc_end_user].[Owner_Sales_Org__c] [Owner_Sales_Org]
,	[sfdc_end_user].[Contract_Date__c] [Customer/End User Initial Contract Date]
,	[sfdc_end_user].[Industry] [Industry]
,	[sfdc_end_user].[AnnualRevenue] [Annual_Revenue]
,	[sfdc_end_user].[NumberOfEmployees] [Employee_Count]
,	[sfdc_end_user].[NAICS_Code__c] [NAICS]
,	ISNULL([sfdc_end_user].[GEO__c], CASE WHEN COALESCE([sfdc_end_user].[BillingCountry],[sfdc_end_user].[ShippingCountry])='United States' THEN 'North America' ELSE NULL END) [Geo]

,	[sub].[DIVISION_NUMBER] [Division_Number]
,	[sub].[NAME] [Division_Name]

,	[subsidiary_currency].[SYMBOL] [Division_Currency]
,	[booking_currency].[SYMBOL] [Booking_Currency]

,	[i].[NAME] [Booking_Item]
,	[i].[ITEM_ID] [Booking_Item_ID]
,	[i].[PRODUCTCODESKU] [SKU]

,	[spg].[LIST_ITEM_NAME] [Sales_Product_Group]
,	[spt].[LIST_ITEM_NAME] [Sales_Product_Type]
,	[pg].[NAME] [Pricing_Group]
,	[pt].[LIST_ITEM_NAME] [Product_Type]
,	[bc].[LIST_ITEM_NAME] [Booking_Category]
,	[bpg].[LIST_ITEM_NAME] [Booking_Product_Group]

,	[tl].[START_DATE] [Start_Date]
,	[tl].[END_DATE] [End_Date]
,	[tl].[TERM_IN_MONTHS] [Term_In_Months]

,	0-[tl].[ITEM_COUNT] [Quantity]
,	[tl].[CUSTOM_QUANTITY] [Contract_Order_Quantity]
,	[tl].[INCLUDED_USAGE] [Included_Usage]
,	CASE WHEN [ot].[LIST_ITEM_NAME] = 'debooking' THEN 0-[tl].[CALCULATED_INCLUDED_STORAGE] ELSE [tl].[CALCULATED_INCLUDED_STORAGE] END [Calculated_Included_Storage]

,	[tl].[ITEM_UNIT_PRICE] [Item_Unit_Price]


,	CASE WHEN ISNULL([tl_oltt].[LIST_ITEM_NAME],'') IN ('cancellation','cancelation','debooking') THEN [tl].[AMOUNT] ELSE 0-[tl].[AMOUNT] END [Amount_in_Division_Currency]
,	CASE WHEN ISNULL([tl_oltt].[LIST_ITEM_NAME],'') IN ('cancellation','cancelation','debooking') THEN [tl].[AMOUNT_FOREIGN] ELSE 0-[tl].[AMOUNT_FOREIGN] END [Amount_in_Booking_Currency]
,	CASE WHEN ISNULL([tl_oltt].[LIST_ITEM_NAME],'') IN ('cancellation','cancelation','debooking') THEN CAST([tl].[AMOUNT]*[cer].[CURRENT_RATE] AS NUMERIC(15,2)) ELSE CAST((0-[tl].[AMOUNT])*[cer].[CURRENT_RATE] AS NUMERIC(15,2)) END [Amount_USD]

,	[cer].[CURRENT_RATE] [Exchange_Rate]

,	[booking_cbf].[CONTRACT_BILLING_FREQ_NAME] [Booking_Billing_Frequency]
,	[tl].[LIST_PRICE] [List_Price]
,	[tl].[ORIGINAL_LIST_PRICE] [Original_List_Price]
,	[tl].[CONTRACTED_DISCOUNT] [Contracted_Discount]
,	[tl].[TOTAL_DISCOUNT] [Total_Discount]

,	[q].[Request_Type__c] [SFDC_Quote_Request_Type]
,	[q].[Escalation_Reason_Code__c] [SFDC_Quote_Escalation_Reason_Code]
,	[q].[Escalation_Reason_Description__c] [SFDC_Quote_Escalation_Reason_Description]

,	CASE [tl].[CONTRACT_ITEM] WHEN 'F' THEN 'No' WHEN 'T' THEN 'Yes' END [Contract_Item]

,	CASE WHEN ISNULL([tl_oltt].[LIST_ITEM_NAME],'') IN ('cancellation','cancelation','debooking') THEN 0-[tl].[LINE_ITEM_TAV] ELSE [tl].[LINE_ITEM_TAV] END [TAV]
,	CASE WHEN ISNULL([tl_oltt].[LIST_ITEM_NAME],'') IN ('cancellation','cancelation','debooking') THEN 0-CAST([tl].[LINE_ITEM_TAV]*[t].[EXCHANGE_RATE]*[cer].[CURRENT_RATE] AS NUMERIC(15,2)) ELSE CAST([tl].[LINE_ITEM_TAV]*[t].[EXCHANGE_RATE]*[cer].[CURRENT_RATE] AS NUMERIC(15,2)) END [TAV_USD]
,	CASE WHEN ISNULL([tl_oltt].[LIST_ITEM_NAME],'') IN ('cancellation','cancelation','debooking') THEN 0-[tl].[LINE_ITEM_TCV] ELSE [tl].[LINE_ITEM_TCV] END [TCV]
,	CASE WHEN ISNULL([tl_oltt].[LIST_ITEM_NAME],'') IN ('cancellation','cancelation','debooking') THEN 0-CAST([tl].[LINE_ITEM_TCV]*[t].[EXCHANGE_RATE]*[cer].[CURRENT_RATE] AS NUMERIC(15,2)) ELSE CAST([tl].[LINE_ITEM_TCV]*[t].[EXCHANGE_RATE]*[cer].[CURRENT_RATE] AS NUMERIC(15,2)) END [TCV_USD]

,	[booking_cl].[CONTRACT_LINE_ID] [Booking_CL_ID]
,	[booking_cl_oltt].[LIST_ITEM_NAME] [Booking_CL_Order_Line_Transaction_Type]
,	[booking_cl_i].[NAME] [Booking_CL_Item]
,	[booking_cl_i].[PRODUCTCODESKU] [Booking_CL_SKU]
,	[booking_cl_spg].[LIST_ITEM_NAME] [Booking_CL_Sales_Product_Group]
,	[booking_cl_spt].[LIST_ITEM_NAME] [Booking_CL_Sales_Product_Type]
,	[booking_cl_pg].[NAME] [Booking_CL_Pricing_Group]
,	[booking_cl_pt].[LIST_ITEM_NAME] [Booking_CL_Product_Type]
,	[booking_cl_bc].[LIST_ITEM_NAME] [Booking_CL_Booking_Category]
,	[booking_cl_bpg].[LIST_ITEM_NAME] [Booking_CL_Booking_Product_Group]
,	[booking_cls].[LIST_ITEM_NAME] [Booking_CL_Status]

,	[booking_cl].[CONTRACT_ORDER_QUANTITY] [Booking_CL_Quantity]
,	[booking_cl].[RATE] [Booking_CL_Rate]
,	[booking_cl].[AMOUNT] [Booking_CL_Amount]
--,	CAST(ROUND([booking_cl].[AMOUNT]*[booking_cl_ex_rate].[Exchange Rate],2) AS FLOAT) [Booking_CL_Amount_USD]
,	[booking_cl_cbf].[CONTRACT_BILLING_FREQ_NAME] [Booking_CL_Contract_Billing_Frequency]
,	[booking_cl_eota].[LIST_ITEM_NAME] [Booking_CL_End_Of_Term_Action]
,	[booking_cl_currency].[SYMBOL] [Booking_CL_Currency]
,	[booking_cl].[INCLUDED_USAGE] [Booking_CL_Included_Usage]
,	[booking_cl].[CALCULATED_INCLUDED_STORAGE] [Booking_CL_Calculated_Included_Storage]
,	CAST([booking_cl].[START_DATE] AS DATE) [Booking_CL_Start_Date]
,	CAST([booking_cl].[END_DATE] AS DATE) [Booking_CL_End_Date]

,	[booking_cl].[CONTRACT_TERM_MONTHS] [Booking_CL_Term_Month]
,	CAST([booking_cl].[CANCELLATION_DATE] AS DATE) [Booking_CL_Cancellation_Date]


,	[old_cl].[CONTRACT_LINE_ID] [Old_CL_ID]
,	[old_cl_oltt].[LIST_ITEM_NAME] [Old_CL_Order_Line_Transaction_Type]
,	[old_cl_i].[NAME] [Old_CL_Item]
,	[old_cl_i].[PRODUCTCODESKU] [Old_CL_SKU]
,	[old_cl_spg].[LIST_ITEM_NAME] [Old_CL_Sales_Product_Group]
,	[old_cl_spt].[LIST_ITEM_NAME] [Old_CL_Sales_Product_Type]
,	[old_cl_pg].[NAME] [Old_CL_Pricing_Group]
,	[old_cl_pt].[LIST_ITEM_NAME] [Old_CL_Product_Type]
,	[old_cl_bc].[LIST_ITEM_NAME] [Old_CL_Booking_Category]
,	[old_cl_bpg].[LIST_ITEM_NAME] [Old_CL_Booking_Product_Group]
,	[old_cls].[LIST_ITEM_NAME] [Old_CL_Status]

,	[old_cl].[CONTRACT_ORDER_QUANTITY] [Old_CL_Quantity]
,	[old_cl].[RATE] [Old_CL_Rate]
,	[old_cl].[AMOUNT] [Old_CL_Amount]
--,	CAST(ROUND([old_cl].[AMOUNT]*[old_cl_ex_rate].[Exchange Rate],2) AS FLOAT) [Old_CL_Amount_USD]
,	[old_cl_cbf].[CONTRACT_BILLING_FREQ_NAME] [Old_CL_Contract_Billing_Frequency]
,	[old_cl_eota].[LIST_ITEM_NAME] [Old_CL_End_Of_Term_Action]
,	[old_cl_currency].[SYMBOL] [Old_CL_Currency]
,	[old_cl].[INCLUDED_USAGE] [Old_CL_Included_Usage]
,	[old_cl].[CALCULATED_INCLUDED_STORAGE] [Old_CL_Calculated_Included_Storage]
,	CAST([old_cl].[START_DATE] AS DATE) [Old_CL_Start_Date]
,	CAST([old_cl].[END_DATE] AS DATE) [Old_CL_End_Date]


,	[old_cl].[CONTRACT_TERM_MONTHS] [Old_CL_Term_Month]
,	CAST([old_cl].[CANCELLATION_DATE] AS DATE) [Old_CL_Cancellation_Date]



,	[new_cl].[CONTRACT_LINE_ID] [New_CL_ID]
,	[new_cl_oltt].[LIST_ITEM_NAME] [New_CL_Order_Line_Transaction_Type]
,	[new_cl_i].[NAME] [New_CL_Item]
,	[new_cl_i].[PRODUCTCODESKU] [New_CL_SKU]
,	[new_cl_spg].[LIST_ITEM_NAME] [New_CL_Sales_Product_Group]
,	[new_cl_spt].[LIST_ITEM_NAME] [New_CL_Sales_Product_Type]
,	[new_cl_pg].[NAME] [New_CL_Pricing_Group]
,	[new_cl_pt].[LIST_ITEM_NAME] [New_CL_Product_Type]
,	[new_cl_bc].[LIST_ITEM_NAME] [New_CL_Booking_Category]
,	[new_cl_bpg].[LIST_ITEM_NAME] [New_CL_Booking_Product_Group]
,	[new_cls].[LIST_ITEM_NAME] [New_CL_Status]

,	[new_cl].[CONTRACT_ORDER_QUANTITY] [New_CL_Quantity]
,	[new_cl].[RATE] [New_CL_Rate]
,	[new_cl].[AMOUNT] [New_CL_Amount]
--,	CAST(ROUND([new_cl].[AMOUNT]*[new_cl_ex_rate].[Exchange Rate],2) AS FLOAT) [New_CL_Amount_USD]
,	[new_cl_cbf].[CONTRACT_BILLING_FREQ_NAME] [New_CL_Contract_Billing_Frequency]
,	[new_cl_eota].[LIST_ITEM_NAME] [New_CL_End_Of_Term_Action]
,	[new_cl_currency].[SYMBOL] [New_CL_Currency]
,	[new_cl].[INCLUDED_USAGE] [New_CL_Included_Usage]
,	[new_cl].[CALCULATED_INCLUDED_STORAGE] [New_CL_Calculated_Included_Storage]
,	CAST([new_cl].[START_DATE] AS DATE) [New_CL_Start_Date]
,	CAST([new_cl].[END_DATE] AS DATE) [New_CL_End_Date]


,	[new_cl].[CONTRACT_TERM_MONTHS] [New_CL_Term_Month]
,	CAST([new_cl].[CANCELLATION_DATE] AS DATE) [New_CL_Cancellation_Date]

,	CAST([new_cl].[DATE_PROVISIONED] AS DATE) [New_CL_Date_Provisioned]


FROM [NSCARB_transactions] [t] WITH (NOLOCK)
LEFT OUTER JOIN [NSCARB_order_type] [ot] WITH (NOLOCK) ON [ot].[LIST_ID] = [t].[ORDER_TYPE_ID]
LEFT OUTER JOIN [NSCARB_deal_type] [dt] WITH (NOLOCK) ON [dt].[LIST_ID] = [t].[DEAL_TYPE_ID]

INNER JOIN [NSCARB_transaction_lines] [tl] WITH (NOLOCK) ON [tl].[TRANSACTION_ID] = [t].[TRANSACTION_ID]

INNER JOIN [NSCARB_subsidiaries] [sub] WITH (NOLOCK) ON [sub].[SUBSIDIARY_ID] = [tl].[SUBSIDIARY_ID]

INNER JOIN [NSCARB_currencies] [booking_currency] WITH (NOLOCK) ON [booking_currency].[CURRENCY_ID] = [t].[CURRENCY_ID]
INNER JOIN [NSCARB_currencies] [subsidiary_currency] WITH (NOLOCK) ON [subsidiary_currency].[CURRENCY_ID] = [sub].[BASE_CURRENCY_ID]

LEFT OUTER JOIN [Evault SFDC].dbo.[EV_SF_Quote] [q] WITH (NOLOCK) ON [q].[Netsuite_Order_Id__c] = [t].[TRANID] AND [q].[IsSyncing]=1
LEFT OUTER JOIN [Evault SFDC].dbo.[EV_SF_Opportunity] [opp] WITH (NOLOCK) ON [opp].[Id] = [q].[OpportunityId]
LEFT OUTER JOIN [Evault SFDC].dbo.[EV_SF_User] [opp_owner] WITH (NOLOCK) ON [opp_owner].[Id] = [opp].[OwnerId]


LEFT OUTER JOIN [NSCARB_customers] [customer] WITH (NOLOCK) ON [customer].[CUSTOMER_ID] = [t].[ENTITY_ID]
LEFT OUTER JOIN [NSCARB_customers] [reseller] WITH (NOLOCK) ON [reseller].[CUSTOMER_ID] = [t].[RESELLER_ID]
LEFT OUTER JOIN [NSCARB_customers] [end user] WITH (NOLOCK) ON [end user].[CUSTOMER_ID] = [tl].[END_USER_ID]

LEFT OUTER JOIN [Evault SFDC].dbo.[EV_SF_Account] [sfdc_end_user] WITH (NOLOCK) ON [sfdc_end_user].[Id] = COALESCE([end user].[SALESFORCE_ID], [customer].[SALESFORCE_ID])

INNER JOIN [NSCARB_items] [i] WITH (NOLOCK) ON [i].[ITEM_ID] = [tl].[ITEM_ID]
INNER JOIN [NSCARB_sales_product_group] [spg] WITH (NOLOCK) ON [spg].[LIST_ID] = [i].[SALES_PRODUCT_GROUP_ID]
INNER JOIN [NSCARB_sales_product_type] [spt] WITH (NOLOCK) ON [spt].[LIST_ID] = [i].[SALES_PRODUCT_TYPE_ID]
INNER JOIN [NSCARB_pricing_groups] [pg] WITH (NOLOCK) ON [pg].[PRICING_GROUP_ID] = [i].[PRICING_GROUP_ID]
INNER JOIN [NSCARB_product_type] [pt] WITH (NOLOCK) ON [pt].[LIST_ID] = [i].[PRODUCT_TYPE_ID]
INNER JOIN [NSCARB_booking_category] [bc] WITH (NOLOCK) ON [bc].[LIST_ID] = [i].[BOOKING_CATEGORY_ID]
INNER JOIN [NSCARB_booking_product_group] [bpg] WITH (NOLOCK) ON [bpg].[LIST_ID] = [i].[BOOKING_PRODUCT_GROUP_ID]

LEFT OUTER JOIN [NSCARB_contract_billing_freq] [booking_cbf] WITH (NOLOCK) ON [booking_cbf].[CONTRACT_BILLING_FREQ_ID] = [tl].[CONTRACT_BILLING_FREQ_ID]


LEFT OUTER JOIN [NSCARB_contract_line] [booking_cl] WITH (NOLOCK) ON [booking_cl].[TRANSACTION_LINE_UNIQUE_ID] = [tl].[TRANSACTION_LINE_UNIQUE_ID] AND [booking_cl].[SALES_ORDER_ID] = [tl].[TRANSACTION_ID]
LEFT OUTER JOIN [NSCARB_contract_line] [old_cl] WITH (NOLOCK) ON [old_cl].[CONTRACT_LINE_ID] = [tl].[CONTRACT_LINE_TO_SUPERSEDE_ID]
LEFT OUTER JOIN [NSCARB_contract_line] [new_cl] WITH (NOLOCK) ON [new_cl].[CONTRACT_LINE_ID] = [old_cl].[SUPERSEDED_BY_ID]


LEFT OUTER JOIN [NSCARB_contract] [booking_c] WITH (NOLOCK) ON [booking_c].[CONTRACT_ID] = [booking_cl].[CONTRACT_ID]
LEFT OUTER JOIN [NSCARB_contract] [old_c] WITH (NOLOCK) ON [old_c].[CONTRACT_ID] = [old_cl].[CONTRACT_ID]
LEFT OUTER JOIN [NSCARB_contract] [new_c] WITH (NOLOCK) ON [new_c].[CONTRACT_ID] = [new_cl].[CONTRACT_ID]

LEFT OUTER JOIN [NSCARB_items] [booking_cl_i] WITH (NOLOCK) ON [booking_cl_i].[ITEM_ID] = [booking_cl].[ITEM_ID]
LEFT OUTER JOIN [NSCARB_sales_product_group] [booking_cl_spg] WITH (NOLOCK) ON [booking_cl_spg].[LIST_ID] = [booking_cl_i].[SALES_PRODUCT_GROUP_ID]
LEFT OUTER JOIN [NSCARB_sales_product_type] [booking_cl_spt] WITH (NOLOCK) ON [booking_cl_spt].[LIST_ID] = [booking_cl_i].[SALES_PRODUCT_TYPE_ID]
LEFT OUTER JOIN [NSCARB_pricing_groups] [booking_cl_pg] WITH (NOLOCK) ON [booking_cl_pg].[PRICING_GROUP_ID] = [booking_cl_i].[PRICING_GROUP_ID]
LEFT OUTER JOIN [NSCARB_product_type] [booking_cl_pt] WITH (NOLOCK) ON [booking_cl_pt].[LIST_ID] = [booking_cl_i].[PRODUCT_TYPE_ID]
LEFT OUTER JOIN [NSCARB_booking_category] [booking_cl_bc] WITH (NOLOCK) ON [booking_cl_bc].[LIST_ID] = [booking_cl_i].[BOOKING_CATEGORY_ID]
LEFT OUTER JOIN [NSCARB_booking_product_group] [booking_cl_bpg] WITH (NOLOCK) ON [booking_cl_bpg].[LIST_ID] = [booking_cl_i].[BOOKING_PRODUCT_GROUP_ID]
LEFT OUTER JOIN [NSCARB_contract_line_status] [booking_cls] WITH (NOLOCK) ON [booking_cls].[LIST_ID] = [booking_cl].[STATUS_ID]

LEFT OUTER JOIN [NSCARB_items] [old_cl_i] WITH (NOLOCK) ON [old_cl_i].[ITEM_ID] = [old_cl].[ITEM_ID]
LEFT OUTER JOIN [NSCARB_sales_product_group] [old_cl_spg] WITH (NOLOCK) ON [old_cl_spg].[LIST_ID] = [old_cl_i].[SALES_PRODUCT_GROUP_ID]
LEFT OUTER JOIN [NSCARB_sales_product_type] [old_cl_spt] WITH (NOLOCK) ON [old_cl_spt].[LIST_ID] = [old_cl_i].[SALES_PRODUCT_TYPE_ID]
LEFT OUTER JOIN [NSCARB_pricing_groups] [old_cl_pg] WITH (NOLOCK) ON [old_cl_pg].[PRICING_GROUP_ID] = [old_cl_i].[PRICING_GROUP_ID]
LEFT OUTER JOIN [NSCARB_product_type] [old_cl_pt] WITH (NOLOCK) ON [old_cl_pt].[LIST_ID] = [old_cl_i].[PRODUCT_TYPE_ID]
LEFT OUTER JOIN [NSCARB_booking_category] [old_cl_bc] WITH (NOLOCK) ON [old_cl_bc].[LIST_ID] = [old_cl_i].[BOOKING_CATEGORY_ID]
LEFT OUTER JOIN [NSCARB_booking_product_group] [old_cl_bpg] WITH (NOLOCK) ON [old_cl_bpg].[LIST_ID] = [old_cl_i].[BOOKING_PRODUCT_GROUP_ID]
LEFT OUTER JOIN [NSCARB_contract_line_status] [old_cls] WITH (NOLOCK) ON [old_cls].[LIST_ID] = [old_cl].[STATUS_ID]

LEFT OUTER JOIN [NSCARB_items] [new_cl_i] WITH (NOLOCK) ON [new_cl_i].[ITEM_ID] = [new_cl].[ITEM_ID]
LEFT OUTER JOIN [NSCARB_sales_product_group] [new_cl_spg] WITH (NOLOCK) ON [new_cl_spg].[LIST_ID] = [new_cl_i].[SALES_PRODUCT_GROUP_ID]
LEFT OUTER JOIN [NSCARB_sales_product_type] [new_cl_spt] WITH (NOLOCK) ON [new_cl_spt].[LIST_ID] = [new_cl_i].[SALES_PRODUCT_TYPE_ID]
LEFT OUTER JOIN [NSCARB_pricing_groups] [new_cl_pg] WITH (NOLOCK) ON [new_cl_pg].[PRICING_GROUP_ID] = [new_cl_i].[PRICING_GROUP_ID]
LEFT OUTER JOIN [NSCARB_product_type] [new_cl_pt] WITH (NOLOCK) ON [new_cl_pt].[LIST_ID] = [new_cl_i].[PRODUCT_TYPE_ID]
LEFT OUTER JOIN [NSCARB_booking_category] [new_cl_bc] WITH (NOLOCK) ON [new_cl_bc].[LIST_ID] = [new_cl_i].[BOOKING_CATEGORY_ID]
LEFT OUTER JOIN [NSCARB_booking_product_group] [new_cl_bpg] WITH (NOLOCK) ON [new_cl_bpg].[LIST_ID] = [new_cl_i].[BOOKING_PRODUCT_GROUP_ID]
LEFT OUTER JOIN [NSCARB_contract_line_status] [new_cls] WITH (NOLOCK) ON [new_cls].[LIST_ID] = [new_cl].[STATUS_ID]

LEFT OUTER JOIN [NSCARB_currencies] [booking_cl_currency] WITH (NOLOCK) ON [booking_cl_currency].[CURRENCY_ID] = [booking_c].[CURRENCY_ID]
LEFT OUTER JOIN [NSCARB_currencies] [old_cl_currency] WITH (NOLOCK) ON [old_cl_currency].[CURRENCY_ID] = [old_c].[CURRENCY_ID]
LEFT OUTER JOIN [NSCARB_currencies] [new_cl_currency] WITH (NOLOCK) ON [new_cl_currency].[CURRENCY_ID] = [new_c].[CURRENCY_ID]


LEFT OUTER JOIN [NSCARB_contract_billing_freq] [booking_cl_cbf] WITH (NOLOCK) ON [booking_cl_cbf].[CONTRACT_BILLING_FREQ_ID] = [booking_cl].[BILLING_FREQ_ID]
LEFT OUTER JOIN [NSCARB_contract_billing_freq] [old_cl_cbf] WITH (NOLOCK) ON [old_cl_cbf].[CONTRACT_BILLING_FREQ_ID] = [old_cl].[BILLING_FREQ_ID]
LEFT OUTER JOIN [NSCARB_contract_billing_freq] [new_cl_cbf] WITH (NOLOCK) ON [new_cl_cbf].[CONTRACT_BILLING_FREQ_ID] = [new_cl].[BILLING_FREQ_ID]

LEFT OUTER JOIN [NSCARB_contract_endofterm_action] [booking_cl_eota] WITH (NOLOCK) ON [booking_cl_eota].[LIST_ID] = [booking_cl].[ENDOFTERM_ACTION_ID]
LEFT OUTER JOIN [NSCARB_contract_endofterm_action] [old_cl_eota] WITH (NOLOCK) ON [old_cl_eota].[LIST_ID] = [old_cl].[ENDOFTERM_ACTION_ID]
LEFT OUTER JOIN [NSCARB_contract_endofterm_action] [new_cl_eota] WITH (NOLOCK) ON [new_cl_eota].[LIST_ID] = [new_cl].[ENDOFTERM_ACTION_ID]


--INNER JOIN [NSCARB_order_line_transaction_type] [oltt] WITH (NOLOCK) ON [oltt].[LIST_ID] = [tl].[ORDER_LINE_TRANSACTION_TYPE_ID] -- INNER JOIN is used here. There are (as of june 26 2015) 137 transaction lines where order line transaction type is null, and most belong to Hearst and while LINE_ITEM_TAV is non-zero, the sales order really has no TAV and therefore should be excluded.
LEFT OUTER JOIN [NSCARB_order_line_transaction_type] [tl_oltt] WITH (NOLOCK) ON [tl_oltt].[LIST_ID] = [tl].[ORDER_LINE_TRANSACTION_TYPE_ID] -- changed to left outer join on 8/11/2015 because hearst lines would need to be included.
LEFT OUTER JOIN [NSCARB_order_line_transaction_type] [booking_cl_oltt] WITH (NOLOCK) ON [booking_cl_oltt].[LIST_ID] = [booking_cl].[ORDER_LINE_TRANSACTION_TYPE_ID]
LEFT OUTER JOIN [NSCARB_order_line_transaction_type] [old_cl_oltt] WITH (NOLOCK) ON [old_cl_oltt].[LIST_ID] = [old_cl].[ORDER_LINE_TRANSACTION_TYPE_ID]
LEFT OUTER JOIN [NSCARB_order_line_transaction_type] [new_cl_oltt] WITH (NOLOCK) ON [new_cl_oltt].[LIST_ID] = [new_cl].[ORDER_LINE_TRANSACTION_TYPE_ID]


--LEFT OUTER JOIN [dbo].[View__CEM_MRR_NS_Dated_Currency_Exchange_Rates_stx_and_carb] [booking_cl_ex_rate] WITH (NOLOCK) ON [booking_cl_ex_rate].[Base Currency] = 'usd' AND [booking_cl_ex_rate].[Foreign Currency] = [booking_cl_currency].[SYMBOL] AND [t].[TRANDATE] BETWEEN [booking_cl_ex_rate].[Effective Date] AND DATEADD(DAY, -1, [booking_cl_ex_rate].[Next Effective Date])
--LEFT OUTER JOIN [dbo].[View__CEM_MRR_NS_Dated_Currency_Exchange_Rates_stx_and_carb] [old_cl_ex_rate] WITH (NOLOCK) ON [old_cl_ex_rate].[Base Currency] = 'usd' AND [old_cl_ex_rate].[Foreign Currency] = [old_cl_currency].[SYMBOL] AND [t].[TRANDATE] BETWEEN [old_cl_ex_rate].[Effective Date] AND DATEADD(DAY, -1, [old_cl_ex_rate].[Next Effective Date])
--LEFT OUTER JOIN [dbo].[View__CEM_MRR_NS_Dated_Currency_Exchange_Rates_stx_and_carb] [new_cl_ex_rate] WITH (NOLOCK) ON [new_cl_ex_rate].[Base Currency] = 'usd' AND [new_cl_ex_rate].[Foreign Currency] = [new_cl_currency].[SYMBOL] AND [t].[TRANDATE] BETWEEN [new_cl_ex_rate].[Effective Date] AND DATEADD(DAY, -1, [new_cl_ex_rate].[Next Effective Date])

--LEFT OUTER JOIN [dbo].[View__CEM_MRR_NS_Consolidated_Exchange_Rates] [booking_ex_rate] WITH (NOLOCK) ON [booking_ex_rate].[FROM_SUBSIDIARY_ID] = [tl].[SUBSIDIARY_ID] AND [t].[TRANDATE] BETWEEN [booking_ex_rate].[Accounting Period Starting] AND [booking_ex_rate].[Accounting Period Ending]
LEFT OUTER JOIN [dbo].[NSCARB_ACCOUNTING_PERIODS] [ap] WITH (NOLOCK) ON [t].[TRANDATE] BETWEEN [ap].[STARTING] AND [ap].[ENDING] AND [ap].[QUARTER]<>'yes' AND [ap].[YEAR_0]<>'yes'

LEFT OUTER JOIN [dbo].[NSCARB_CONSOLIDATED_EXCHANGE_RATES] [cer] ON [cer].[ACCOUNTING_PERIOD_ID] = [ap].[ACCOUNTING_PERIOD_ID] AND [sub].[SUBSIDIARY_ID] = [cer].[FROM_SUBSIDIARY_ID] AND [cer].[TO_SUBSIDIARY_ID] =1								


WHERE 1=1
AND [t].[TRANSACTION_TYPE]='sales order'
--AND [t].[TRANID]>=110010232 -- SOs in carbonite production instance start with this tranid. any old SOs should be obtained from the sandbox and stx instances.


