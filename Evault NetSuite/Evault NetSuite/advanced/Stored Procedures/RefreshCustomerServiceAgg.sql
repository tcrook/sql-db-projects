CREATE PROC [advanced].[RefreshCustomerServiceAgg] AS

IF OBJECT_ID('[Evault NetSuite].advanced.CustomerServiceAgg', 'U') IS NOT NULL DROP TABLE [Evault NetSuite].advanced.CustomerServiceAgg;
SELECT
       AccountId,
       CaseNumber,
       Priority,
       Status,
       DTS__C as DTS,
       SUPPORTED_PRODUCT__C as Supported_Product,
       Origin,
       Platform__C as Platform,
       Subject,
       CreatedDate,
       ClosedDate,
       Root_Cause__C as Root_Cause,
       Resolution__C as Resolution,
       Ticket_Owner_Role__C as Ticket_Owner_Role
       INTO #DISTINCT_CASES
FROM [Evault SFDC].dbo.EV_SF_Case sf WITH (NOLOCK)

SELECT
  AccountId
  ,COUNT(*) as nmbr_support_tickets
  ,SUM(DATEDIFF(d, CreatedDate, COALESCE(ClosedDate, GETDATE()) + 1)) as total_days_tickets_open
  ,MAX(DATEDIFF(d, CreatedDate, COALESCE(ClosedDate, GETDATE()) + 1)) as max_days_ticket_open
  ,SUM(CASE Priority WHEN 'Critical' THEN 1
                    WHEN 'High' THEN 1 ELSE 0 END) as nmbr_priority_crit_high
  ,SUM(CASE Priority WHEN 'Critical' THEN 0
                    WHEN 'High' THEN 0 ELSE 1 END) as nmbr_priority_med_low
  ,SUM(CASE Origin   WHEN 'Phone' THEN 1 ELSE 0 END) as nmbr_origin_phone
  ,SUM(CASE Origin   WHEN 'Phone' THEN 0 ELSE 1 END) as nmbr_origin_other
  ,SUM(CASE Ticket_Owner_Role  WHEN 'Support Level 2' THEN 1 ELSE 0 END) as nmbr_support_lvl2
  ,SUM(CASE Ticket_Owner_Role  WHEN 'Support Level 2' THEN 0 ELSE 1 END) as nmbr_support_lvl1_lower
  ,MAX(CASE WHEN ClosedDate IS NULL THEN 1 ELSE 0 END) as Has_Open_Ticket
  INTO [Evault NetSuite].advanced.CustomerServiceAgg
FROM #DISTINCT_CASES
GROUP BY AccountId;