

CREATE VIEW [dbo].[V__NS_Hosted_Contract_Invoice_Usage_SKU] AS

SELECT
	[contract_sku].[Contract_ID]
,	[contract_sku].[Contract_Line_ID]
,	[contract_sku].[Contract_Name]
,	[contract_sku].[Contract_Line_Name]
,	[contract_sku].[Contract_Line_Billing_ID]
,	[contract_sku].[Customer]
,	[contract_sku].[Reseller]
,	[contract_sku].[End_User]
,	[contract_sku].[Customer_ID]
,	[contract_sku].[Reseller_ID]
,	[contract_sku].[End_User_ID]
,	[contract_sku].[Customer_SFDC_ID]
,	[contract_sku].[Reseller_SFDC_ID]
,	[contract_sku].[End_User_SFDC_ID]
,	[contract_sku].[Customer_NS_Number]
,	[contract_sku].[Reseller_NS_Number]
,	[contract_sku].[End_User_NS_Number]

,	[contract_sku].[Customer_End_User]
,	[contract_sku].[Customer_End_User_ID]
,	[contract_sku].[Customer_End_User_SFDC_ID]
,	[contract_sku].[Customer_End_User_NS_Number]

,	[contract_sku].[Direct_Indirect_Distributor]
,	[contract_sku].[Initial_Contract_Date]
,	[contract_sku].[Customer_Account_Type]

,	[contract_sku].[Sales_Product_Group]
,	[contract_sku].[Sales_Product_Type]
,	[contract_sku].[Pricing_Group]
,	[contract_sku].[Product_Type]
,	[contract_sku].[Booking_Category]
,	[contract_sku].[Booking_Product_Group]

,	[contract_sku].[TAV_Category]
,	[contract_sku].[Item]
,	[contract_sku].[Contract_Line_SFDC_ID]
,	[contract_sku].[SKU]
,	[contract_sku].[Storage_Type]


,	[contract_sku].[Quantity]
,	[contract_sku].[Included_Usage_GB]
,	[contract_sku].[Calculated_Included_Usage_GB]

,	[contract_sku].[Contracted_Unit_Rate]
,	[contract_sku].[Overage_Rate]
,	[contract_sku].[Contracted_Amount]

,	[contract_sku].[Contracted_Unit_Rate_USD]
,	[contract_sku].[Overage_Rate_USD]
,	[contract_sku].[Contracted_Amount_USD]

,	[contract_sku].[Currency] [Contract_Currency]


,	[contract_sku].[Order_Line_Transaction_Type]
,	[contract_sku].[Term_Month]
,	[contract_sku].[End_of_Term_Action]
,	[contract_sku].[Billing_Frequency]

,	[contract_sku].[Start_Date]
,	[contract_sku].[End_Date]
,	[contract_sku].[Cancellation_Date]

,	[contract_sku].[Contract_Line_Status]
,	[contract_sku].[Superseded_By_ID]
,	[contract_sku].[Supersedes_ID]

,	CAST([ilt].[BILLING_DATE] AS DATE) [Billing_Date]
,	[ilt].[TRANID] [Invoice_Number]
,	[ilt].[Currency] [Invoice_Currency]
,	[ilt].[STATUS] [Invoice_Status]


,	ROUND([cu].[QTY],2) [Total_Usage_GB]
,	CASE WHEN [cu].[QTY]>[contract_sku].[Calculated_Included_Usage_GB] THEN ROUND([cu].[QTY]-[contract_sku].[Calculated_Included_Usage_GB],2) ELSE 0 END [Overage_GB]

,	[ilt].[CONTRACT_LINE_AMOUNT_CHARGED] [Contract_Line_Amount_Charged]
,	[ilt].[CONTRACT_USAGE_AMOUNT_CHARGED] [Contract_Usage_Amount_Charged]
,	CASE WHEN [ilt].[INVOICE_LINK_ID] IS NULL THEN NULL ELSE ISNULL([ilt].[CONTRACT_LINE_AMOUNT_CHARGED],0) + ISNULL([ilt].[CONTRACT_USAGE_AMOUNT_CHARGED],0) END [Invoice_Total]

,	CAST([ilt].[CONTRACT_LINE_AMOUNT_CHARGED]*[cer].[AVERAGE_RATE] AS NUMERIC(16,2)) [Contract_Line_Amount_Charged_USD]
,	CAST([ilt].[CONTRACT_USAGE_AMOUNT_CHARGED]*[cer].[AVERAGE_RATE] AS NUMERIC(16,2)) [Contract_Usage_Amount_Charged_USD]
,	CASE WHEN [ilt].[INVOICE_LINK_ID] IS NULL THEN NULL ELSE CAST((ISNULL([ilt].[CONTRACT_LINE_AMOUNT_CHARGED],0) + ISNULL([ilt].[CONTRACT_USAGE_AMOUNT_CHARGED],0))*[cer].[AVERAGE_RATE] AS NUMERIC(16,2)) END [Invoice_Total_USD]

,	[ilt].[APPROVED_INVOICE] [Approved_Invoice]

,	[ilt].[TRANSACTION_ID] [Transaction_ID]
,	CAST([ilt].[TRANDATE] AS DATE) [Transaction_Date]
,	CAST([ilt].[SALES_EFFECTIVE_DATE] AS DATE) [Sales_Effective_Date]

-- seagate fiscal months are no longer needed.
--,	[fc_trandate].[FY] [Transaction FY]
--,	[fc_trandate].[FQ] [Transaction FQ]
--,	[fc_trandate].[FM] [Transaction FM]
--,	[fc_trandate].[FY FM] [Transaction FY FM]

,	[ilt].[Posting_Period] [Posting_Period]
,	CONVERT(DATE, '1 ' + [ilt].[Posting_Period], 106) [Posting_Period_Month] -- converts '1 jan 2016' date format to actual sql date.


-- seagate fiscal months are no longer needed.
--,	[fc_posting_period].[FY] [Posting Period FY]
--,	[fc_posting_period].[FQ] [Posting Period FQ]
--,	[fc_posting_period].[FM] [Posting Period FM]
--,	[fc_posting_period].[FY FM] [Posting Period FY FM]

,	CAST([ilt].[CREATE_DATE] AS DATE) [Invoice_Create_Date]

FROM [dbo].[V__NS_Hosted_Contract_SKU] [contract_sku]

LEFT OUTER JOIN [dbo].[V__NS_Invoice_Link_Transaction] [ilt] WITH (NOLOCK) ON [ilt].[CONTRACT_RECORD_ID] = [contract_sku].[Contract_ID] AND [ilt].[CONTRACT_LINE_ID] = [contract_sku].[Contract_Line_ID]

LEFT OUTER JOIN [dbo].[NSCARB_contract_usage] [cu] WITH (NOLOCK) ON [cu].[CONTRACT_USAGE_ID] = [ilt].[USAGE_RECORD_ID] AND [cu].[CONTRACT_LINE_ID] = [contract_sku].[Contract_Line_ID] AND [cu].[CONTRACT_ID] = [contract_sku].[Contract_ID]

-- seagate fiscal month information is no longer needed for carbonite.
--LEFT OUTER JOIN [dbo].[CEM_MRR_Fiscal_Month_Start_End_Dates] [fc_trandate] WITH (NOLOCK) ON CAST([ilt].[TRANDATE] AS DATE) BETWEEN [fc_trandate].[FM Start Date] AND [fc_trandate].[FM End Date]
--LEFT OUTER JOIN [dbo].[CEM_MRR_Fiscal_Month_Start_End_Dates] [fc_posting_period] WITH (NOLOCK) ON CAST([ilt].[TRANDATE] AS DATE) BETWEEN [fc_posting_period].[FM Start Date] AND [fc_posting_period].[FM End Date]

LEFT OUTER JOIN [Evault SFDC].[dbo].[EV_SF_DATEDCONVERSIONRATE] [cl_fx_rate] WITH (NOLOCK) ON [cl_fx_rate].[IsoCode] = [contract_sku].[currency] AND [contract_sku].[Start_Date]>=[cl_fx_rate].[StartDate] AND [contract_sku].[Start_Date]<[cl_fx_rate].[NextStartDate]
LEFT OUTER JOIN [Evault SFDC].[dbo].[EV_SF_DATEDCONVERSIONRATE] [invoice_fx_rate] WITH (NOLOCK) ON [invoice_fx_rate].[IsoCode] = [ilt].[Currency] AND [ilt].[Posting_Period_Starting_Date]>=[invoice_fx_rate].[StartDate] AND [ilt].[Posting_Period_Starting_Date]<[invoice_fx_rate].[NextStartDate]

LEFT OUTER JOIN [dbo].[NSCARB_CUSTOMERS] [customer] WITH (NOLOCK) ON [customer].[CUSTOMER_ID] = [contract_sku].[Customer_ID]
LEFT OUTER JOIN [dbo].[NSCARB_SUBSIDIARIES] [sub] WITH (NOLOCK) ON [sub].[SUBSIDIARY_ID] = [customer].[SUBSIDIARY_ID]
LEFT OUTER JOIN [dbo].[V__NS_Consolidated_Exchange_Rates] [cer] WITH (NOLOCK) ON [cer].[FROM_SUBSIDIARY_ID] = [sub].[SUBSIDIARY_ID] AND [cer].[ACCOUNTING_PERIOD_ID] = [ilt].[ACCOUNTING_PERIOD_ID]

WHERE 1=1

-- only pull in approved invoices. if the invoice(transaction) is null, don't filter it out yet. the next filter below will perform further validation.
-- 2016/02/25: instead of only pulling in approved invoice, changed to pull all invoices, then include flag as column.
--AND ISNULL([ilt].[APPROVED_INVOICE],'T')='T'


-- if contract line is cancelled or terminated and there's no associated invoice line, filter it out. otherwise, keep the row so that the contract info is available.
AND NOT ([contract_sku].[Contract_Line_Status] IN ('Canceled', 'Terminated') AND [ilt].[INVOICE_LINK_ID] IS NULL)

-- below filters are for getting active contract lines
--AND [cl].[START_DATE]<=GETDATE()
--AND ISNULL([cl].[END_DATE], '2099/12/31') >=GETDATE()
--AND [cls].[LIST_ITEM_NAME]='active'
--AND [cl].[SUPERSEDED_BY_ID] IS NULL

AND (CAST([ilt].[BILLING_DATE] AS DATE)>='2016/04/01' OR [ilt].[BILLING_DATE] IS NULL)














