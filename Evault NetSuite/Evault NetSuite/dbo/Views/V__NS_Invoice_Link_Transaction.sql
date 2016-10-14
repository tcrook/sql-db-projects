
CREATE VIEW [dbo].[V__NS_Invoice_Link_Transaction] AS

SELECT
	[il].[INVOICE_LINK_ID]
,	[il].[CONSOLIDATED_INVOICE_LINE_ID]
,	[il].[CONTRACT_LINE_ID]
,	[il].[CONTRACT_RECORD_ID]
,	[il].[CONTRACT_LINE_AMOUNT_CHARGED]
,	[il].[CONTRACT_USAGE_AMOUNT_CHARGED]
,	[il].[USAGE_RECORD_ID]
,	[il].[BILLING_DATE]
,	[t].[TRANID]
,	[t].[STATUS]
,	[t].[TRANSACTION_ID]
,	[t].[TRANDATE]
,	[t].[SALES_EFFECTIVE_DATE]
,	[t].[CREATE_DATE]
,	[currency].[SYMBOL] [Currency]
,	[ap].[NAME] [Posting_Period]
,	[ap].[ACCOUNTING_PERIOD_ID]
,	[ap].[STARTING] [Posting_Period_Starting_Date]
,	[ap].[ENDING] [Posting_Period_Ending_Date]
,	[t].[APPROVED_INVOICE]
FROM [dbo].[NSCARB_invoice_link] [il] WITH (NOLOCK)
INNER JOIN [dbo].[NSCARB_transactions] [t] WITH (NOLOCK) ON [t].[TRANSACTION_TYPE]='invoice' AND [t].[TRANSACTION_ID] = [il].[INVOICE_RECORD_ID]
LEFT OUTER JOIN [dbo].[NSCARB_accounting_periods] [ap] WITH (NOLOCK) ON [ap].[ACCOUNTING_PERIOD_ID] = [t].[ACCOUNTING_PERIOD_ID]
LEFT OUTER JOIN [dbo].[NSCARB_currencies] [currency] WITH (NOLOCK) ON [currency].[CURRENCY_ID] = [t].[CURRENCY_ID]









