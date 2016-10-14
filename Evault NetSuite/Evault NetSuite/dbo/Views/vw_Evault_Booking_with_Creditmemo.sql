






CREATE VIEW [dbo].[vw_Evault_Booking_with_Creditmemo] AS

SELECT * FROM dbo.vw_Evault_Booking
UNION ALL

SELECT 
'CM' AS Source_type	
,NULL AS Contracted_Item_Type
,NULL AS NonContracted_Item_Type
,'CM' AS  Item_Type	
,Cm.customer_name
,cm.reseller_name
,cm.enduser_name
,cm.customer_enduser_name
,cm.cm_entity_id customer_id
,cm.cm_reseller_id
,cm.cm_end_user_id
,cm.cm_end_cus_id customer_enduser_id
,CASE
              WHEN cm.enduser_name IS NULL THEN 'Direct'
              WHEN cm.enduser_name = Cm.customer_name THEN 'Direct'
              WHEN cm.enduser_name IS NOT NULL THEN 'Indirect'
              ELSE
                     'Unknown'
       END Channel_type

,cm.customer_sfdc_id AS  [Customer_SFDC_ID]
,cm.reseller_sfdc_id AS  [Reseller_SFDC_ID]
,cm.enduser_sfdc_id AS [End_User_SFDC_ID]
,cm.customer_enduser_sfdc_id [Customer_End_user_SFDC_ID]
,cm.GEO__C AS GEO__C
,cm_subsidiary
,cm.cm_trandate	
,cm.cm_tranid
,cm.cm_transaction_id
,cm.STATUS
,cm_DELEGATION_OF_AUTHORITY__CM_NA AS CM_reason_code
,cm.ORIGINAL_INVOICE_NO__ID AS CM_original_invoice_id										
,cm.cm_ap_name AS accounting_period	
,cm.cm_Accounting_period_start_date								
,cm.cm_gl_name AS GL_Name	
,NULL AS CONTRACT_ID
,NULL AS CONTRACT_LINE_ID
,NULL AS contract_start_date
,NULL AS contract_end_date
,NULL AS contract_cancellation_date
,NULL AS SUPERSEDED_BY_ID
,NULL AS SUPERSEDES_ID	
, NULL AS Sales_order_Number
,cm.cm_item_name AS item_name	
,NULL AS	Product_type_name	
,NULL AS  TAV_category_name					
,cm.cm_bpg_name AS booking_product_group_name	
,cm.cm_custom_prod_grouping
,cm.cm_Finance_Product_grouping
,eb.order_type
,CASE WHEN eb.Subscription_Type IS NULL THEN 'Renewal' -- this to bucket the credit memo which cannot be tied back to any invoice so defaulting it to renewal
 ELSE eb.Subscription_Type END
, NULL AS Customer_Sort
,NULL AS Customer_type
, NULL AS Bill_to_Customer_Sort
,NULL AS Bill_to_Customer_type
,cm.SYMBOL Foreign_currency_Symbol
, cm.cm_amount_foreign
, cm.EXCHANGE_RATE
,cm.AVERAGE_RATE
, cm.cm_Invoice_Journal_amount_usd

 FROM (
				SELECT 								
				t.TRANDATE	cm_trandate	
				, t.tranid	cm_tranid
				,t.TRANSACTION_ID	cm_transaction_id
				,t.STATUS
				,t.ORIGINAL_INVOICE_NO__ID	
				,sub.NAME cm_subsidiary		
				,ap.NAME	cm_ap_name	
				,ap.starting	AS cm_Accounting_period_start_date						
				,gl.NAME	cm_gl_name				
				,i.NAME AS cm_item_name	
				,bpg.LIST_ITEM_NAME cm_bpg_name
				,t.ENTITY_ID cm_entity_id
				,t.RESELLER_ID cm_reseller_id
				,t.END_USER_CUSTOMER_ID	 cm_end_user_id
				,COALESCE(t.END_USER_CUSTOMER_ID, t.ENTITY_ID) cm_end_cus_id
				,[customer].COMPANYNAME customer_name
				,[reseller].COMPANYNAME reseller_name
				,[End User].COMPANYNAME  enduser_name
				,COALESCE([end user].[COMPANYNAME], [customer].[COMPANYNAME]) customer_enduser_name
				,[customer].SALESFORCE_ID customer_sfdc_id
				,[reseller].SALESFORCE_ID reseller_sfdc_id
				,[End User].SALESFORCE_ID  enduser_sfdc_id
				,COALESCE([End User].SALESFORCE_ID, [customer].SALESFORCE_ID) customer_enduser_sfdc_id
				,[sfdc_end_user].GEO__C
				,doa.DELEGATION_OF_AUTHORITY__CM_NA			cm_DELEGATION_OF_AUTHORITY__CM_NA						
				,COALESCE((CASE WHEN [i].Name LIKE '%MSP%' THEN 'Royalty' ELSE [bpg].LIST_ITEM_NAME END), p.Product_name )		cm_custom_prod_grouping
				,fin.Finance_Product_Grouping_name	cm_Finance_Product_grouping
				,[c].SYMBOL
				,SUM(0-tl.AMOUNT_FOREIGN)  AS cm_amount_foreign	
				,t.EXCHANGE_RATE
				,cer.AVERAGE_RATE				
				, SUM(0-tl.amount*cer.AVERAGE_RATE) AS cm_Invoice_Journal_amount_usd					
								
															
				FROM dbo.NSCARB_TRANSACTIONS t								
				INNER JOIN dbo.NSCARB_TRANSACTION_LINES tl ON t.transaction_id = tl.TRANSACTION_ID								
								
				LEFT OUTER JOIN dbo.NSCARB_ITEMS i ON tl.ITEM_ID = i.ITEM_ID								
				LEFT OUTER JOIN dbo.NSCARB_BOOKING_PRODUCT_GROUP [bpg] WITH (NOLOCK) ON [bpg].[LIST_ID] = [i].[BOOKING_PRODUCT_GROUP_ID]													
								
				LEFT OUTER JOIN dbo.NSCARB_ACCOUNTING_PERIODS [ap] WITH (NOLOCK) ON [ap].[ACCOUNTING_PERIOD_ID] = t.ACCOUNTING_PERIOD_ID								
				LEFT OUTER JOIN dbo.NSCARB_ACCOUNTS [gl] WITH (NOLOCK) ON [gl].[ACCOUNT_ID] = tl.ACCOUNT_ID								
				LEFT JOIN dbo.NSCARB_SUBSIDIARIES sub ON sub.SUBSIDIARY_ID = tl.SUBSIDIARY_ID	
				LEFT OUTER JOIN dbo.EV_Custom_GL_Product p ON p.GL_Name = [GL].NAME		
				LEFT OUTER JOIN [dbo].[EV_Custom_Finance_Product_Group] fin ON fin.Custom_Prodct_grouping_name 	= COALESCE((CASE WHEN [i].Name LIKE '%MSP%' THEN 'Royalty' ELSE [bpg].LIST_ITEM_NAME END), p.Product_name )			
								
				LEFT OUTER JOIN dbo.NSCARB_CONSOLIDATED_EXCHANGE_RATES cer ON cer.ACCOUNTING_PERIOD_ID = ap.ACCOUNTING_PERIOD_ID AND sub.SUBSIDIARY_ID = cer.FROM_SUBSIDIARY_ID AND cer.TO_SUBSIDIARY_ID =1								
				LEFT OUTER JOIN [dbo].[NSCARB_CURRENCIES] [c] WITH (NOLOCK) ON [c].[CURRENCY_ID] = [t].CURRENCY_ID				
							
				LEFT OUTER JOIN dbo.NSCARB_DELEGATION_OF_AUTHORITY_CM doa ON doa.DELEGATION_OF_AUTHORITY__CM_ID = t.REASON_ID

				LEFT OUTER  JOIN [dbo].[NSCARB_customers] [customer] WITH (NOLOCK) ON [customer].[CUSTOMER_ID] = [t].[ENTITY_ID]
				LEFT OUTER  JOIN [dbo].[NSCARB_customers] [reseller] WITH (NOLOCK) ON [reseller].[CUSTOMER_ID] = [t].[RESELLER_ID]
				LEFT OUTER  JOIN [dbo].[NSCARB_customers] [end user] WITH (NOLOCK) ON [end user].[CUSTOMER_ID] = [t].[END_USER_CUSTOMER_ID]

				LEFT OUTER JOIN [Evault SFDC].[dbo].[EV_SF_Account] [sfdc_end_user] WITH (NOLOCK) ON [sfdc_end_user].[Id] = COALESCE([end user].[SALESFORCE_ID], [customer].[SALESFORCE_ID])
				LEFT OUTER JOIN [Evault SFDC].[dbo].[EV_SF_Account] [sfdc_customer] WITH (NOLOCK) ON [sfdc_customer].[Id] = [customer].[SALESFORCE_ID]
	

				WHERE 1=1								
								
				AND t.transaction_type  IN ('Credit Memo')								
				AND tl.ITEM_ID IS NOT NULL
				AND (doa.DELEGATION_OF_AUTHORITY__CM_NA <>'Bad Debt') 
				AND (doa.DELEGATION_OF_AUTHORITY__CM_NA <>'SW S&M Non-renewal'OR t.TRANID = '410004245')	
				AND gl.NAME NOT IN ('Accrued Value Added Tax')
				AND [customer].COMPANYNAME <> 'FX Correction Customer (DO NOT USE)'	
								
				GROUP BY 								
				t.TRANDATE		
				, t.tranid	
				, t.TRANSACTION_ID				
				,ap.NAME
				,sub.NAME							
				,gl.NAME	
				,i.NAME 
				,bpg.LIST_ITEM_NAME		
				,doa.DELEGATION_OF_AUTHORITY__CM_NA								
				,COALESCE((CASE WHEN [i].Name LIKE '%MSP%' THEN 'Royalty' ELSE [bpg].LIST_ITEM_NAME END), p.Product_name )		
				,fin.Finance_Product_Grouping_name
				,t.ENTITY_ID
				,t.RESELLER_ID
				,t.END_USER_CUSTOMER_ID		
				,t.ORIGINAL_INVOICE_NO__ID
				,[customer].COMPANYNAME 
				,[reseller].COMPANYNAME 
				,[End User].COMPANYNAME  
				,COALESCE([end user].[COMPANYNAME], [customer].[COMPANYNAME]) 
				,[customer].SALESFORCE_ID 
				,[reseller].SALESFORCE_ID 
				,[End User].SALESFORCE_ID  
				,[sfdc_end_user].GEO__C
				,t.STATUS
				,ap.starting
				,[c].SYMBOL
				,t.EXCHANGE_RATE
				,cer.AVERAGE_RATE

			) cm 
			
LEFT OUTER JOIN (SELECT DISTINCT ev.transaction_id,ev.item_name, ev.customer_end_user, ev.order_type, ev.Subscription_Type FROM   dbo.vw_Evault_Booking ev) eb			
			ON eb.transaction_id = cm.ORIGINAL_INVOICE_NO__ID AND eb.item_name=cm.cm_item_name AND eb.customer_end_user = cm.customer_enduser_name




















