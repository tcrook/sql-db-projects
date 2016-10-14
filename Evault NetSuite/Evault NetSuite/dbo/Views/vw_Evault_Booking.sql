







CREATE VIEW [dbo].[vw_Evault_Booking]
AS

WITH [il_cl] AS								
(								
SELECT								
       [il].[INVOICE_RECORD_ID]								
,      [cl].[ITEM_ID]								
,      [cl].[SALES_ORDER_ID]
,	   [cl].CONTRACT_ID
,	   [cl].CONTRACT_LINE_ID
,	   [cl].START_DATE
,	   [cl].END_DATE
,	   [cl].CANCELLATION_DATE
,	   [cl].SUPERSEDED_BY_ID
,	   [cl].SUPERSEDES_ID
,	   [customer].[COMPANYNAME] [Customer]
,	   [reseller].[COMPANYNAME] [Reseller]
,	   [end_user].[COMPANYNAME] [End_User]
,	   COALESCE([end_user].[COMPANYNAME], [customer].[COMPANYNAME]) [Customer_End User]
,	   [customer].[CUSTOMER_ID] [Customer_id]
,	   [reseller].[CUSTOMER_ID] [Reseller_id]
,	   [end_user].[CUSTOMER_ID] [End_User_id]
,	   COALESCE([end_user].[CUSTOMER_ID], [customer].[CUSTOMER_ID]) [Customer_End User_id]
,      [eota].[LIST_ITEM_NAME] [End_Of_Term_Action]								
,	   [oltt].LIST_ITEM_NAME contracted_item_order_line_type							
,      [il].[CONTRACT_LINE_AMOUNT_CHARGED]								
,      [il].[CONTRACT_USAGE_AMOUNT_CHARGED]	
,	   'Contracted Item' Item_Type
FROM [dbo].[NSCARB_INVOICE_LINK] [il] WITH (NOLOCK)								
INNER JOIN [dbo].[NSCARB_CONTRACT_LINE] [cl] WITH (NOLOCK) ON [cl].[CONTRACT_LINE_ID] = [il].[CONTRACT_LINE_ID] AND [cl].[CONTRACT_ID] = [il].[CONTRACT_RECORD_ID]		-- inner join to make sure only contract related invoice are selected						
LEFT OUTER JOIN [dbo].[NSCARB_CONTRACT_ENDOFTERM_ACTION] [eota] WITH (NOLOCK) ON [eota].[LIST_ID] = [cl].[ENDOFTERM_ACTION_ID]								
LEFT OUTER JOIN [dbo].[NSCARB_ORDER_LINE_TRANSACTION_TYPE]  [oltt]  WITH (NOLOCK) ON [oltt].LIST_ID = [cl].ORDER_LINE_TRANSACTION_TYPE_ID	
LEFT OUTER JOIN [dbo].[NSCARB_customers] [customer] WITH (NOLOCK) ON [customer].[CUSTOMER_ID] = [cl].[CUSTOMER_ID]
LEFT OUTER JOIN [dbo].[NSCARB_customers] [reseller] WITH (NOLOCK) ON [reseller].[CUSTOMER_ID] = [cl].[RESELLER_ID]
LEFT OUTER JOIN [dbo].[NSCARB_customers] [end_user] WITH (NOLOCK) ON [end_user].[CUSTOMER_ID] = [cl].[END_USER_ID]
							
)								
 								
, [tlink] AS								
(		
						
SELECT DISTINCT				-- precaution to avoid any duplicate records				
       [tlink].[ORIGINAL_TRANSACTION_ID]								
,      [tlink].[ORIGINAL_TRANSACTION_LINE_ID]				
,      [tlink].[APPLIED_TRANSACTION_ID]								
,      [tlink].[APPLIED_TRANSACTION_LINE_ID]								
,      [tlink].[AMOUNT_FOREIGN_LINKED]								
,      [tlink].[AMOUNT_LINKED]	
,		'Non Contracted Item' Item_Type
FROM [dbo].[NSCARB_TRANSACTION_LINKS] [tlink] WITH (NOLOCK)								
INNER JOIN [dbo].[NSCARB_TRANSACTIONS] [t] WITH (NOLOCK) ON [t].[TRANSACTION_ID] = [tlink].[APPLIED_TRANSACTION_ID] AND [t].[TRANSACTION_TYPE]='invoice'   --inner join to make sure only invoice related rows selected



)		


 								
SELECT								
								
		'Invoices' AS Source_type	
,		[il_cl].Item_Type Contracted_Item_Type
,		[tlink].Item_Type NonContracted_Item_Type

 --This is to iquantify how much booking amount do not have any Sales order tied. AAnd also serves the pursoe for % of booking for Contracted Vs Non COntracted
,		CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].Item_Type
			 WHEN  [tlink].Item_Type = 'Non Contracted Item'  THEN [tlink].Item_Type
			 ELSE 'UNKNOWN' 
		END Item_Type

-- Contracted item invoices do not have customer information on invoice transaction so need to bring it from  il_cl CTE at Contract line level

,		(CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].[Customer]
			 ELSE [customer].COMPANYNAME
		END) customer

,		(CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].[Reseller]
			 ELSE [reseller].COMPANYNAME
		END) reseller


,		(CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].[End_User]
			 ELSE  [End User].COMPANYNAME
		END) end_user

,		(CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].[Customer_End User]
			 ELSE  COALESCE([end user].[COMPANYNAME], [customer].[COMPANYNAME]) 
		END) customer_end_user

-- This is added to calculate customer type
,		(CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].[Customer_id]
			 ELSE [customer].[CUSTOMER_ID]
		END) customer_id

,		(CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].[Reseller_id]
			 ELSE [reseller].[CUSTOMER_ID]
		END) reseller_id


,		(CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].[End_User_id]
			 ELSE  [End User].[CUSTOMER_ID]
		END) end_user_id


,		(CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].[Customer_End User_id]
			 ELSE  COALESCE([end user].[CUSTOMER_ID], [customer].[CUSTOMER_ID]) 
		END) customer_end_user_id

,	   (CASE
              WHEN (CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].[End_User_id]
					ELSE  [End User].[CUSTOMER_ID]
					END) IS NULL THEN 'Direct'
              WHEN (CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].[End_User_id]
					ELSE  [End User].[CUSTOMER_ID]
					END) = (CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].[Customer_id]
							ELSE [customer].[CUSTOMER_ID]
							END) THEN 'Direct'
              WHEN (CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].[End_User_id]
					ELSE  [End User].[CUSTOMER_ID]
					END) IS NOT NULL THEN 'Indirect'
              ELSE
                     'Unknown'
       END) Channel_Type

,		[customer].[SALESFORCE_ID] [Customer_SFDC_ID]
,		[reseller].[SALESFORCE_ID] [Reseller_SFDC_ID]
,		[end user].[SALESFORCE_ID] [End_User_SFDC_ID]
,		COALESCE([end user].[SALESFORCE_ID], [customer].[SALESFORCE_ID]) [Customer_End_User_SFDC_ID]
,		[sfdc_end_user].GEO__C

,		sub.NAME subsidiary
,		[t].[TRANDATE]		
,		[t].[tranid]	
,		[t].transaction_id
,		[t].STATUS
,		CAST (NULL AS NVARCHAR(256) ) AS CM_reason_code
,		NULL AS CM_original_invoice_id						
,		[ap].NAME accounting_period	
,		[ap].starting	AS Accounting_period_start_date						
,		[gl].NAME GL_Name	
,		[il_cl].CONTRACT_ID
,		[il_cl].CONTRACT_LINE_ID
,		[il_cl].START_DATE contract_start_date
,		[il_cl].END_DATE contract_end_date
,		[il_cl].CANCELLATION_DATE contract_cancelled_date
,		[il_cl].SUPERSEDED_BY_ID
,		[il_cl].SUPERSEDES_ID
,		[t_so].tranid Sales_order_number
,		[i].[NAME] item_name	
,		[pt].LIST_ITEM_NAME	Product_type_name	
,		[tc].LIST_ITEM_NAME  TAV_category_name					
,		[bpg].LIST_ITEM_NAME booking_product_group_name								
					
,		COALESCE((CASE WHEN [i].Name LIKE '%MSP%' THEN 'Royalty' ELSE [bpg].LIST_ITEM_NAME END), p.Product_name )		custom_prod_grouping		
,		fin.Finance_Product_Grouping_name	Finance_Product_grouping

,		(CASE WHEN [il_cl].[INVOICE_RECORD_ID] IS NULL THEN [ot].[LIST_ITEM_NAME]								
			  WHEN  [il_cl].End_Of_Term_Action = 'Perpetual' THEN 'Auto-Renew'						
			  ELSE [il_cl].contracted_item_order_line_type						
		 END	) 	order_type	
		 
,		CASE WHEN (	CASE WHEN [il_cl].[INVOICE_RECORD_ID] IS NULL THEN [ot].[LIST_ITEM_NAME]								
					WHEN  [il_cl].End_Of_Term_Action = 'Perpetual' THEN 'Auto-Renew'						
					ELSE [il_cl].contracted_item_order_line_type						
					END	) = 'Add-On'  THEN 'New'

			WHEN (	CASE WHEN [il_cl].[INVOICE_RECORD_ID] IS NULL THEN [ot].[LIST_ITEM_NAME]								
					WHEN  [il_cl].End_Of_Term_Action = 'Perpetual' THEN 'Auto-Renew'						
					ELSE [il_cl].contracted_item_order_line_type						
					END	) = 'Auto-Renew' THEN 'Renewal'

			WHEN (	CASE WHEN [il_cl].[INVOICE_RECORD_ID] IS NULL THEN [ot].[LIST_ITEM_NAME]								
					WHEN  [il_cl].End_Of_Term_Action = 'Perpetual' THEN 'Auto-Renew'						
					ELSE [il_cl].contracted_item_order_line_type						
					END	) = 'Cancelation' THEN 'Renewal'

			WHEN (	CASE WHEN [il_cl].[INVOICE_RECORD_ID] IS NULL THEN [ot].[LIST_ITEM_NAME]								
					WHEN  [il_cl].End_Of_Term_Action = 'Perpetual' THEN 'Auto-Renew'						
					ELSE [il_cl].contracted_item_order_line_type						
					END	) = 'CrossSell' AND ((CAST([il_cl].START_DATE AS DATE) >'1/14/2016' AND [sfdc_end_user].GEO__C IN ('North America')) OR (CAST([il_cl].START_DATE AS DATE) >'3/31/2016' AND [sfdc_end_user].GEO__C IN ('Asia Pac','EMEA','LATAM'))) THEN 'New' --date condition is new
--this is new
			WHEN (	CASE WHEN [il_cl].[INVOICE_RECORD_ID] IS NULL THEN [ot].[LIST_ITEM_NAME]								
					WHEN  [il_cl].End_Of_Term_Action = 'Perpetual' THEN 'Auto-Renew'						
					ELSE [il_cl].contracted_item_order_line_type						
					END	) = 'CrossSell' AND ((CAST([il_cl].START_DATE AS DATE) <='1/14/2016' AND [sfdc_end_user].GEO__C IN ('North America')) OR (CAST([il_cl].START_DATE AS DATE) <='3/31/2016' AND [sfdc_end_user].GEO__C IN ('Asia Pac','EMEA','LATAM')))  THEN 'Renewal' 

			WHEN (	CASE WHEN [il_cl].[INVOICE_RECORD_ID] IS NULL THEN [ot].[LIST_ITEM_NAME]								
					WHEN  [il_cl].End_Of_Term_Action = 'Perpetual' THEN 'Auto-Renew'						
					ELSE [il_cl].contracted_item_order_line_type						
					END	) = 'Downgrade' THEN 'Renewal'

			WHEN (	CASE WHEN [il_cl].[INVOICE_RECORD_ID] IS NULL THEN [ot].[LIST_ITEM_NAME]								
					WHEN  [il_cl].End_Of_Term_Action = 'Perpetual' THEN 'Auto-Renew'						
					ELSE [il_cl].contracted_item_order_line_type						
					END	) = 'Early Renewal' THEN 'Renewal'

			WHEN (	CASE WHEN [il_cl].[INVOICE_RECORD_ID] IS NULL THEN [ot].[LIST_ITEM_NAME]								
					WHEN  [il_cl].End_Of_Term_Action = 'Perpetual' THEN 'Auto-Renew'						
					ELSE [il_cl].contracted_item_order_line_type						
					END	) = 'New'  AND ((CAST([il_cl].START_DATE AS DATE) >'1/14/2016' AND [sfdc_end_user].GEO__C IN ('North America')) OR (CAST([il_cl].START_DATE AS DATE) >'3/31/2016' AND [sfdc_end_user].GEO__C IN ('Asia Pac','EMEA','LATAM')))  THEN 'New' --date condition is new

--this is new
			WHEN (	CASE WHEN [il_cl].[INVOICE_RECORD_ID] IS NULL THEN [ot].[LIST_ITEM_NAME]								
					WHEN  [il_cl].End_Of_Term_Action = 'Perpetual' THEN 'Auto-Renew'						
					ELSE [il_cl].contracted_item_order_line_type						
					END	) = 'New'  AND ((CAST([il_cl].START_DATE AS DATE) <='1/14/2016' AND [sfdc_end_user].GEO__C IN ('North America')) OR (CAST([il_cl].START_DATE AS DATE) <='3/31/2016' AND [sfdc_end_user].GEO__C IN ('Asia Pac','EMEA','LATAM')))  THEN 'Renewal'

			WHEN (	CASE WHEN [il_cl].[INVOICE_RECORD_ID] IS NULL THEN [ot].[LIST_ITEM_NAME]								
					WHEN  [il_cl].End_Of_Term_Action = 'Perpetual' THEN 'Auto-Renew'						
					ELSE [il_cl].contracted_item_order_line_type						
					END	) = 'New Customer' THEN 'New'

			WHEN (	CASE WHEN [il_cl].[INVOICE_RECORD_ID] IS NULL THEN [ot].[LIST_ITEM_NAME]								
					WHEN  [il_cl].End_Of_Term_Action = 'Perpetual' THEN 'Auto-Renew'						
					ELSE [il_cl].contracted_item_order_line_type						
					END	) = 'No Change' THEN 'Renewal'

			WHEN (	CASE WHEN [il_cl].[INVOICE_RECORD_ID] IS NULL THEN [ot].[LIST_ITEM_NAME]								
					WHEN  [il_cl].End_Of_Term_Action = 'Perpetual' THEN 'Auto-Renew'						
					ELSE [il_cl].contracted_item_order_line_type						
					END	) IS NULL AND fin.Finance_Product_Grouping_name IN ('Hardware','Software - license')THEN 'New'

			WHEN (	CASE WHEN [il_cl].[INVOICE_RECORD_ID] IS NULL THEN [ot].[LIST_ITEM_NAME]								
					WHEN  [il_cl].End_Of_Term_Action = 'Perpetual' THEN 'Auto-Renew'						
					ELSE [il_cl].contracted_item_order_line_type						
					END	) IS NULL THEN 'Renewal'

			WHEN (	CASE WHEN [il_cl].[INVOICE_RECORD_ID] IS NULL THEN [ot].[LIST_ITEM_NAME]								
					WHEN  [il_cl].End_Of_Term_Action = 'Perpetual' THEN 'Auto-Renew'						
					ELSE [il_cl].contracted_item_order_line_type						
					END	) = 'ProductChange' THEN 'Renewal'

			WHEN (	CASE WHEN [il_cl].[INVOICE_RECORD_ID] IS NULL THEN [ot].[LIST_ITEM_NAME]								
					WHEN  [il_cl].End_Of_Term_Action = 'Perpetual' THEN 'Auto-Renew'						
					ELSE [il_cl].contracted_item_order_line_type						
					END	) = 'Re-Price' THEN 'Renewal'

			WHEN (	CASE WHEN [il_cl].[INVOICE_RECORD_ID] IS NULL THEN [ot].[LIST_ITEM_NAME]								
					WHEN  [il_cl].End_Of_Term_Action = 'Perpetual' THEN 'Auto-Renew'						
					ELSE [il_cl].contracted_item_order_line_type						
					END	) ='Renewal' THEN 'Renewal'


			WHEN (	CASE WHEN [il_cl].[INVOICE_RECORD_ID] IS NULL THEN [ot].[LIST_ITEM_NAME]								
					WHEN  [il_cl].End_Of_Term_Action = 'Perpetual' THEN 'Auto-Renew'						
					ELSE [il_cl].contracted_item_order_line_type						
					END	) ='Upgrade' THEN 'Renewal'


			WHEN (	CASE WHEN [il_cl].[INVOICE_RECORD_ID] IS NULL THEN [ot].[LIST_ITEM_NAME]								
					WHEN  [il_cl].End_Of_Term_Action = 'Perpetual' THEN 'Auto-Renew'						
					ELSE [il_cl].contracted_item_order_line_type						
					END	) ='UpSell' THEN 'Renewal'


			WHEN (	CASE WHEN [il_cl].[INVOICE_RECORD_ID] IS NULL THEN [ot].[LIST_ITEM_NAME]								
					WHEN  [il_cl].End_Of_Term_Action = 'Perpetual' THEN 'Auto-Renew'						
					ELSE [il_cl].contracted_item_order_line_type						
					END	) ='No Change' THEN 'Renewal'

			ELSE (	CASE WHEN [il_cl].[INVOICE_RECORD_ID] IS NULL THEN [ot].[LIST_ITEM_NAME]								
					WHEN  [il_cl].End_Of_Term_Action = 'Perpetual' THEN 'Auto-Renew'						
					ELSE [il_cl].contracted_item_order_line_type						
					END	) 

		END Subscription_Type






	

,		RANK() OVER (PARTITION BY (CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].[Customer_End User_id]
											  ELSE  COALESCE([end user].[CUSTOMER_ID], [customer].[CUSTOMER_ID]) 
										END)
							ORDER BY YEAR([t].[TRANDATE]) ,MONTH([t].[TRANDATE]) ASC) Customer_sort

,		(CASE WHEN (RANK() OVER (PARTITION BY (CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].[Customer_End User_id]
											  ELSE  COALESCE([end user].[CUSTOMER_ID], [customer].[CUSTOMER_ID]) 
										END)
							ORDER BY YEAR([t].[TRANDATE]), MONTH([t].[TRANDATE]) ASC))=1 THEN 'New Customer'
			 WHEN (RANK() OVER (PARTITION BY (CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].[Customer_End User_id]
											  ELSE  COALESCE([end user].[CUSTOMER_ID], [customer].[CUSTOMER_ID]) 
										END)
							ORDER BY YEAR([t].[TRANDATE]), MONTH([t].[TRANDATE]) ASC))>1 THEN 'Exsisting Customer'
			 
			ELSE 'UNKNOWN' 
			
			END	)   customer_type


,		RANK() OVER (PARTITION BY (CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].Customer_id
											  ELSE   [customer].[CUSTOMER_ID]
										END)
							ORDER BY YEAR([t].[TRANDATE]) ,MONTH([t].[TRANDATE]) ASC) Bill_to_Customer_sort

,		(CASE WHEN (RANK() OVER (PARTITION BY (CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].Customer_id
											  ELSE  [customer].[CUSTOMER_ID]
										END)
							ORDER BY YEAR([t].[TRANDATE]), MONTH([t].[TRANDATE]) ASC))=1 THEN 'New Customer'
			 WHEN (RANK() OVER (PARTITION BY (CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].Customer_id
											  ELSE  [customer].[CUSTOMER_ID] 
										END)
							ORDER BY YEAR([t].[TRANDATE]), MONTH([t].[TRANDATE]) ASC))>1 THEN 'Exsisting Customer'
			 
			ELSE 'UNKNOWN' 
			
			END	)   Bill_to_customer_type

,		[c].symbol	 Foreign_currency_Symbol		
								
,		(CASE WHEN [il_cl].[INVOICE_RECORD_ID] IS NULL THEN SUM((0- [tl].[AMOUNT_FOREIGN]))								
		      WHEN [il_cl].[INVOICE_RECORD_ID] IS NOT NULL THEN SUM((ISNULL([il_cl].[CONTRACT_LINE_AMOUNT_CHARGED],0))+(ISNULL([il_cl].[CONTRACT_USAGE_AMOUNT_CHARGED],0)))						
			  ELSE 0							
		 END	) 	booking_amount_foreign
,		t.EXCHANGE_RATE Exchange_rate_to_subsidiary_currency
,		cer.AVERAGE_RATE Average_Exchange_rate_to_Dollar
									
,		(CASE WHEN [il_cl].[INVOICE_RECORD_ID] IS NULL THEN SUM((0- [tl].[AMOUNT])*cer.AVERAGE_RATE )								
			  WHEN [il_cl].[INVOICE_RECORD_ID] IS NOT NULL THEN SUM((ISNULL([il_cl].[CONTRACT_LINE_AMOUNT_CHARGED],0)*t.EXCHANGE_RATE*cer.AVERAGE_RATE)+(ISNULL([il_cl].[CONTRACT_USAGE_AMOUNT_CHARGED],0)*t.EXCHANGE_RATE*cer.AVERAGE_RATE))						
			  ELSE 0							
		  END	) 	booking_amount_usd					
								
--INTO [Evault NetSuite].[dbo].[T2]								
 								
 								
FROM [dbo].[NSCARB_TRANSACTIONS] [t] WITH (NOLOCK)								
INNER JOIN [dbo].[NSCARB_TRANSACTION_LINES] [tl] WITH (NOLOCK) ON [tl].[TRANSACTION_ID] = [t].[TRANSACTION_ID]								
LEFT OUTER JOIN [dbo].[NSCARB_ITEMS] [i] WITH (NOLOCK) ON [i].[ITEM_ID] = [tl].[ITEM_ID]								
LEFT OUTER JOIN [dbo].[NSCARB_BOOKING_PRODUCT_GROUP] [bpg] WITH (NOLOCK) ON [bpg].[LIST_ID] = [i].[BOOKING_PRODUCT_GROUP_ID]	
LEFT OUTER JOIN [dbo].[NSCARB_PRODUCT_TYPE] [pt] ON [pt].LIST_ID = [i].PRODUCT_TYPE_ID	
LEFT OUTER JOIN [dbo].[NSCARB_TAV_CATEGORY] [tc] ON [tc].LIST_ID = [i].TAV_CATEGORY_ID

-- we have customer information here for Noncontracted items as we cannot add it in the tlink CTE since invoices which are not tied to any sales order (example: rebill invoice are not tied t Sales order) will not be availble in Transaction link

LEFT OUTER  JOIN [dbo].[NSCARB_customers] [customer] WITH (NOLOCK) ON [customer].[CUSTOMER_ID] = [t].[ENTITY_ID]
LEFT OUTER  JOIN [dbo].[NSCARB_customers] [reseller] WITH (NOLOCK) ON [reseller].[CUSTOMER_ID] = [t].[RESELLER_ID]
LEFT OUTER  JOIN [dbo].[NSCARB_customers] [end user] WITH (NOLOCK) ON [end user].[CUSTOMER_ID] = [t].[END_USER_CUSTOMER_ID]

LEFT OUTER JOIN [Evault SFDC].[dbo].[EV_SF_Account] [sfdc_end_user] WITH (NOLOCK) ON [sfdc_end_user].[Id] = COALESCE([end user].[SALESFORCE_ID], [customer].[SALESFORCE_ID])
LEFT OUTER JOIN [Evault SFDC].[dbo].[EV_SF_Account] [sfdc_customer] WITH (NOLOCK) ON [sfdc_customer].[Id] = [customer].[SALESFORCE_ID]
						
LEFT OUTER JOIN [dbo].[NSCARB_ACCOUNTS] [gl] WITH (NOLOCK) ON [gl].[ACCOUNT_ID] = [tl].[ACCOUNT_ID]								
LEFT OUTER JOIN dbo.EV_Custom_GL_Product p ON p.GL_Name = [GL].NAME
LEFT OUTER JOIN [dbo].[EV_Custom_Finance_Product_Group] fin ON fin.Custom_Prodct_grouping_name = COALESCE((CASE WHEN [i].Name LIKE '%MSP%' THEN 'Royalty' ELSE [bpg].LIST_ITEM_NAME END), p.Product_name )
 								
LEFT OUTER JOIN [tlink] ON [tlink].[APPLIED_TRANSACTION_ID] = [t].[TRANSACTION_ID] AND [tlink].[APPLIED_TRANSACTION_LINE_ID] = [tl].[TRANSACTION_LINE_ID]								
LEFT OUTER JOIN [dbo].[NSCARB_TRANSACTIONS] [t_so] WITH (NOLOCK) ON [t_so].[TRANSACTION_ID] = [tlink].[ORIGINAL_TRANSACTION_ID]								
LEFT OUTER JOIN [dbo].[NSCARB_ORDER_TYPE] [ot] WITH (NOLOCK) ON [ot].[LIST_ID] = [t_so].[ORDER_TYPE_ID]		

 								
LEFT OUTER JOIN [il_cl] ON [il_cl].[INVOICE_RECORD_ID] = [t].[TRANSACTION_ID] AND [il_cl].[ITEM_ID] = [tl].[ITEM_ID]								
LEFT OUTER JOIN [dbo].[NSCARB_TRANSACTIONS] [cl_so] WITH (NOLOCK) ON [cl_so].[TRANSACTION_ID] = [il_cl].[SALES_ORDER_ID]								
LEFT OUTER JOIN [dbo].[NSCARB_ORDER_TYPE] [cl_so_ot] WITH (NOLOCK) ON [cl_so_ot].[LIST_ID] = [cl_so].[ORDER_TYPE_ID]	

 								
								
 								
 								
LEFT OUTER JOIN [dbo].[NSCARB_ACCOUNTING_PERIODS] [ap] WITH (NOLOCK) ON [ap].[ACCOUNTING_PERIOD_ID] = [t].ACCOUNTING_PERIOD_ID								
LEFT OUTER JOIN [dbo].[NSCARB_SUBSIDIARIES] sub ON [sub].SUBSIDIARY_ID = [tl].SUBSIDIARY_ID								
LEFT OUTER JOIN [dbo].[NSCARB_CURRENCIES] [c] WITH (NOLOCK) ON [c].[CURRENCY_ID] = [t].CURRENCY_ID
--this is added since there are multiple exchange rate for the month of june								
LEFT OUTER JOIN 
				(SELECT * FROM 
				(
				SELECT NSCARB_CURRENCYRATES .*, ROW_NUMBER() OVER (PARTITION BY BASE_CURRENCY_ID, CURRENCY_ID,YEAR(DATE_EFFECTIVE),MONTH(DATE_EFFECTIVE)	ORDER BY YEAR(DATE_EFFECTIVE), MONTH(DATE_EFFECTIVE)) Row_number_for_one_curr
				FROM NSCARB_CURRENCYRATES 
				)inner_cr
				)cr
 ON [cr].CURRENCY_ID = [c].CURRENCY_ID AND [cr].BASE_CURRENCY_ID = [sub].BASE_CURRENCY_ID AND  MONTH([cr].DATE_EFFECTIVE)  = MONTH([t].trandate) AND YEAR([cr].DATE_EFFECTIVE)  = YEAR([t].trandate) 	AND cr.Row_number_for_one_curr = 1							
LEFT OUTER JOIN [dbo].[NSCARB_CONSOLIDATED_EXCHANGE_RATES] [cer] ON [cer].ACCOUNTING_PERIOD_ID = [ap].ACCOUNTING_PERIOD_ID AND [sub].SUBSIDIARY_ID = [cer].FROM_SUBSIDIARY_ID AND [cer].TO_SUBSIDIARY_ID =1 								
 								
								
								
								
 								
WHERE 1=1								
AND [t].[TRANSACTION_TYPE]='invoice'								
--AND [t].[TRANDATE] BETWEEN '2016/04/01' AND '2016/04/30'								
AND [tl].[ITEM_ID] IS NOT NULL															
AND [gl].[TYPE_NAME] IN ('income','deferred revenue')								
--and t.TRANID ='210068295'		
AND (CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].[Customer]
			 ELSE [customer].COMPANYNAME
		END)	<> 'FX Correction Customer (DO NOT USE)'					
								
 GROUP BY  	
	[il_cl].Item_Type
,	[tlink].Item_Type 						
,	[t].[TRANDATE]								
,	[ap].NAME	
,	[ap].starting							
,	[gl].NAME								
,	[i].[NAME]								
,	[il_cl].[INVOICE_RECORD_ID]							
,	[bpg].LIST_ITEM_NAME	
,	[pt].LIST_ITEM_NAME	
,	[tc].LIST_ITEM_NAME	
,	[il_cl].CONTRACT_ID
,	[il_cl].CONTRACT_LINE_ID
,	[t].tranid	
,	[t].transaction_id
,	[t].STATUS
,	sub.SUBSIDIARY_ID
,	[il_cl].START_DATE
,	[il_cl].END_DATE
,	[il_cl].CANCELLATION_DATE
,	[il_cl].SUPERSEDED_BY_ID
,	[il_cl].SUPERSEDES_ID	
,	[t_so].tranid
,	( CASE WHEN [il_cl].[INVOICE_RECORD_ID] IS NULL THEN [ot].[LIST_ITEM_NAME]								
		WHEN  [il_cl].End_Of_Term_Action = 'Perpetual' THEN 'Auto-Renew'						
		ELSE [il_cl].contracted_item_order_line_type						
	END	)						
 	
,	(CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].Item_Type
		  WHEN  [tlink].Item_Type = 'Non Contracted Item'  THEN [tlink].Item_Type
		  ELSE 'UNKNOWN' 
	END )

,	(CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].[Customer]
		  ELSE [customer].COMPANYNAME
	 END) 

,	(CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].Reseller
		  ELSE [reseller].COMPANYNAME
	END) 


,	(CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].[End_User]
	      ELSE  [End User].COMPANYNAME
	END)

,	(CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].[Customer_End User]
	      ELSE  COALESCE([end user].[COMPANYNAME], [customer].[COMPANYNAME]) 
	END)

,		(CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].[Customer_id]
			 ELSE [customer].[CUSTOMER_ID]
		END) 

,		(CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].[Reseller_id]
			 ELSE [reseller].[CUSTOMER_ID]
		END) 


,		(CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].[End_User_id]
			 ELSE  [End User].[CUSTOMER_ID]
		END) 


,		(CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].[Customer_End User_id]
			 ELSE  COALESCE([end user].[CUSTOMER_ID], [customer].[CUSTOMER_ID]) 
		END) 

,	COALESCE((CASE WHEN [i].Name LIKE '%MSP%' THEN 'Royalty' ELSE [bpg].LIST_ITEM_NAME END), p.Product_name )	
,	fin.Finance_Product_Grouping_name	
,	sub.NAME	
,		[customer].[SALESFORCE_ID] 
,		[reseller].[SALESFORCE_ID] 
,		[end user].[SALESFORCE_ID] 
,		[sfdc_end_user].GEO__C
,	(CASE
              WHEN (CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].[End_User_id]
					ELSE  [End User].[CUSTOMER_ID]
					END) IS NULL THEN 'Direct'
              WHEN (CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].[End_User_id]
					ELSE  [End User].[CUSTOMER_ID]
					END) = (CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].[Customer_id]
							ELSE [customer].[CUSTOMER_ID]
							END) THEN 'Direct'
              WHEN (CASE WHEN  [il_cl].Item_Type ='Contracted Item' THEN [il_cl].[End_User_id]
					ELSE  [End User].[CUSTOMER_ID]
					END) IS NOT NULL THEN 'Indirect'
              ELSE
                     'Unknown'
       END)
,	[c].symbol
,		t.EXCHANGE_RATE
,		cer.AVERAGE_RATE


	UNION ALL	

							
--Where Gl TYpe name is only in Income							
SELECT	 'JE'		AS Source_type
		, NULL
		, NULL
		, 'JE' AS Product_hierarchy
		, NULL AS customer
		, NULL AS reseller
		, NULL AS end_user
		, NULL AS customer_end_user
		, NULL AS customer_id
		, NULL AS reseller_id
		, NULL AS end_user_id
		, NULL AS customer_end_user_id
		, NULL AS Channel_Type
		, NULL [Customer_SFDC_ID]
		, NULL [Reseller_SFDC_ID]
		, NULL [End_User_SFDC_ID]
		, NULL [Customer_End_User_SFDC_ID]
		, NULL GEO__C
		, NULL subsidiary
		, [t].TRANDATE
		, [t].TRANID
		, [t].TRANSACTION_ID
		, [t].STATUS
		, NULL AS CM_reason_code
		, NULL AS CM_original_invoice_id
		, [ap].NAME
		, [ap].STARTING Accounting_period_start_date
		, [gl].NAME gl_name
		, NULL AS CONTRACT_ID
		, NULL AS CONTRACT_LINE_ID
		, NULL AS Contract_start_date
		, NULL AS contract_end_date
		, NULL AS CANCELLATION_DATE
		, NULL AS SUPERSEDED_BY_ID
		, NULL AS SUPERSEDES_ID
		, NULL Sales_order_number
		, [i].NAME AS item_name
		, [pt].LIST_ITEM_NAME product_type_name
		, [tc].LIST_ITEM_NAME TAV_category_name
		, [bpg].LIST_ITEM_NAME booking_product_group_name
		, COALESCE( (CASE WHEN [i].NAME LIKE '%MSP%' THEN 'Royalty' ELSE [bpg].LIST_ITEM_NAME END ), p.Product_name)	AS custom_prod_grouping
		, [fin].Finance_Product_Grouping_name Finance_Product_grouping
		, 'Renewal' AS order_type
		, 'Renewal' AS Subscription_Type
		, NULL AS customer_sort
		, NULL customer_type
		, NULL AS Bill_to_customer_sort
		, NULL AS Bill_to_customer_type
		, [c].SYMBOL Foreign_currency_Symbol
		, SUM(0 - [tl].AMOUNT_FOREIGN)				AS amount_foreign
		, [t].EXCHANGE_RATE
		, [cer].AVERAGE_RATE
		, SUM(0 - [tl].AMOUNT * [cer].AVERAGE_RATE)	AS Invoice_Journal_amount_usd
FROM [dbo].NSCARB_TRANSACTIONS t
	INNER JOIN [dbo].NSCARB_TRANSACTION_LINES tl
			ON [t].TRANSACTION_ID = [tl].TRANSACTION_ID
	LEFT OUTER JOIN [dbo].NSCARB_ITEMS i
			ON [tl].ITEM_ID = [i].ITEM_ID
	LEFT OUTER JOIN [dbo].NSCARB_BOOKING_PRODUCT_GROUP [bpg] WITH ( NOLOCK )
			ON [bpg].[LIST_ID] = [i].[BOOKING_PRODUCT_GROUP_ID]
	LEFT OUTER JOIN NSCARB_PRODUCT_TYPE pt
			ON [pt].LIST_ID = [i].PRODUCT_TYPE_ID
	LEFT OUTER JOIN NSCARB_TAV_CATEGORY tc
			ON [tc].LIST_ID = [i].TAV_CATEGORY_ID
	LEFT OUTER JOIN [dbo].NSCARB_ACCOUNTING_PERIODS [ap] WITH ( NOLOCK )
			ON [ap].[ACCOUNTING_PERIOD_ID] = [t].ACCOUNTING_PERIOD_ID
	LEFT OUTER JOIN [dbo].NSCARB_ACCOUNTS [gl] WITH ( NOLOCK )
			ON [gl].[ACCOUNT_ID] = [tl].ACCOUNT_ID
	LEFT JOIN [dbo].NSCARB_SUBSIDIARIES sub
			ON [sub].SUBSIDIARY_ID = [tl].SUBSIDIARY_ID
	LEFT OUTER JOIN [dbo].EV_Custom_GL_Product p
			ON p.GL_Name = [gl].NAME
	LEFT OUTER JOIN [dbo].[EV_Custom_Finance_Product_Group] fin
			ON [fin].Custom_Prodct_grouping_name = COALESCE((CASE WHEN [i].NAME LIKE '%MSP%' THEN 'Royalty'	ELSE [bpg].LIST_ITEM_NAME END), p.Product_name)
	LEFT OUTER JOIN [dbo].NSCARB_CONSOLIDATED_EXCHANGE_RATES cer
			ON [cer].ACCOUNTING_PERIOD_ID = [ap].ACCOUNTING_PERIOD_ID
				AND [sub].SUBSIDIARY_ID = [cer].FROM_SUBSIDIARY_ID
				AND [cer].TO_SUBSIDIARY_ID = 1
	LEFT OUTER JOIN [dbo].[NSCARB_CURRENCIES] [c] WITH ( NOLOCK )
			ON [c].[CURRENCY_ID] = [t].CURRENCY_ID
	LEFT OUTER JOIN [dbo].NSCARB_CUSTOMERS cus
			ON [cus].CUSTOMER_ID = [t].ENTITY_ID
	WHERE	1 = 1
			AND [t].TRANSACTION_TYPE IN ( 'journal' )													
			AND ([gl].NAME NOT IN ('Sales Tax Liability', 'Accrued Value Added Tax','VAT on Sales')		OR		[gl].NAME IS NULL)
			AND [t].TRANID IN (								
					--Q1 2016 JE#s	
					--STX invoices				
					'910011955', '910011956', '910011957', '910011958', '910011959','910011960', '910011961', '910011962', '910011963', '910011964','910011965', '910011966', '910011921', '910011922', '910012190',
								'910011942',
					--acured billing								
								'910012195', '910012193',
					--MRR Accrual									
								'910012294', '910012296', '910012300',

					--Revenue Reserves								
								'910012371', '910012374', '910012342', '910012343',	
							
					--April 2016 JE##	
					--April Credir Card							
								'910012511',								

					--MSP Accrual								
								'910012201', '910012202', '910012543', '910012545', '910012541','910012539',								
								
					--MRR Deferred net to revenue								
								'910012295', '910012301', '910012297', '910012512', '910012514',								

					--Revenue Reserve							
								'910012353', '910012352', '910012688', '910012683', '910012640'--May 2016 JE#

					--plus STX invoice(s) - Credit Card Invoices
					, '910012756'--plus accrued billings - MSP Accrual Net
					, '910012542', '910012546', '910012540', '910012544', '910012822', '910012820',
								'910012824'----May MRR Deferred Amount - Net to revenue Question: why only income is added in here
					, '910012513', '910012515', '910012759', '910012757'--Reserve
					, '910012893', '910012892', '910012897'--June JE##

					--June: MRR deferral and accrual entry in June for May activity
					, '910012760', '910012758'--June: plus accrued billings - MSP Accrual Net
					, '910012823', '910012821', '910012825', '910013144', '910013148', '910013146'
					
					--July:MRR deferral and accrual entry in July for June activity
					,'910013149','910013147','910013145','910013447','910013451','910013449' --plus accrued billings - MSP Accrual Net

					--July Shaun's CM Fix-410004368-Duplicate CM-Impacted AR
					,'910013368'

					--Aug: plus accrued billings - MSP Accrual Net
					,'910013450','910013452','910013448','910013854','910013859','910013852' 

					--Sept:plus accrued billings - MSP Accrual Net
					,'910014322','910014324','910014326','910013855','910013860','910013853' 
					
					 )

			AND [gl].TYPE_NAME IN ( 'income' )
GROUP BY  [t].TRANDATE
		, [ap].NAME
		, [ap].STARTING
		, [i].NAME
		, [bpg].[LIST_ITEM_NAME]
		, [gl].NAME
		, [cus].SALESFORCE_ID
		, [t].TRANSACTION_TYPE
		, [t].TRANSACTION_ID
		, [bpg].LIST_ITEM_NAME
		, [pt].LIST_ITEM_NAME
		, [tc].LIST_ITEM_NAME
		, [t].TRANID
		, p.Product_name
		, [fin].Finance_Product_Grouping_name
		, [t].TRANSACTION_ID
		, [t].STATUS
		, [c].SYMBOL
		, [t].EXCHANGE_RATE
		, [cer].AVERAGE_RATE

UNION ALL

--Where GL TYpe name = Deferred Revenue
SELECT	 'JE'		AS Source_type
		, NULL
		, NULL
		, 'JE' AS Product_hierarchy
		, NULL AS customer
		, NULL AS reseller
		, NULL AS end_user
		, NULL AS customer_end_user
		, NULL AS customer_id
		, NULL AS reseller_id
		, NULL AS end_user_id
		, NULL AS customer_end_user_id
		, NULL AS Channel_type
		, NULL [Customer_SFDC_ID]
		, NULL [Reseller_SFDC_ID]
		, NULL [End_User_SFDC_ID]
		, NULL [Customer_End_User_SFDC_ID]
		, NULL GEO__C
		, NULL subsidiary
		, [t].TRANDATE
		, [t].TRANID
		, [t].TRANSACTION_ID
		, [t].STATUS
		, NULL AS CM_reason_code
		, NULL AS CM_original_invoice_id
		, [ap].NAME
		, [ap].STARTING Accounting_period_start_date
		, [gl].NAME gl_name
		, NULL AS CONTRACT_ID
		, NULL AS CONTRACT_LINE_ID
		, NULL AS Contract_start_date
		, NULL AS Contract_end_date
		, NULL AS CANCELLATION_DATE
		, NULL AS SUPERSEDED_BY_ID
		, NULL AS SUPERSEDES_ID
		, NULL Sales_order_number
		, [i].NAME AS item_name
		, [pt].LIST_ITEM_NAME product_type_name
		, [tc].LIST_ITEM_NAME TAV_category_name
		, [bpg].LIST_ITEM_NAME booking_product_group_name
		, COALESCE(( CASE	WHEN [i].NAME LIKE '%MSP%' THEN 'Royalty' ELSE [bpg].LIST_ITEM_NAME	END ), p.Product_name)		AS custom_prod_grouping
		, [fin].Finance_Product_Grouping_name Finance_Product_grouping
		, 'Renewal' AS order_type
		, 'Renewal' AS Subscription_Type
		, NULL AS customer_sort
		, NULL customer_type
		, NULL AS Bill_to_customer_sort
		, NULL AS Bill_to_customer_type
		, [c].SYMBOL Foreign_currency_Symbol
		, CASE	WHEN [t].TRANID = '910012599' THEN ( -155173.88 + 81033 ) --April S&M with no PO
				WHEN [t].TRANID = '910012828'
				THEN ( -108249.97 + 207797 - 7250 )  -- MAy S&M with no PO
				WHEN [t].TRANID = '910013159' THEN ( 253053 - 152975 )--June S&M with no PO
				ELSE SUM(0 - [tl].AMOUNT_FOREIGN)
			END AS amount_foreign
		, [t].EXCHANGE_RATE
		, [cer].AVERAGE_RATE
		, CASE	WHEN [t].TRANID = '910012599' THEN ( -155173.88 + 81033 ) --April S&M with no PO
				WHEN [t].TRANID = '910012828'
				THEN ( -108249.97 + 207797 - 7250 )  -- MAy S&M with no PO
				WHEN [t].TRANID = '910013159' THEN ( 253053 - 152975 )--June S&M with no PO
					ELSE SUM(0 - [tl].AMOUNT * [cer].AVERAGE_RATE)
			END AS Invoice_Journal_amount_usd
FROM	[dbo].NSCARB_TRANSACTIONS t
	INNER JOIN [dbo].NSCARB_TRANSACTION_LINES tl
			ON [t].TRANSACTION_ID = [tl].TRANSACTION_ID
	LEFT OUTER JOIN [dbo].NSCARB_ITEMS i
			ON [tl].ITEM_ID = [i].ITEM_ID
	LEFT OUTER JOIN [dbo].NSCARB_BOOKING_PRODUCT_GROUP [bpg] WITH ( NOLOCK )
			ON [bpg].[LIST_ID] = [i].[BOOKING_PRODUCT_GROUP_ID]
	LEFT OUTER JOIN NSCARB_PRODUCT_TYPE pt
			ON [pt].LIST_ID = [i].PRODUCT_TYPE_ID
	LEFT OUTER JOIN NSCARB_TAV_CATEGORY tc
			ON [tc].LIST_ID = [i].TAV_CATEGORY_ID
	LEFT OUTER JOIN [dbo].NSCARB_ACCOUNTING_PERIODS [ap] WITH ( NOLOCK )
			ON [ap].[ACCOUNTING_PERIOD_ID] = [t].ACCOUNTING_PERIOD_ID
	LEFT OUTER JOIN [dbo].NSCARB_ACCOUNTS [gl] WITH ( NOLOCK )
			ON [gl].[ACCOUNT_ID] = [tl].ACCOUNT_ID
	LEFT JOIN [dbo].NSCARB_SUBSIDIARIES sub
			ON [sub].SUBSIDIARY_ID = [tl].SUBSIDIARY_ID
	LEFT OUTER JOIN [dbo].EV_Custom_GL_Product p
			ON p.GL_Name = [gl].NAME
	LEFT OUTER JOIN [dbo].[EV_Custom_Finance_Product_Group] fin
			ON [fin].Custom_Prodct_grouping_name = COALESCE((CASE WHEN [i].NAME LIKE '%MSP%' THEN 'Royalty' ELSE [bpg].LIST_ITEM_NAME END ), p.Product_name)
	LEFT OUTER JOIN [dbo].NSCARB_CONSOLIDATED_EXCHANGE_RATES cer
			ON [cer].ACCOUNTING_PERIOD_ID = [ap].ACCOUNTING_PERIOD_ID
				AND [sub].SUBSIDIARY_ID = [cer].FROM_SUBSIDIARY_ID
				AND [cer].TO_SUBSIDIARY_ID = 1
	LEFT OUTER JOIN [dbo].[NSCARB_CURRENCIES] [c] WITH (NOLOCK)
			ON [c].[CURRENCY_ID] = [t].CURRENCY_ID
	LEFT OUTER JOIN [dbo].NSCARB_CUSTOMERS cus
			ON [cus].CUSTOMER_ID = [t].ENTITY_ID
	WHERE	1 = 1
			AND [t].TRANSACTION_TYPE IN ( 'journal' )								
--and [ap].NAME in ('Jan 2016','Feb 2016','Mar 2016')								
			AND ( [gl].NAME NOT IN ( 'Sales Tax Liability','Accrued Value Added Tax','VAT on Sales' )
					OR [gl].NAME IS NULL )
			AND [t].TRANID IN (	
								--Q1 S&M with no PO								
											'910012425',	
								--Q1 MRR Accrual
											'910012294', '910012296', '910012300',						
					
								--April S&M with no PO 
											'910012599'--May S&M Renewals with no PO

								, '910012828', '910013159'
								-- July S&M $166k entry not in Purchase Entry
								,'910013698'
								--September: Move Pasha Group out of Deferred and into Seagate Payable
								,'910014705'
								 )

			AND [gl].TYPE_NAME IN ( 'Deferred Revenue' )
GROUP BY [t].TRANDATE
		, [ap].NAME
		, [ap].STARTING
		, [i].NAME
		, [bpg].[LIST_ITEM_NAME]
		, [gl].NAME
		, [cus].SALESFORCE_ID
		, [t].TRANSACTION_TYPE
		, [t].TRANSACTION_ID
		, [bpg].LIST_ITEM_NAME
		, [pt].LIST_ITEM_NAME
		, [tc].LIST_ITEM_NAME
		, [t].TRANID
		, p.Product_name
		, [fin].Finance_Product_Grouping_name
		, [t].TRANSACTION_ID
		, [t].STATUS
		, [c].SYMBOL
		, [t].EXCHANGE_RATE
		, [cer].AVERAGE_RATE

UNION ALL

--with JE Logic
SELECT	'JE' AS Source_type
		, NULL
		, NULL
		, 'JE' AS Product_hierarchy
		, NULL AS customer
		, NULL AS reseller
		, NULL AS end_user
		, NULL AS customer_end_user
		, NULL AS customer_id
		, NULL AS reseller_id
		, NULL AS end_user_id
		, NULL AS customer_end_user_id
		, NULL AS Channel_type
		, NULL [Customer_SFDC_ID]
		, NULL [Reseller_SFDC_ID]
		, NULL [End_User_SFDC_ID]
		, NULL [Customer_End_User_SFDC_ID]
		, NULL GEO__C
		, NULL subsidiary
		, [t].TRANDATE
		, [t].TRANID
		, [t].TRANSACTION_ID
		, [t].STATUS
		, NULL AS CM_reason_code
		, NULL AS CM_original_invoice_id
		, [ap].NAME Accounting_period_start_date
		, [ap].STARTING
		, [gl].NAME gl_name
		, NULL AS CONTRACT_ID
		, NULL AS CONTRACT_LINE_ID
		, NULL AS Contract_start_date
		, NULL AS Contract_end_date
		, NULL AS CANCELLATION_DATE
		, NULL AS SUPERSEDED_BY_ID
		, NULL AS SUPERSEDES_ID
		, NULL Sales_order_number
		, [i].NAME AS item_name
		, [pt].LIST_ITEM_NAME product_type_name
		, [tc].LIST_ITEM_NAME TAV_category_name
		, [bpg].LIST_ITEM_NAME booking_product_group_name
		, COALESCE((CASE WHEN [i].NAME LIKE '%MSP%' THEN 'Royalty' ELSE [bpg].LIST_ITEM_NAME END), p.Product_name)	AS custom_prod_grouping
		, [fin].Finance_Product_Grouping_name Finance_Product_grouping
		, 'Renewal' AS order_type
		, 'Renewal' AS Subscription_Type
		, NULL AS customer_sort
		, NULL customer_type
		, NULL AS Bill_to_customer_sort
		, NULL AS Bill_to_customer_type
		, [c].SYMBOL Foreign_currency_Symbol

		,(CASE WHEN  [t].TRANID = '910013160' THEN 129698.15 --July eliminating Reserval entry and adding S&M Renewals no PO taken off hold  (payment received)
			  WHEN [t].TRANID = '910013504' THEN (-373448.86 +129520  ) --Aug eliminating Reserval entry and adding S&M Renewals no PO taken off hold  (payment received) and FX Issue - adjustment to revenue in August
			  WHEN [t].TRANID = '910013873' THEN 93557.06 --Sept eliminating Reserval entry and adding S&M Renewals no PO taken off hold  (payment received)
			ELSE SUM(0 - [tl].AMOUNT_FOREIGN)
			END
		   ) AS amount_foreign
		, [t].EXCHANGE_RATE
		, [cer].AVERAGE_RATE
		,(CASE WHEN  [t].TRANID = '910013160' THEN 129698.15 --July eliminating Reserval entry and adding S&M Renewals no PO taken off hold  (payment received)
			  WHEN [t].TRANID = '910013504' THEN (-373448.86 +129520  ) --Aug eliminating Reserval entry and adding S&M Renewals no PO taken off hold  (payment received) and FX Issue - adjustment to revenue in August
			  WHEN [t].TRANID = '910013873' THEN 93557.06 --Sept eliminating Reserval entry and adding S&M Renewals no PO taken off hold  (payment received)
			ELSE SUM(0 - [tl].AMOUNT * [cer].AVERAGE_RATE)
			END
		   ) AS Invoice_Journal_amount_usd

FROM	[dbo].NSCARB_TRANSACTIONS t
	INNER JOIN [dbo].NSCARB_TRANSACTION_LINES tl
			ON [t].TRANSACTION_ID = [tl].TRANSACTION_ID
	LEFT OUTER JOIN [dbo].NSCARB_ITEMS i
			ON [tl].ITEM_ID = [i].ITEM_ID
	LEFT OUTER JOIN [dbo].NSCARB_BOOKING_PRODUCT_GROUP [bpg] WITH ( NOLOCK )
			ON [bpg].[LIST_ID] = [i].[BOOKING_PRODUCT_GROUP_ID]
	LEFT OUTER JOIN NSCARB_PRODUCT_TYPE pt
			ON [pt].LIST_ID = [i].PRODUCT_TYPE_ID
	LEFT OUTER JOIN NSCARB_TAV_CATEGORY tc
			ON [tc].LIST_ID = [i].TAV_CATEGORY_ID
	LEFT OUTER JOIN [dbo].NSCARB_ACCOUNTING_PERIODS [ap] WITH ( NOLOCK )
			ON [ap].[ACCOUNTING_PERIOD_ID] = [t].ACCOUNTING_PERIOD_ID
	LEFT OUTER JOIN [dbo].NSCARB_ACCOUNTS [gl] WITH ( NOLOCK )
			ON [gl].[ACCOUNT_ID] = [tl].ACCOUNT_ID
	LEFT JOIN [dbo].NSCARB_SUBSIDIARIES sub
			ON [sub].SUBSIDIARY_ID = [tl].SUBSIDIARY_ID
	LEFT OUTER JOIN [dbo].EV_Custom_GL_Product p
			ON p.GL_Name = [gl].NAME
	LEFT OUTER JOIN [dbo].[EV_Custom_Finance_Product_Group] fin
			ON [fin].Custom_Prodct_grouping_name = COALESCE((CASE WHEN [i].NAME LIKE '%MSP%' THEN 'Royalty' ELSE [bpg].LIST_ITEM_NAME END),	p.Product_name)
	LEFT OUTER JOIN [dbo].NSCARB_CONSOLIDATED_EXCHANGE_RATES cer
			ON [cer].ACCOUNTING_PERIOD_ID = [ap].ACCOUNTING_PERIOD_ID
				AND [sub].SUBSIDIARY_ID = [cer].FROM_SUBSIDIARY_ID
				AND [cer].TO_SUBSIDIARY_ID = 1
	LEFT OUTER JOIN [dbo].[NSCARB_CURRENCIES] [c] WITH (NOLOCK)
			ON [c].[CURRENCY_ID] = [t].CURRENCY_ID
	LEFT OUTER JOIN [dbo].NSCARB_CUSTOMERS cus
			ON [cus].CUSTOMER_ID = [t].ENTITY_ID
	WHERE	1 = 1
			AND t.transaction_type  IN ('journal')								
--and ap.NAME in ('Jan 2016','Feb 2016','Mar 2016')								
AND ([gl].NAME NOT IN ('Sales Tax Liability','Accrued Value Added Tax','VAT on Sales') OR [gl].NAME IS NULL)															
AND ((gl.name IN ('Reserve','Hardware Warranty - Contra') AND MONTH(t.TRANDATE)>=6 AND YEAR(t.TRANDATE)>=2016) OR tl.MEMO LIKE  '%Bookings Bottoms Up%')
AND (gl.TYPE_NAME IN ('Income') 	OR (gl.TYPE_NAME IN('Deferred Revenue')  AND gl.NAME IN('S/T Deferred Rev - Support and Maintenance')) )

GROUP BY [t].TRANDATE
		, [ap].NAME
		, [ap].STARTING
		, [i].NAME
		, [bpg].[LIST_ITEM_NAME]
		, [gl].NAME
		, [cus].SALESFORCE_ID
		, [t].TRANSACTION_TYPE
		, [t].TRANSACTION_ID
		, [bpg].LIST_ITEM_NAME
		, [pt].LIST_ITEM_NAME
		, [tc].LIST_ITEM_NAME
		, [t].TRANID
		, p.Product_name
		, [fin].Finance_Product_Grouping_name
		, [t].TRANSACTION_ID
		, [t].STATUS
		, [c].SYMBOL
		, [t].EXCHANGE_RATE
		, [cer].AVERAGE_RATE
				










