
CREATE VIEW [dbo].[V__NS_Consolidated_Exchange_Rates] AS

SELECT
[cer].[ACCOUNTING_PERIOD_ID],
[cer].[FROM_SUBSIDIARY_ID],
[cer].[TO_SUBSIDIARY_ID],
[from_s].[BASE_CURRENCY_ID] [From_Currency_ID],
[to_s].[BASE_CURRENCY_ID] [To_Currency_ID],




[ap].[STARTING] [Accounting_Period_Starting],
[ap].[ENDING] [Accounting_Period_Ending],
[ap].[NAME] [Accounting Period Name],


[from_s].[NAME] [From_Subsidiary],
[to_s].[NAME] [To_Subsidiary],

[from_c].[SYMBOL] [From_Currency],
[to_c].[SYMBOL] [To_Currency],


[cer].[AVERAGE_BUDGET_RATE],
[cer].[AVERAGE_RATE], -- use this for converting invoice amounts.
[cer].[CURRENT_BUDGET_RATE],
[cer].[CURRENT_RATE], -- use this for converting booking (transaction_type='sales order') amounts.
[cer].[HISTORICAL_BUDGET_RATE],
[cer].[HISTORICAL_RATE] -- as of may 2016, this rate is set to be the same as currency rate.



FROM [dbo].[NSCARB_consolidated_exchange_rates] [cer] WITH (NOLOCK)
INNER JOIN [dbo].[NSCARB_accounting_periods] [ap] WITH (NOLOCK) ON [ap].[ACCOUNTING_PERIOD_ID] = [cer].[ACCOUNTING_PERIOD_ID]
INNER JOIN [dbo].[NSCARB_subsidiaries] [from_s] WITH (NOLOCK) ON [from_s].[SUBSIDIARY_ID] = [cer].[FROM_SUBSIDIARY_ID]
INNER JOIN [dbo].[NSCARB_subsidiaries] [to_s] WITH (NOLOCK) ON [to_s].[SUBSIDIARY_ID] = [cer].[TO_SUBSIDIARY_ID]
INNER JOIN [dbo].[NSCARB_currencies] [from_c] WITH (NOLOCK) ON [from_c].[CURRENCY_ID] = [from_s].[BASE_CURRENCY_ID]
INNER JOIN [dbo].[NSCARB_currencies] [to_c] WITH (NOLOCK) ON [to_c].[CURRENCY_ID] = [to_s].[BASE_CURRENCY_ID]



WHERE 1=1
AND [to_s].[NAME]='consolidated'
AND [ap].[STARTING]>='2016/04/01'







