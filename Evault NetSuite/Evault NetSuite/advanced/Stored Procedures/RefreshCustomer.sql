CREATE PROC [advanced].[RefreshCustomer] AS

IF OBJECT_ID('[Evault NetSuite].advanced.Customer', 'U') IS NOT NULL DROP TABLE [Evault NetSuite].advanced.Customer;
SELECT
  Customer_End_User_ID
  ,Customer_End_User
  ,Customer_End_User_SFDC_ID
  ,MAX(Active_Ind) as Active_Ind
  ,MIN(Est_First_Contract_Date) as Est_First_Contract_Date
  ,CAST(CASE WHEN SUM(CASE WHEN Est_Cancel_Date IS NULL THEN 1 ELSE 0 END) > 0 THEN NULL ELSE MAX(Est_Cancel_Date) END AS DATE) Est_Cancel_Date
  ,MAX(Used_Reseller) as Used_Reseller
  ,MAX(Product_Type_Software) as Product_Type_Software
  ,MAX(Product_Type_Hardware) as Product_Type_Hardware
  ,MAX(Product_Type_Subscription) as Product_Type_Subscription
  ,MAX(CASE WHEN Source IN ('Contracts', 'Contracts-SaaS Historical') THEN 1 ELSE 0 END) as Contract_Ind_Cloud
  ,MAX(CASE WHEN Source IN ('SM Contracts', 'Contracts-SM Historical') THEN 1 ELSE 0 END) as Contract_Ind_SM
  INTO [Evault NetSuite].advanced.Customer
FROM (
  SELECT
    Source
    ,Customer_End_User_ID
    ,Customer_End_User
    ,Customer_End_User_SFDC_ID
    ,MAX(CASE Contract_Line_Status
      WHEN 'Active' THEN 1
      WHEN 'Pending Cancellation' THEN 1
      WHEN 'Pending Activation' THEN 1
      ELSE 0 END) as Active_Ind
    ,CAST(CASE WHEN MIN(Initial_Contract_Date) IS NULL THEN MIN(Start_Date)
               WHEN YEAR(MIN(Initial_Contract_Date)) <= 1999 THEN MIN(Start_Date)
               ELSE MIN(Initial_Contract_Date) END AS DATE) as Est_First_Contract_Date
    ,CASE WHEN SUM(CASE WHEN CASE WHEN Contract_Line_Status = 'Not Active' AND (COALESCE(Cancellation_Date, End_Date) >= GETDATE() OR COALESCE(Cancellation_Date, End_Date) IS NULL) THEN '1900-01-01'
                                  WHEN End_Date <= GETDATE()                                                                      THEN COALESCE(Cancellation_Date, End_Date)
                                  WHEN End_Date IS NULL AND Cancellation_Date IS NOT NULL                                         THEN Cancellation_Date
                                  WHEN End_Date IS NULL AND Cancellation_Date IS NULL AND Contract_Line_Status = 'Terminated'     THEN '1900-01-01'
                                  ELSE CASE WHEN Cancellation_Date IS NULL THEN NULL ELSE Cancellation_Date END
                             END
                             IS NULL THEN 1 ELSE 0 END) > 0 THEN NULL 
          ELSE MAX(CASE WHEN Contract_Line_Status = 'Not Active' AND (COALESCE(Cancellation_Date, End_Date) >= GETDATE() OR COALESCE(Cancellation_Date, End_Date) IS NULL) THEN '1900-01-01'
                        WHEN End_Date <= GETDATE()                                                                      THEN COALESCE(Cancellation_Date, End_Date)
                        WHEN End_Date IS NULL AND Cancellation_Date IS NOT NULL                                         THEN Cancellation_Date
                        WHEN End_Date IS NULL AND Cancellation_Date IS NULL AND Contract_Line_Status = 'Terminated'     THEN '1900-01-01'
                        ELSE CASE WHEN Cancellation_Date IS NULL THEN NULL ELSE Cancellation_Date END
                   END) 
          END as Est_Cancel_Date
    ,MAX(CASE WHEN Reseller_ID IS NULL THEN 0 ELSE 1 END) as Used_Reseller
    ,MAX(CASE Product_Type
      WHEN 'Software CCSP' THEN 1
      WHEN 'Appliance' THEN 0
      WHEN 'Software' THEN 1
      WHEN 'Warranty' THEN 0
      WHEN 'Subscription' THEN 0
      WHEN 'Hardware' THEN 0
      ELSE 0 END) as Product_Type_Software
    ,MAX(CASE Product_Type
      WHEN 'Software CCSP' THEN 0
      WHEN 'Appliance' THEN 1
      WHEN 'Software' THEN 0
      WHEN 'Warranty' THEN 1
      WHEN 'Subscription' THEN 0
      WHEN 'Hardware' THEN 1
      ELSE 0 END) as Product_Type_Hardware
    ,MAX(CASE Product_Type
      WHEN 'Software CCSP' THEN 0
      WHEN 'Appliance' THEN 0
      WHEN 'Software' THEN 0
      WHEN 'Warranty' THEN 0
      WHEN 'Subscription' THEN 1
      WHEN 'Hardware' THEN 0
      ELSE 0 END) as Product_Type_Subscription
  FROM (
    SELECT 
      eac.*
      ,CASE WHEN deb.Customer_End_User_SFDC_ID IS NULL THEN 'Clean' ELSE 'DeBooked' END as Debook_Ind
    FROM [Evault NetSuite].advanced.allcontracts eac
      LEFT JOIN (SELECT Source, Customer_End_User_SFDC_ID, Contract_Line_ID FROM [Evault NetSuite].advanced.allcontracts WHERE Order_Line_Transaction_Type = 'DeBooking') deb
      ON eac.Customer_End_User_SFDC_ID = deb.Customer_End_User_SFDC_ID
        AND eac.Superseded_By_ID = deb.Contract_Line_ID
        AND eac.Source = deb.Source
    WHERE (eac.Order_Line_Transaction_Type <> 'DeBooking' OR eac.Order_Line_Transaction_Type IS NULL)
      AND deb.Customer_End_User_SFDC_ID IS NULL
      AND eac.Booking_Product_Group NOT IN
                  ('EVault Endpoint Protection', 'LTS2') -- Carbonite did not purchase these products
  ) ec1
  GROUP BY Source, Customer_End_User_ID, Customer_End_User, Customer_End_User_SFDC_ID
  ) a
  GROUP BY Customer_End_User_ID
  ,Customer_End_User
  ,Customer_End_User_SFDC_ID