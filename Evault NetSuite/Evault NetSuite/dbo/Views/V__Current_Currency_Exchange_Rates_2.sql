CREATE VIEW [dbo].[V__Current_Currency_Exchange_Rates_2] AS

WITH cte1 AS
(
SELECT
	*
,	ROW_NUMBER() OVER (PARTITION BY [dcr].[Currency_Code__c] ORDER BY [dcr].[Start_Date__c] DESC) [row_num]
FROM [Evault SFDC].[dbo].[ev_sf_Dated_Currency_Rate__c] [dcr] WITH (NOLOCK)
WHERE 1=1
AND [dcr].[IsDeleted]=0
)

SELECT
[cte1].[Currency_Code__c] [CurrencyIsoCode],
[cte1].[Start_Date__c] [Start_Date],
[cte1].[End_Date__c] [End_Date],
[cte1].[Exchange_Rate__c] [Exchange_Rate]
FROM [cte1]
WHERE 1=1
AND [cte1].[row_num]=1
UNION
SELECT 'USD', '2010/01/01','2099/12/31',1





