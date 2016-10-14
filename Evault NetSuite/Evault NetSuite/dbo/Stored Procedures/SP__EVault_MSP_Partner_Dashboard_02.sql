


CREATE PROC [dbo].[SP__EVault_MSP_Partner_Dashboard_02]
AS

BEGIN

SET NOCOUNT ON


SELECT
			[evault_booking].[customer]
	,		[evault_booking].[reseller]
	,		[evault_booking].[end_user]
	,		[evault_booking].[customer_end_user]
	,		[evault_booking].[customer_id]
	,		[evault_booking].[reseller_id]
	,		[evault_booking].[end_user_id]
	,		[evault_booking].[customer_end_user_id]
	,		[evault_booking].[Customer_SFDC_ID]
	,		[evault_booking].[Reseller_SFDC_ID]
	,		[evault_booking].[End_User_SFDC_ID]
	,		COALESCE([evault_booking].[End_User_SFDC_ID], [evault_booking].[Customer_SFDC_ID]) [Customer_End_User_SFDC_ID]
	,		[evault_booking].[Source_type]
	,		CASE
				WHEN [na_user].[NAME] IN ('paul binder','kelly boysen') THEN [evault_booking].[customer]
				ELSE COALESCE([evault_booking].[end_user], [evault_booking].[customer])
			END [MSP_Partner]
	,		CASE
				WHEN [na_user].[NAME] IN ('paul binder','kelly boysen') THEN [na_account].[GEO__C]
				ELSE [emea_account].[GEO__C]
			END [MSP_Partner_GEO]
	,		CASE
				WHEN [na_user].[NAME] IN ('paul binder','kelly boysen') THEN [na_account].[BILLINGCOUNTRY]
				ELSE [emea_account].[BILLINGCOUNTRY]
			END [MSP_Partner_Country]
	,		CASE
				WHEN [na_user].[NAME] IN ('paul binder','kelly boysen') THEN [na_account].[BILLINGSTATE]
				ELSE [emea_account].[BILLINGSTATE]
			END [MSP_Partner_State]
	,		CASE
				WHEN [na_user].[NAME] IN ('paul binder','kelly boysen') THEN [evault_booking].[Customer_SFDC_ID]
				ELSE COALESCE([evault_booking].[End_User_SFDC_ID], [evault_booking].[Customer_SFDC_ID])
			END [MSP_Partner_SFDC_D]
	,		CASE
				WHEN [na_user].[NAME] IN ('paul binder','kelly boysen') THEN [na_user].[NAME]
				ELSE [emea_user].[NAME]
			END [MSP_Partner_Account_Owner]
			
	,		[evault_booking].[TRANDATE]
	,		[evault_booking].[tranid]
	,		[evault_booking].[STATUS] [Transaction_Status]
	,		[evault_booking].[accounting_period]
	,		[evault_booking].[GL_Name]
	,		[evault_booking].[item_name]
	,		[evault_booking].[Product_type_name]
	,		[evault_booking].[TAV_category_name]
	,		[evault_booking].[booking_product_group_name]
	,		[evault_booking].[custom_prod_grouping]
	,		[evault_booking].[Finance_Product_grouping]
	,		[evault_booking].[booking_amount_foreign]
	,		[evault_booking].[booking_amount_usd]
,	DATEFROMPARTS(
			CAST(RIGHT([evault_booking].[accounting_period],4) AS INT)
		,	CASE
				WHEN [evault_booking].[accounting_period] LIKE 'jan%' THEN 1
				WHEN [evault_booking].[accounting_period] LIKE 'feb%' THEN 2
				WHEN [evault_booking].[accounting_period] LIKE 'mar%' THEN 3
				WHEN [evault_booking].[accounting_period] LIKE 'apr%' THEN 4
				WHEN [evault_booking].[accounting_period] LIKE 'may%' THEN 5
				WHEN [evault_booking].[accounting_period] LIKE 'jun%' THEN 6
				WHEN [evault_booking].[accounting_period] LIKE 'jul%' THEN 7
				WHEN [evault_booking].[accounting_period] LIKE 'aug%' THEN 8
				WHEN [evault_booking].[accounting_period] LIKE 'sep%' THEN 9
				WHEN [evault_booking].[accounting_period] LIKE 'oct%' THEN 10
				WHEN [evault_booking].[accounting_period] LIKE 'nov%' THEN 11
				WHEN [evault_booking].[accounting_period] LIKE 'dec%' THEN 12
			END
		,	1
	) [accounting_period_month]
FROM [dbo].[vw_Evault_Booking_with_Creditmemo] [evault_booking] WITH (NOLOCK)

LEFT OUTER JOIN [dbo].[NSCARB_TRANSACTIONS] [t] WITH (NOLOCK) ON [t].[TRANSACTION_ID] = [evault_booking].[transaction_id]

LEFT OUTER JOIN [Evault SFDC].[dbo].[EV_SF_Account] [na_account] WITH (NOLOCK) ON [na_account].[ID] = [evault_booking].[Customer_SFDC_ID]
LEFT OUTER JOIN [Evault SFDC].[dbo].[EV_SF_User] [na_user] WITH (NOLOCK) ON [na_user].[ID] = [na_account].[OWNERID]


LEFT OUTER JOIN [Evault SFDC].[dbo].[EV_SF_Account] [emea_account] WITH (NOLOCK) ON [emea_account].[ID] = COALESCE([evault_booking].[End_User_SFDC_ID], [evault_booking].[Customer_SFDC_ID])
LEFT OUTER JOIN [Evault SFDC].[dbo].[EV_SF_User] [emea_user] WITH (NOLOCK) ON [emea_user].[ID] = [emea_account].[OWNERID]

LEFT OUTER JOIN 

(VALUES
('CUST0005918 Acknowledge'),
('CUST0002914 Adapt Services Ltd'),
('CUST0007941 Add-On Consulting'),
('CUST9990559 Alsace Cloud Informatique - ACI'),
('CUST0009960 APPLICOM FZ-LLC'),
('CUST0007942 Atlantic Systemes'),
('CUST0003357 Avensus BV'),
('CUST0006637 Bloxham Mill Ltd T/A Cloud 9'),
('CUST0006211 Bull Nederland N.V.'),
('CUST0007956 Cebea S.A.S.'),
('CUST0008035 Comeditor Solutions AB'),
('CUST0006616 Comsolid Group AB'),
('CUST0002548 DCG Group Limited'),
('CUST0002550 Detron ICT Groep'),
('CUST9992306 Dozit SARL'),
('CUST0007656 Fritz Datacenter Services'),
('CUST0002959 Endava (UK) Limited'),
('CUST0005913 Enhanced Computer Solutions Ltd.'),
('CUST9990262 Flow Line Groupe SAS'),
('CUST0002405 Foreshore datacentre'),
('CUST0007977 geiger BDT GmbH'),
('CUST9991797 Glöckler & Lauer GmbH & Co. Systemhaus KG'),
('CUST9990645 Gosis SA'),
('CUST0005818 Groupe NVL'),
('CUST0007263 Harbor Solutions Limited'),
('CUST0007626 ICT Ltd. (former ICT Solutions)'),
('CUST0008000 ICT Spirit BV'),
('CUST0006619 Ictivity'),
('CUST9992317 I-Invest SAS'),
('CUST0009866 Edarat group (Branch office)'),
('CUST0007649 IT works! Consulting GmbH & Co. KG'),
('CUST0000175 LAB Luxembourg S.A.'),
('CUST0009775 Medialine AG'),
('CUST9991073 microPLAN GmbH'),
('CUST9990411 Morex AB'),
('CUST0008044 Mti Technology Ltd.'),
('CUST0007242 NAK Consulting Services Ltd (Alto 3 Solutions LLP)'),
('CUST0005845 NC2 - Network Computer Communication'),
('CUST0005829 Netsourcing BV'),
('CUST0003179 3 Step IT  Oy'),
('CUST9991519 Netvision Datentechnik GmbH & Co KG.'),
('CUST0007697 NGAnalytics SAS'),
('CUST0007634 Claranet Benelux B.V.'),
('CUST9991089 NSI IT Software & Services'),
('CUST0006629 Oryx Align Limited'),
('CUST9990343 PC AddOn AB'),
('CUST0001508 PEER1 UK Ltd.'),
('CUST0001639 PI Informatik'),
('CUST0003253 Plusine Systems BV'),
('CUST0005811 Prodware SA'),
('CUST0010216 Q-Mex Networks'),
('CUST0002488 Runiso'),
('CUST0007484 Scriba'),
('CUST0006620 Simac ICT Netherlands B.V.'),
('CUST0006549 SLTN Services B.V.'),
('CUST0007722 Sprite IT Managed Services BV'),
('CUST0002146 Redcentric Solutions Ltd.'),
('CUST9991205 Starcom-Bauer GmbH'),
('CUST0000149 SunGard Availability France/EU'),
('CUST0000146 SunGard Availability Nordic/EU'),
('CUST0001740 SunGard Availibility UK/GB'),
('CUST0006548 Tarq Information Technology BV'),
('CUST9992312 Tech IT PSF S.A.'),
('CUST9992318 Telecity Group France S.A.'),
('CUST9992311 Telecity Group Netherlands B.V.'),
('CUST9992313 Telecity Group UK Limited'),
('CUST0003249 TelecityGroup Italia S.p.A'),
('CUST0002499 Timico'),
('CUST9990775 Uptime Solutions Ltd'),
('CUST0006634 VMhosts Ltd.'),
('CUST0005923 Wortmann AG')
) [emea_msp_partner_list] ([name]) ON LEFT([emea_msp_partner_list].[name],11) = [emea_account].[NETSUITE_CUSTOMER_NUMBER__C]

WHERE 1=1
AND (([na_user].[NAME] IN ('paul binder','kelly boysen') OR [emea_msp_partner_list].[name] IS NOT NULL) OR [evault_booking].[Finance_Product_grouping]='royalty')

END



