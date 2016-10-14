﻿


CREATE PROC [dbo].[Test_sales_booking_report] AS

--drop TABLE #tmp_sales_orders

CREATE TABLE #tmp_sales_orders(
	[ACCOUNTING_APPROVAL__FINAL] [NVARCHAR](1) NULL,
	[ACCOUNTING_BOOK_ID] [FLOAT] NULL,
	[ACCOUNTING_PERIOD_ID] [FLOAT] NULL,
	[ACCOUNT_BASED_NUMBER] [NVARCHAR](138) NULL,
	[ACCRUE_USE_TAX] [NVARCHAR](1) NULL,
	[ADDITIONAL_SHIPPING_ADDRESSES] [NVARCHAR](4000) NULL,
	[AMOUNT_UNBILLED] [FLOAT] NULL,
	[ANNUAL_VALUE_CHANGE] [FLOAT] NULL,
	[APPROVAL_ROUTING_DONE] [NVARCHAR](1) NULL,
	[APPROVED_INVOICE] [NVARCHAR](1) NULL,
	[AP_CONTACT_EMAIL] [NVARCHAR](4000) NULL,
	[AP_CONTACT_NAME] [NVARCHAR](4000) NULL,
	[ASSOC_AUTO_BUNDLE_JE_ID] [FLOAT] NULL,
	[ASSOC_AUTO_COGS_JE_ID] [FLOAT] NULL,
	[BAFF_FILE_SENT] [NVARCHAR](1) NULL,
	[BILLADDRESS] [NVARCHAR](999) NULL,
	[BILLING_ACCOUNT_ID] [FLOAT] NULL,
	[BILLING_INSTRUCTIONS] [NVARCHAR](999) NULL,
	[BILLING_INSTRUCTIONS_0] [NVARCHAR](4000) NULL,
	[BILLTO_ENTITYUSE_CODE_ID] [FLOAT] NULL,
	[BILLTO_LATITUDE] [NVARCHAR](4000) NULL,
	[BILLTO_LONGITUDE] [NVARCHAR](4000) NULL,
	[BILL_PAY_TRANSACTION] [NVARCHAR](3) NULL,
	[BILL_TO_CHANGE] [NVARCHAR](1) NULL,
	[BULK_SUBMISSION_ID] [FLOAT] NULL,
	[CANCELATION_DATE] [DATETIME2](7) NULL,
	[CARRIER] [NVARCHAR](100) NULL,
	[CC_CHARGE_FAILED_] [NVARCHAR](1) NULL,
	[CDR_CERTIFICATION_COMPLETE] [NVARCHAR](1) NULL,
	[CDR_CERTIFICATION_NEEDED] [NVARCHAR](1) NULL,
	[CDR_PROVISIONING_COMPLETE] [NVARCHAR](1) NULL,
	[CDR_PROVISIONING_NEEDED] [NVARCHAR](1) NULL,
	[CLOSED] [DATETIME2](7) NULL,
	[COMPANY_STATUS_ID] [FLOAT] NULL,
	[CONTRACT_BILLING_DAY] [FLOAT] NULL,
	[CONTRACT_BILLING__FREQ_ID] [FLOAT] NULL,
	[CONTRACT_CREDIT_ID] [FLOAT] NULL,
	[CONTRACT_ENDOFTERM_ACTION_ID] [FLOAT] NULL,
	[CONTRACT_ID] [FLOAT] NULL,
	[CONTRACT_LINE_CREATION_DETAIL] [NVARCHAR](4000) NULL,
	[CONTRACT_LINE_CREATION_ID] [FLOAT] NULL,
	[CONTRACT_PAYMENT_METHOD_ID] [FLOAT] NULL,
	[CONTRACT_TERM_MONTHS] [FLOAT] NULL,
	[CONTRACT_WEEKLY_BILLING_DAY_ID] [FLOAT] NULL,
	[CREATED_BY_ID] [FLOAT] NULL,
	[CREATED_FROM_CONTRACT] [NVARCHAR](1) NULL,
	[CREATED_FROM_ID] [FLOAT] NULL,
	[CREATE_DATE] [DATETIME2](7) NULL,
	[CREDENTIAL_EMAIL_PROVISIONING] [NVARCHAR](1) NULL,
	[CREDENTIAL_EMAIL_PROVISIONIN_0] [NVARCHAR](1) NULL,
	[CURRENCY_ID] [FLOAT] NULL,
	[CUSTOMER_TYPE_ID] [FLOAT] NULL,
	[CUSTOM_FORM_ID] [FLOAT] NULL,
	[DAS_SUPPORT_ORDER] [NVARCHAR](1) NULL,
	[DATE_BID_CLOSE] [DATETIME2](7) NULL,
	[DATE_BID_OPEN] [DATETIME2](7) NULL,
	[DATE_LAST_MODIFIED] [DATETIME2](7) NULL,
	[DEAL_ID] [NVARCHAR](4000) NULL,
	[DEAL_TYPE_ID] [FLOAT] NULL,
	[DELIVERY_DATE] [DATETIME2](7) NULL,
	[DISCOUNT_MAPPING] [FLOAT] NULL,
	[DROPSHIP_PO_ID] [FLOAT] NULL,
	[DROPSHIP_SO_ID] [FLOAT] NULL,
	[DUE_DATE] [DATETIME2](7) NULL,
	[EMAIL] [NVARCHAR](256) NULL,
	[END_DATE] [DATETIME2](7) NULL,
	[END_DATE_0] [DATETIME2](7) NULL,
	[END_USER_CUSTOMER_ID] [FLOAT] NULL,
	[END_USER_PO] [NVARCHAR](4000) NULL,
	[ENTITY_ID] [FLOAT] NULL,
	[ENTITY_TAX_REG_NUM] [NVARCHAR](30) NULL,
	[EXCHANGE_RATE] [FLOAT] NULL,
	[EXPECTED_CLOSE] [DATETIME2](7) NULL,
	[EXTERNAL_LINK] [NVARCHAR](255) NULL,
	[EXTERNAL_REF_NUMBER] [NVARCHAR](138) NULL,
	[EXTERNAL_SYNC_DATE] [DATETIME2](7) NULL,
	[FAX] [NVARCHAR](100) NULL,
	[FOB] [NVARCHAR](13) NULL,
	[FORECAST_TYPE] [NVARCHAR](300) NULL,
	[FULFILL_INTEGRATION_ERROR] [NVARCHAR](4000) NULL,
	[INCLUDE_IN_FORECAST] [NVARCHAR](3) NULL,
	[INCOTERM] [NVARCHAR](100) NULL,
	[INSTALLATION_CONTACT_EMAIL] [NVARCHAR](255) NULL,
	[INSTALLATION_CONTACT_ID] [FLOAT] NULL,
	[INSTALLATION_CONTACT_SFDCID] [NVARCHAR](4000) NULL,
	[INSTALLATION_RESPONSIBILITY_ID] [FLOAT] NULL,
	[INTERCOMPANY_TRANSACTION_ID] [FLOAT] NULL,
	[INVOICE_COMMENT] [NVARCHAR](4000) NULL,
	[INVOICE_IN_DISPUTE] [NVARCHAR](1) NULL,
	[INVOICE_LINK_PARENT_ID] [FLOAT] NULL,
	[INVOICE_MESSAGING] [NTEXT] NULL,
	[INVOICE_PRINT_PROCESS_COMPLET] [NVARCHAR](1) NULL,
	[IS_AUTOCALCULATE_LAG] [NVARCHAR](3) NULL,
	[IS_COMPLIANT] [NVARCHAR](3) NULL,
	[IS_FINANCE_CHARGE] [NVARCHAR](3) NULL,
	[IS_FIRMED] [NVARCHAR](3) NULL,
	[IS_INTERCOMPANY] [NVARCHAR](3) NULL,
	[IS_NON_POSTING] [NVARCHAR](3) NULL,
	[IS_PAYMENT_HOLD] [NVARCHAR](3) NULL,
	[IS_REJECT_REASON_ENTERED] [NVARCHAR](1) NULL,
	[IS_REVERSAL] [NVARCHAR](1) NULL,
	[IS_TAX_REG_OVERRIDE] [NVARCHAR](3) NULL,
	[IS_WIP] [NVARCHAR](1) NULL,
	[ITEM_REVISION] [FLOAT] NULL,
	[JE_MEMO] [NVARCHAR](4000) NULL,
	[JOB_ID] [FLOAT] NULL,
	[JOURNAL_ENTRY_ADJUSTED] [NVARCHAR](1) NULL,
	[LANDED_COST_ALLOCATION_METHOD] [NVARCHAR](8) NULL,
	[LAST_MODIFIED_DATE] [DATETIME2](7) NULL,
	[LAST_SALES_ACTIVITY] [DATETIME2](7) NULL,
	[LAST_SALES_ACTIVITY_2] [DATETIME2](7) NULL,
	[LEAD_SOURCE_ID] [FLOAT] NULL,
	[LICENSE_CONTACT_ID] [FLOAT] NULL,
	[LICENSE_CONTACT_SFDCID] [NVARCHAR](4000) NULL,
	[LICENSE_PROVISIONING_NEEDED] [NVARCHAR](1) NULL,
	[LICENSING_PROVISIONING_COMPLE] [NVARCHAR](1) NULL,
	[LOCATION_ID] [FLOAT] NULL,
	[LSA_LINK] [NVARCHAR](255) NULL,
	[LSA_LINK_NAME] [NVARCHAR](4000) NULL,
	[MANAGED_SERVICES_PROVISIONING] [NVARCHAR](1) NULL,
	[MANAGED_SERVICES_PROVISIONIN_0] [NVARCHAR](1) NULL,
	[MEMO] [NVARCHAR](4000) NULL,
	[MEMORIZED] [NVARCHAR](3) NULL,
	[MESSAGE] [NVARCHAR](999) NULL,
	[MIDTIER_SEND_ERROR] [NVARCHAR](4000) NULL,
	[MID_TIER_TICKET_ID_H] [NVARCHAR](4000) NULL,
	[MIGRATED_642_CONTRACT_NAME] [NVARCHAR](4000) NULL,
	[MIGRATED_642_CUSTOMER_ID] [NVARCHAR](4000) NULL,
	[MONTHLY_VALUE_CHANGE] [FLOAT] NULL,
	[MSP_AGREEMENT] [NVARCHAR](1) NULL,
	[NEEDS_BILL] [NVARCHAR](3) NULL,
	[NEEDS_REVENUE_COMMITMENT] [NVARCHAR](3) NULL,
	[NEXT_APPROVER_PRIORITY_LEVEL] [FLOAT] NULL,
	[NO_COTERM] [NVARCHAR](1) NULL,
	[NUMBER_OF_PRICING_TIERS] [FLOAT] NULL,
	[OPENING_BALANCE_TRANSACTION] [NVARCHAR](3) NULL,
	[ORDER_SERVICE_ACTIVATION_COMP] [NVARCHAR](1) NULL,
	[ORDER_TYPE_ID] [FLOAT] NULL,
	[ORIGINALDEBOOKING_NS_ORDER_ID] [FLOAT] NULL,
	[ORIGINALDEBOOKING_NS_ORDER_NU] [NVARCHAR](4000) NULL,
	[ORIGINAL_GP_PO_NUMBER] [NVARCHAR](4000) NULL,
	[ORIGINAL_INVOICE_NO__ID] [FLOAT] NULL,
	[ORIGINAL_NS_INTERNAL_ID] [NVARCHAR](4000) NULL,
	[ORIGINAL_NS_ORDER_DATE] [DATETIME2](7) NULL,
	[ORIGINAL_SB1_STATUS] [NVARCHAR](4000) NULL,
	[ORIGINATING_TRX_FROM_SB1] [NVARCHAR](4000) NULL,
	[PACKING_LIST_INSTRUCTIONS] [NVARCHAR](999) NULL,
	[PARENT_CASE_ID] [FLOAT] NULL,
	[PARTNER_ID] [FLOAT] NULL,
	[PAYMENT_PROCESSOR_ERROR] [NVARCHAR](4000) NULL,
	[PAYMENT_TERMS_ID] [FLOAT] NULL,
	[PICK_UP] [NVARCHAR](1) NULL,
	[PN_REF_NUM] [NVARCHAR](100) NULL,
	[PROBABILITY] [FLOAT] NULL,
	[PROCUREMENT_PROVISIONING_COMP] [NVARCHAR](1) NULL,
	[PROCUREMENT_PROVISIONING_NEED] [NVARCHAR](1) NULL,
	[PRODUCT_LABEL_INSTRUCTIONS] [NVARCHAR](999) NULL,
	[PROJECTED_TOTAL] [FLOAT] NULL,
	[PROMOTION_CODE_ID] [FLOAT] NULL,
	[PROMOTION_CODE_INSTANCE_ID] [FLOAT] NULL,
	[PROMO_QTY_ADJUSTED_DURING_REN] [NVARCHAR](1) NULL,
	[PRO_SERVICES_PROVISIONING_COM] [NVARCHAR](1) NULL,
	[PRO_SERVICES_PROVISIONING_NEE] [NVARCHAR](1) NULL,
	[PURCHASE_ORDER_INSTRUCTIONS] [NVARCHAR](999) NULL,
	[PURCHASING_APPROVAL__FINAL] [NVARCHAR](1) NULL,
	[PURCHASING_APPROVAL__INITIAL] [NVARCHAR](1) NULL,
	[PURCHASING_SHIPTO_ADDRESS] [NVARCHAR](4000) NULL,
	[PURCHASING_SHIPTO_LOCATION_ID] [FLOAT] NULL,
	[QUARTERLY_VALUE_CHANGE] [FLOAT] NULL,
	[QUOTE_APPROVAL_DATE] [DATETIME2](7) NULL,
	[QUOTE_APPROVER] [NVARCHAR](4000) NULL,
	[QUOTE_APPROVER_TITLE] [NVARCHAR](4000) NULL,
	[QUOTE_CREATED_BY] [NVARCHAR](4000) NULL,
	[QUOTE_EXTERNAL_NOTES] [NVARCHAR](4000) NULL,
	[QUOTE_NAME] [NVARCHAR](4000) NULL,
	[QUOTE_PROMOTION_CODE] [NVARCHAR](4000) NULL,
	[QUOTE_SIGNER_EMAIL] [NVARCHAR](4000) NULL,
	[READY_FOR_SALES_FORCE] [NVARCHAR](1) NULL,
	[REASON_ID] [FLOAT] NULL,
	[REBILL_INVOICE_ID] [FLOAT] NULL,
	[REFERRAL_PARTNER_COMMISSION_] [FLOAT] NULL,
	[REFERRAL_PARTNER_ID] [FLOAT] NULL,
	[REJECT_REASON] [NVARCHAR](4000) NULL,
	[RELATED_TRANID] [NVARCHAR](138) NULL,
	[RENEWAL] [DATETIME2](7) NULL,
	[RENEWAL_DATE] [DATETIME2](7) NULL,
	[RENEWAL_TYPE_ID] [FLOAT] NULL,
	[REQUESTER_ID] [FLOAT] NULL,
	[RESELLER_ID] [FLOAT] NULL,
	[RESELLER_PO] [NVARCHAR](4000) NULL,
	[RETRY] [NVARCHAR](1) NULL,
	[RETRY_ATTEMPT] [FLOAT] NULL,
	[RETRY_DATE] [DATETIME2](7) NULL,
	[REVENUE_COMMITMENT_STATUS] [NVARCHAR](480) NULL,
	[REVENUE_COMMITTED] [DATETIME2](7) NULL,
	[REVENUE_STATUS] [NVARCHAR](480) NULL,
	[REVERSAL_DATE] [DATETIME2](7) NULL,
	[REVERSAL_NUMBER_ID] [FLOAT] NULL,
	[REVERSING_TRANSACTION_ID] [FLOAT] NULL,
	[SALESFORCE_OPPORTUNITY] [NVARCHAR](4000) NULL,
	[SALESFORCE_RENEWAL_OPP_ID] [NVARCHAR](4000) NULL,
	[SALESFORCE_TRAN_ID] [NVARCHAR](4000) NULL,
	[SALES_EFFECTIVE_DATE] [DATETIME2](7) NULL,
	[SALES_REP_ID] [FLOAT] NULL,
	[SCHEDULING_METHOD_ID] [NVARCHAR](15) NULL,
	[SEMIANNUAL_VALUE_CHANGE] [FLOAT] NULL,
	[SHIPADDRESS] [NVARCHAR](999) NULL,
	[SHIPMENT_RECEIVED] [DATETIME2](7) NULL,
	[SHIPPING_CODE_ID] [FLOAT] NULL,
	[SHIPPING_CONTACT_ID] [FLOAT] NULL,
	[SHIPPING_ITEM_ID] [FLOAT] NULL,
	[SHIPTO_ENTITYUSE_CODE_ID] [FLOAT] NULL,
	[SHIPTO_LATITUDE] [NVARCHAR](4000) NULL,
	[SHIPTO_LONGITUDE] [NVARCHAR](4000) NULL,
	[SO_SF_VERIFIED_ID] [FLOAT] NULL,
	[START_DATE] [DATETIME2](7) NULL,
	[START_DATE_0] [DATETIME2](7) NULL,
	[START_NEW_CONTRACT] [NVARCHAR](1) NULL,
	[STATUS] [NVARCHAR](480) NULL,
	[SUBSCRIPTION_BUNDLE_INVOICE_ID] [FLOAT] NULL,
	[TAX_CREDIT] [FLOAT] NULL,
	[TAX_INCLUDED] [NVARCHAR](1) NULL,
	[TAX_REG_ID] [FLOAT] NULL,
	[TEMP_DO_NOT_CLOSE_ORDER_FLAG] [NVARCHAR](1) NULL,
	[TITLE] [NVARCHAR](200) NULL,
	[TOTAL_MRR] [FLOAT] NULL,
	[TOTAL_NONMRR] [FLOAT] NULL,
	[TRAINING_PROVISIONING_COMPLET] [NVARCHAR](1) NULL,
	[TRAINING_PROVISIONING_NEEDED] [NVARCHAR](1) NULL,
	[TRANDATE] [DATETIME2](7) NULL,
	[TRANID] [NVARCHAR](138) NULL,
	[TRANSACTION_EXTID] [NVARCHAR](255) NULL,
	[TRANSACTION_FOR_RR_ID] [FLOAT] NULL,
	[TRANSACTION_ID] [FLOAT] NULL,
	[TRANSACTION_NUMBER] [NVARCHAR](138) NULL,
	[TRANSACTION_PARTNER] [NVARCHAR](40) NULL,
	[TRANSACTION_SOURCE] [NVARCHAR](4000) NULL,
	[TRANSACTION_TYPE] [NVARCHAR](192) NULL,
	[TRANSACTION_WEBSITE] [FLOAT] NULL,
	[TRANSFER_LOCATION] [FLOAT] NULL,
	[TRANS_IS_VSOE_BUNDLE] [NVARCHAR](3) NULL,
	[USD_EXCHANGE_RATE] [FLOAT] NULL,
	[VAULT_PROVISIONING_COMPLETE] [NVARCHAR](1) NULL,
	[VAULT_PROVISIONING_NEEDED] [NVARCHAR](1) NULL,
	[VENDOR_PAYMENT_METHOD_ID] [FLOAT] NULL,
	[VISIBLE_IN_CUSTOMER_CENTER] [NVARCHAR](1) NULL,
	[WEEKLY_VALUE_CHANGE] [FLOAT] NULL,
	[WEIGHTED_TOTAL] [FLOAT] NULL,
	[WITHIN_RENEWAL_PERIOD] [NVARCHAR](1) NULL
) 

INSERT INTO #tmp_sales_orders
SELECT * FROM dbo.NSCARB_TRANSACTIONS t
WHERE t.TRANSACTION_TYPE = 'Sales order'
AND t.status <> 'Pending Approval'

--SELECT * FROM #tmp_sales_orders


SELECT 
t.TRANSACTION_ID,
t.TRANID,
t.SALES_REP_ID,
emp.FULL_NAME,
t.CREATE_DATE,
t.STATUS,
t.SALES_EFFECTIVE_DATE,
t.TRANDATE,
ot.LIST_ITEM_NAME ordertype,
dt.LIST_ITEM_NAME deal_type
INTO #tmp_sales_order
FROM #tmp_sales_orders t 
LEFT OUTER JOIN dbo.NSCARB_CUSTOMERS cus ON cus.CUSTOMER_ID = t.ENTITY_ID
LEFT OUTER JOIN dbo.NSCARB_CUSTOMERS reseller ON reseller.CUSTOMER_ID = t.RESELLER_ID
LEFT OUTER JOIN dbo.NSCARB_CUSTOMERS end_user ON end_user.CUSTOMER_ID = t.END_USER_CUSTOMER_ID
LEFT OUTER JOIN dbo.NSCARB_EMPLOYEE emp ON emp.EMPLOYEE_ID = t.SALES_REP_ID
LEFT OUTER JOIN dbo.NSCARB_ORDER_TYPE ot ON ot.LIST_ID = t.ORDER_TYPE_ID
LEFT OUTER JOIN dbo.NSCARB_DEAL_TYPE dt ON dt.LIST_ID = t.DEAL_TYPE_ID


--SELECT * FROM #tmp_sales_order

--drop table #tmp_sales_teams
SELECT 
t.TRANID,
emp_1.EMPLOYEE_ID salesrepid,
emp_1.FULL_NAME sales_rep,
emp_2.FULL_NAME  team_member,
strole.LIST_ITEM_NAME role,
st.COMMISSION_PERCENT

INTO #tmp_sales_teams

 FROM #tmp_sales_orders t
LEFT OUTER JOIN dbo.NSCARB_Sales_Team st ON st.SALES_ORDER_ID = t.TRANSACTION_ID
LEFT OUTER JOIN dbo.NSCARB_EMPLOYEE emp_1 ON emp_1.EMPLOYEE_ID = st.SALES_REP_ID
LEFT OUTER JOIN dbo.NSCARB_EMPLOYEE emp_2 ON emp_2.EMPLOYEE_ID = st.SALES_TEAM_MEMBER_ID
LEFT OUTER JOIN dbo.NSCARB_SALES_TEAM_ROLE strole ON strole.LIST_ID = st.ROLE_ID

--SELECT * FROM #tmp_sales_teams

SELECT 
TRANID, salesrepid, sales_rep, SUM(COMMISSION_PERCENT) commission_split , MAX(VP) AS VP,max([Sales Director]) as [SalesDirector], 
max([TAM]) as [TAM], max([TSR]) as TSR, 
max([CRM]) as [CRM], max([RSM]) as [RSM], max([PAM]) as [PAM], max([SE]) as [SE] 
into #tmp_sales_comm
 FROM #tmp_sales_teams
PIVOT(MAX(team_member) FOR role IN ([VP], [Sales Director],[TAM], [TSR], [CRM],[RSM], [PAM],[SE]) ) as a
group by TRANID,salesrepid,sales_rep

--SELECT * FROM #tmp_sales_comm

SELECT 
tl.TRANSACTION_LINE_ID,
t.TRANID,
spt.LIST_ITEM_NAME sales_product_type,
pg.NAME pricing_group,
tl.SALESFORCE_QUOTE_LINE_ID,
tl.CONTRACT_LINE_TO_SUPERSEDE_ID,
cl.END_DATE,
DATEDIFF(mm,MAX(tl.START_DATE), cl.END_DATE) AS months_remaining,
SUM(tl.CALCULATED_INCLUDED_STORAGE) total_gb,
SUM(tl.ASSOCIATED_SHIPPING_COST) AS shipping,
SUM(tl.AMOUNT*tl.ITEM_COUNT) sales_order_amount,
MAX(tl.START_DATE) AS contract_start_date,
ROW_NUMBER() OVER (PARTITION BY t.TRANID ORDER BY tl.BOOKING_PRODUCT_GROUP) AS row
 INTO  #tmp_sales_order_line_items
 FROM #tmp_sales_orders t 
LEFT OUTER JOIN dbo.NSCARB_TRANSACTION_LINES tl ON t.TRANSACTION_ID = tl.TRANSACTION_ID
LEFT OUTER JOIN dbo.NSCARB_CONTRACT_LINE cl ON cl.CONTRACT_LINE_ID = tl.CONTRACT_LINE_TO_SUPERSEDE_ID
LEFT OUTER JOIN dbo.NSCARB_ITEMS i ON i.ITEM_ID = tl.ITEM_ID
LEFT OUTER JOIN dbo.NSCARB_SALES_PRODUCT_TYPE spt ON spt.LIST_ID = i.SALES_PRODUCT_TYPE_ID
LEFT OUTER JOIN dbo.NSCARB_PRICING_GROUPS pg ON pg.PRICING_GROUP_ID = i.PRICING_GROUP_ID
GROUP BY tl.TRANSACTION_LINE_ID, t.TRANID, 
spt.LIST_ITEM_NAME ,
pg.NAME ,
tl.SALESFORCE_QUOTE_LINE_ID,
tl.CONTRACT_LINE_TO_SUPERSEDE_ID,
cl.END_DATE,tl.BOOKING_PRODUCT_GROUP

--select * from #tmp_sales_order_line_items


SELECT 
t.TRANID,
bpg.LIST_ITEM_NAME bpg,
bc.LIST_ITEM_NAME bc,
t.USD_EXCHANGE_RATE,
sopg.SALES_ORDER_PRODUCT_GROUP_ID,
sopg.INVOICE_DATE,
sopg.INVOICE_NO,
sopg.PRODUCT_GROUP_RECONTRACTED,
sopg.PREVIOUS_GB_COMMITMENT,
sopg.PREVIOUS_MONTHLY_MINIMUM,
sopg.PREVIOUS_MONTHLY_MINIMUM__USD,
sopg.PRODUCT_GROUP_ORDER_GB_COMMIT,
sopg.PRODUCT_GROUP_GB_COMMITMENT,
sopg.PRODUCT_GROUP_ORDER_MONTHLY_M,
sopg.PRODUCT_GROUP_MONTHLY_MINIMUM,
sopg.PRODUCT_GROUP_TERM, 
sopg.PARTNER_COMMISSION_, 
sopg.PARTNER_COMMISSION_AMOUNT, 
sopg.PARTNER_COMMISSION_AMOUNT__US,
sopg.PRODUCT_GROUP_TAV, 
sopg.PRODUCT_GROUP_TAV__USD, 
sopg.PRODUCT_GROUP_TCV, 
sopg.PRODUCT_GROUP_TCV__USD, 
sopg.TOTAL_MRR_GROSS, 
sopg.TOTAL_MRR_GROSS__USD, 
sopg.TOTAL_MRR_TAV, 
sopg.TOTAL_MRR_TAV__USD, 
sopg.TOTAL_MRR_TCV, 
sopg.TOTAL_MRR_TCV__USD,
ROW_NUMBER() OVER(PARTITION BY t.TRANID ORDER BY bpg.LIST_ITEM_NAME) AS Row
into #tmp_sales_order_prod_group
 FROM dbo.NSCARB_SALES_ORDER_PRODUCT_GROUP sopg
RIGHT JOIN #tmp_sales_orders t ON t.TRANSACTION_ID = sopg.SALES_ORDER_ID
LEFT OUTER  JOIN dbo.NSCARB_BOOKING_PRODUCT_GROUP bpg ON bpg.LIST_ID = sopg.SALES_ORDER_PRODUCT_GROUP_ID
LEFT OUTER  join dbo.NSCARB_BOOKING_CATEGORY bc ON bc.LIST_ID = sopg.BOOKING_CATEGORY_ID

--select * from #tmp_sales_order_prod_group


SELECT * INTO #temp_tcv_usd FROM
(

SELECT TRANID, 
bpg,
             sum([SW NRR - TCV]) as [SW NRR - TCV - USD],
             sum([Hardware - TCV]) as [Hardware - TCV - USD],
             sum([PS - Non-Comm - TCV]) as [PS - Non-Comm - TCV - USD],
             sum([S&M - TCV]) as [S&M - TCV - USD],
             sum([PS - Comm - TCV]) as [PS - Comm - TCV - USD],
             sum([Partner Program TECS fee - TCV]) as [Partner Program TECS fee - TCV - USD],
             sum([MRR - TCV]) as [MRR - TCV - USD],
             sum([CDR Program Fee - TCV]) as [CDR Program Fee - TCV - USD],
             sum([YRR - TCV]) as [YRR - TCV - USD],
             sum([Review - TCV]) as [Review - TCV - USD]
from
(
SELECT 
TRANID,
bpg,
PRODUCT_GROUP_TCV__USD,
bc + '- TCV' AS Booking_TCV
 FROM #tmp_sales_order_prod_group
 ) AS pivTemp
  PIVOT (SUM(PRODUCT_GROUP_TCV__USD)  FOR Booking_TCV IN ( "SW NRR - TCV","Hardware - TCV","PS - Non-Comm - TCV","S&M - TCV","PS - Comm - TCV","Partner Program TECS fee - TCV","MRR - TCV","CDR Program Fee - TCV","YRR - TCV","Review - TCV")
		) AS piv
GROUP BY TRANID, bpg
) a

--SELECT * FROM #temp_tcv_usd


SELECT * INTO #temp_tav_usd FROM
(

SELECT TRANID, 
bpg,
             SUM([SW NRR - TAV]) AS [SW NRR - TAV - USD],
             SUM([Hardware - TAV]) AS [Hardware - TAV - USD],
             SUM([PS - Non-Comm - TAV]) AS [PS - Non-Comm - TAV - USD],
             SUM([S&M - TAV]) AS [S&M - TAV - USD],
             SUM([PS - Comm - TAV]) AS [PS - Comm - TAV - USD],
             SUM([Partner Program TECS fee - TAV]) AS [Partner Program TECS fee - TAV - USD],
             SUM([MRR - TAV]) AS [MRR - TAV - USD],
             SUM([CDR Program Fee - TAV]) AS [CDR Program Fee - TAV - USD],
             SUM([YRR - TAV]) AS [YRR - TAV - USD],
             SUM([Review - TAV]) AS [Review - TAV - USD]

FROM
(
SELECT 
TRANID,
bpg,
PRODUCT_GROUP_TAV__USD,
bc + '- TAV' AS Booking_TCV
 FROM #tmp_sales_order_prod_group
 ) AS pivTemp
  PIVOT (SUM(PRODUCT_GROUP_TAV__USD)  FOR Booking_TCV IN ( "SW NRR - TAV","Hardware - TAV","PS - Non-Comm - TAV","S&M - TAV","PS - Comm - TAV","Partner Program TECS fee - TAV","MRR - TAV","CDR Program Fee - TAV","YRR - TAV","Review - TAV")
		) AS piv
GROUP BY TRANID, bpg
) a

--select * from #temp_tav_usd

SELECT 
a.TRANID,
a.CREATE_DATE,
a.TRANDATE,
a.ordertype,
a.deal_type,
SUM(product_group_tav__usd) AS product_group_tav__usd,
 SUM(product_group_tcv__usd) AS product_group_tcv__usd

 FROM #tmp_sales_order a
LEFT OUTER JOIN #tmp_sales_comm d ON (a.TRANID = d.TRANID AND a.SALES_REP_ID <> d.salesrepid)
LEFT OUTER JOIN #tmp_sales_order_prod_group b ON a.TRANID = b.TRANID
LEFT OUTER JOIN #tmp_sales_order_line_items e ON (e.TRANID = a.TRANID AND b.Row = e.row)
LEFT OUTER JOIN #tmp_sales_comm c ON (c.TRANID = a.TRANID AND a.SALES_REP_ID = c.salesrepid)
GROUP BY a.TRANID,
a.CREATE_DATE,
a.TRANDATE,
a.ordertype,
a.deal_type



--DROP TABLE #tmp_sales_orders
--DROP TABLE #tmp_sales_order
--DROP TABLE #tmp_sales_teams
--DROP TABLE #tmp_sales_comm
--DROP TABLE #tmp_sales_order_prod_group
--DROP TABLE #tmp_sales_order_line_items
--DROP TABLE #temp_tcv_usd
--DROP TABLE #temp_tav_usd

