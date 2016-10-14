


--DROP VIEW [dbo].[vw_Dollar_renewal_rate_logic]
CREATE VIEW [dbo].[vw_Dollar_renewal_rate_logic] AS
(
SELECT 
        [cl].Start_Date old_contract_start_date
,         [cl].End_Date   old_contract_end_date
,         [cl].Cancellation_Date old_contract_cancellation_date
,         [cl].Contract_ID old_contract_id
,         [cl].Contract_Line_ID old_contract_line_id
,         [cl].Superseded_By_ID
,         [cl].Booking_Product_Group old_product_group
,         [new_cl].Start_Date new_contract_start_date
,         [new_cl].End_Date new_contract_end_date
,         [new_cl].Cancellation_Date new_contract_cancellation_date
,         [new_cl].Contract_ID new_contract_ID
,         [new_cl].Contract_Line_ID new_contract_line_id
,         [new_cl].Booking_Product_Group new_product_group
,		  [new_cl].Order_Line_Transaction_Type new_Order_Line_Transaction_Type
,			fpg.Finance_Product_Grouping_name
,		  CASE WHEN cl.End_Date IS NULL THEN 'Evergreen'
				WHEN cl.End_Date IS NOT NULL THEN 'In-contract'
		  ELSE NULL
		  END Contract_type
,		  CASE WHEN [cl].End_Date IS NULL AND cl.Cancellation_Date IS NULL AND [new_cl].Contract_Line_ID IS NULL THEN 'Auto-renewed'
			   WHEN [new_cl].Contract_Line_ID IS NULL THEN 'not renewed' 
               WHEN [new_cl].Contract_Line_ID IS NOT NULL AND [new_cl].Order_Line_Transaction_Type = 'cancelation' THEN   'not renewed'
				  
           ELSE  'renewed'

     	  END [Renewed status]
  
,      CASE WHEN [new_cl].Order_Line_Transaction_Type = 'cancelation' THEN 'canceled' 
            WHEN [new_cl].Contract_Line_ID IS NOT NULL AND [new_cl].End_Date IS NULL THEN 'auto-renewed' 
			WHEN [new_cl].Contract_Line_ID IS NULL AND cl.Cancellation_Date IS NULL AND [cl].End_Date IS NULL THEN 'auto-renewed'
            WHEN [new_cl].Contract_Line_ID IS NOT NULL AND [new_cl].End_Date IS NOT NULL THEN 'regular renewal' 
       END [Renewal Type]
,         [cl].Contracted_Amount_USD [Old CL Amount]
,      [new_cl].Contracted_Amount_USD [New CL Amount]
FROM [dbo].[V__NS_Hosted_Contract_SKU] [cl] WITH (NOLOCK)
LEFT OUTER JOIN [dbo].[V__NS_Hosted_Contract_SKU] [new_cl] WITH (NOLOCK) ON [new_cl].Contract_Line_ID = [cl].Superseded_By_ID
LEFT OUTER JOIN dbo.EV_Custom_Finance_Product_Group fpg ON fpg.Custom_Prodct_grouping_name = [cl].Booking_Product_Group
WHERE 1=1
AND ([cl].Order_Line_Transaction_Type<>'cancelation' OR [cl].Order_Line_Transaction_Type IS NULL)
AND ISNULL([cl].[Cancellation_Date],'2099/12/31')>='2016/1/14'
)




