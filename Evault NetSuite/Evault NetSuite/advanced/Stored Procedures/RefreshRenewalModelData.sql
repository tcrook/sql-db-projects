CREATE PROC [advanced].[RefreshRenewalModelData] AS

IF OBJECT_ID('[Evault NetSuite].advanced.RenewalModelData', 'U') IS NOT NULL DROP TABLE [Evault NetSuite].advanced.RenewalModelData;
SELECT
   Customer_End_User_SFDC_ID
   ,Transaction_Date
   ,ROW_NUMBER() OVER (PARTITION BY Customer_End_User_SFDC_ID ORDER BY Transaction_Date DESC) as row_num
   ,SUM((ciu.Calculated_Included_Usage_GB) * CASE WHEN ciu.Storage_Type <> 'Compressed' THEN .9 ELSE 1 END) as CalcCompressedStorage_TotalGBPurchased
   ,SUM((Total_Usage_GB - CASE WHEN ciu.Contract_Usage_Amount_Charged_USD <= 0 THEN ciu.Overage_GB ELSE 0 END) * CASE WHEN ciu.Storage_Type <> 'Compressed' THEN .9 ELSE 1.0 END) as CalcCompressedStorage_TotalUsageGB
   INTO #Usage
  FROM
    [Evault NetSuite].advanced.AllCIU ciu WITH (NOLOCK)
  WHERE ciu.Booking_Product_Group NOT IN ('EVault Endpoint Protection', 'LTS2') -- Carbonite did not purchase these products
  GROUP BY Customer_End_User_SFDC_ID, Transaction_Date

SELECT
  Customer_End_User_SFDC_ID
  ,MAX(CASE WHEN row_num = 1 THEN Transaction_Date END) as last_posting_month
  ,MAX(CASE WHEN row_num = 1 THEN CalcCompressedStorage_TotalGBPurchased END) as last_GB_Purchased
  ,MAX(CASE WHEN row_num = 1 THEN CalcCompressedStorage_TotalUsageGB END) as last_GB_Used
  ,MAX(CalcCompressedStorage_TotalGBPurchased) as lifetime_max_GB_Purchased
  ,MAX(CalcCompressedStorage_TotalUsageGB) as lifetime_max_GB_Used
  INTO #Usage2
FROM #Usage usage
GROUP BY Customer_End_User_SFDC_ID

SELECT * INTO #UsagePeak FROM (
  SELECT
    u1.Customer_End_User_SFDC_ID,
    u1.Transaction_Date AS peak_posting_month,
    u1.CalcCompressedStorage_TotalUsageGB AS peak_gb_used,
    u1.CalcCompressedStorage_TotalGBPurchased AS peak_gb_purchased,
    ROW_NUMBER() OVER (PARTITION BY u1.Customer_End_User_SFDC_ID ORDER BY u1.Transaction_Date) as row_num
  FROM #Usage u1
    LEFT JOIN #Usage2 u2
    ON u1.Customer_End_User_SFDC_ID = u2.Customer_End_User_SFDC_ID
      AND u1.CalcCompressedStorage_TotalUsageGB = u2.lifetime_max_GB_Used 
  WHERE u2.Customer_End_User_SFDC_ID IS NOT NULL
  ) peak
WHERE row_num = 1

SELECT
  Account_ID,
  SUM(duration) as restore_duration,
  SUM(count) as restore_counts,
  MAX(date_month) as restore_last_month
  INTO #Restores
FROM [Evault NetSuite].import.[Restore] res
GROUP BY Account_ID
  
SELECT
  cust.Customer_End_User_SFDC_ID
  ,cust.Customer_End_User
  ,cust.Active_Ind
  ,cust.Est_First_Contract_Date
  ,cust.Est_Cancel_Date
  ,cust.Contract_Ind_Cloud
  ,cust.Contract_Ind_SM
  ,sfdc.NAICS_Code__C
  ,sfdc.SIC
  ,sfdc.INDUSTRY
  ,sfdc.NUMBEROFEMPLOYEES
  ,sfdc.ANNUALREVENUE
  ,sfdc.BillingCountry
  ,sfdc.BillingState
  ,cust.Used_Reseller
  ,cust.Product_Type_Software
  ,cust.Product_Type_Hardware
  ,cust.Product_Type_Subscription
  ,NULL as MAX_PURCHASED_CLOUD_GB --The maximum single contract line GB, this doesn't make sense
  ,u2.last_posting_month
  ,u2.last_GB_Used
  ,u2.last_GB_Purchased
  --.lifetime_max_GB_Used --This was removed from the original table
  ,u2.lifetime_max_GB_Purchased
  ,up.peak_posting_month
  ,up.peak_gb_used
  ,up.peak_gb_purchased
  ,cfa.GBRate_Contracted_Latest
  ,cfa.GBRate_Actual_Latest
  ,cfa.Expectation_Ratio_Latest
  ,cfa.GB_Overage_Total
  ,cfa.Payment_Overages_Total
  ,cfa.GBRate_Overage_Effective
  ,res.restore_counts
  ,res.restore_duration
  ,res.restore_last_month
  ,cs.nmbr_support_tickets
  ,cs.total_days_tickets_open
  ,cs.max_days_ticket_open
  ,cs.nmbr_priority_crit_high
  ,cs.nmbr_priority_med_low
  ,cs.nmbr_origin_phone
  ,cs.nmbr_origin_other
  ,cs.nmbr_support_lvl2
  ,cs.nmbr_support_lvl1_lower
  ,cs.Has_Open_Ticket
  ,cust.Customer_End_User_ID
  INTO [Evault NetSuite].advanced.RenewalModelData
FROM [Evault NetSuite].advanced.customer cust WITH (NOLOCK)
  LEFT JOIN [Evault SFDC].dbo.EV_SF_Account sfdc WITH (NOLOCK)
    ON cust.Customer_End_User_SFDC_ID = sfdc.ID
  LEFT JOIN #Usage2 u2
    ON cust.Customer_End_User_SFDC_ID = u2.Customer_End_User_SFDC_ID
  LEFT JOIN #UsagePeak up
    ON cust.Customer_End_User_SFDC_ID = up.Customer_End_User_SFDC_ID
  LEFT JOIN #Restores res
    ON cust.Customer_End_User_SFDC_ID = res.Account_ID
  LEFT JOIN [Evault NetSuite].advanced.CustomerFinancialAgg cfa
    ON cust.Customer_End_User_SFDC_ID = cfa.Customer_End_User_SFDC_ID
  LEFT JOIN [Evault NetSuite].advanced.CustomerServiceAgg cs
    ON cust.Customer_End_User_SFDC_ID = cs.AccountId