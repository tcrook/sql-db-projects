


--DROP VIEW [dbo].[vw_Dollar_renewal_rate_logic_V2]

CREATE VIEW [dbo].[vw_Dollar_renewal_rate_logic_V2] AS
(

SELECT 
TABLE2.*

,CASE WHEN TABLE2.Contract_type = 'In-contract' THEN 
													(
													CASE WHEN TABLE2.new_contract_line_id IS NULL THEN 'not renewed' 
 														 WHEN TABLE2.new_contract_line_id IS NOT NULL AND TABLE2.new_Order_Line_Transaction_Type = 'cancelation' THEN   'not renewed'  
 														 ELSE  'renewed' END
													)
	WHEN TABLE2.Contract_type = 'Evergreen' THEN 
													(
													 CASE WHEN TABLE2.old_contract_cancellation_date IS NULL AND TABLE2.new_contract_line_id IS NULL THEN 'renewed'
														  WHEN TABLE2.old_contract_cancellation_date IS NULL AND TABLE2.new_contract_line_id IS NOT NULL AND TABLE2.calculated_cancellation_date > TABLE2.Calculated_end_date THEN 'renewed'
														  WHEN TABLE2.old_contract_cancellation_date IS NULL AND TABLE2.new_contract_line_id IS NOT NULL AND TABLE2.calculated_cancellation_date = TABLE2.Calculated_end_date  THEN 'renewed'
														  WHEN TABLE2.old_contract_cancellation_date IS NOT NULL AND TABLE2.calculated_cancellation_date > TABLE2.Calculated_end_date THEN 'renewed'
														  WHEN TABLE2.old_contract_cancellation_date IS NOT NULL AND table2.new_contract_line_id IS NOT NULL AND table2.new_Order_Line_Transaction_Type = 'cancelation'  THEN   'not renewed'
														  WHEN TABLE2.old_contract_cancellation_date IS NOT NULL AND TABLE2.calculated_cancellation_date = TABLE2.Calculated_end_date AND TABLE2.new_contract_end_date IS NOT NULL THEN 'renewed'
														  WHEN TABLE2.old_contract_cancellation_date IS NOT NULL AND TABLE2.calculated_cancellation_date = TABLE2.Calculated_end_date THEN 'not renewed'
														  

														  
													  ELSE 'Evergreen anaomoly' END
													)

	ELSE 'UNKNOWN'
END  Renewed_Status_updated

, CASE WHEN TABLE2.Contract_type = 'In-contract' THEN 
														(
														CASE WHEN TABLE2.new_contract_line_id IS NULL  AND TABLE2.old_contract_cancellation_date IS NOT NULL THEN 'Cancelled without cancellation contract'
															 WHEN TABLE2.new_contract_line_id IS NOT NULL AND TABLE2.new_Order_Line_Transaction_Type = 'cancelation' THEN 'Cancelled with Cancellation Contract'
															 WHEN TABLE2.new_contract_line_id IS NOT NULL AND TABLE2.new_contract_end_date  IS NULL THEN 'Auto-Renewal'
															 WHEN TABLE2.new_contract_line_id IS NOT NULL AND TABLE2.new_contract_end_date  IS NOT NULL THEN 'Regular Renewal'
															 WHEN TABLE2.new_contract_line_id IS NULL AND  CAST(table2.old_contract_end_date AS DATE) < GETDATE() THEN 'End Date expired without any cancellation or Evergreen Contract'
															 WHEN TABLE2.new_contract_line_id IS NULL AND  CAST(table2.old_contract_end_date AS DATE) > GETDATE() THEN 'End date not yet arrived'
														ELSE 'In-contract anomoly'
														END

														)
		


      WHEN TABLE2.Contract_type = 'Evergreen' THEN
														(
														CASE WHEN TABLE2.new_contract_line_id IS NULL AND TABLE2.old_contract_cancellation_date IS NOT NULL AND  TABLE2.calculated_cancellation_date > TABLE2.Calculated_end_date THEN 'Auto-Renewal'
															 WHEN TABLE2.new_contract_line_id IS NULL AND TABLE2.old_contract_cancellation_date IS NOT NULL AND  TABLE2.calculated_cancellation_date = TABLE2.Calculated_end_date THEN 'Cancelled without cancellation contract'
															 WHEN TABLE2.new_contract_line_id IS NOT NULL AND TABLE2.new_Order_Line_Transaction_Type = 'cancelation' AND  TABLE2.calculated_cancellation_date > TABLE2.Calculated_end_date THEN 'Auto-Renewal'
															 WHEN TABLE2.new_contract_line_id IS NOT NULL AND TABLE2.new_Order_Line_Transaction_Type = 'cancelation' AND  TABLE2.calculated_cancellation_date = TABLE2.Calculated_end_date THEN 'Cancelled with Cancellation Contract'
															 WHEN TABLE2.new_contract_line_id IS NOT NULL AND TABLE2.new_Order_Line_Transaction_Type = 'DeBooking' AND  TABLE2.calculated_cancellation_date = TABLE2.Calculated_end_date THEN 'Debooked'
															 WHEN TABLE2.new_contract_line_id IS NOT NULL AND TABLE2.new_contract_end_date  IS NULL  AND  TABLE2.calculated_cancellation_date > TABLE2.Calculated_end_date THEN 'Auto-Renewal'
															 WHEN TABLE2.new_contract_line_id IS NOT NULL AND TABLE2.new_contract_end_date  IS NULL  AND  TABLE2.calculated_cancellation_date = TABLE2.Calculated_end_date THEN 'Auto-Renewal'
															 WHEN TABLE2.new_contract_line_id IS NOT NULL AND TABLE2.new_contract_end_date  IS NOT NULL AND TABLE2.calculated_cancellation_date > TABLE2.Calculated_end_date THEN 'Auto-Renewal'
															 WHEN TABLE2.new_contract_line_id IS NOT NULL AND TABLE2.new_contract_end_date  IS NOT NULL AND TABLE2.calculated_cancellation_date = TABLE2.Calculated_end_date THEN 'Regular Renewal'
															 WHEN TABLE2.new_contract_line_id IS NULL AND TABLE2.old_contract_cancellation_date IS NULL THEN 'Auto-Renewal'
														ELSE 'Evergreen Anamoly'
														END
														)
ELSE 'Unknown'

END Renewal_Type_updated

 FROM 

(

SELECT dr.*,
NULL AS calculated_cancellation_date,
dr.old_contract_end_date AS Calculated_end_date

 FROM [dbo].[vw_Dollar_renewal_rate_logic] dr
WHERE dr.old_contract_end_date IS NOT NULL
AND dr.Finance_Product_Grouping_name IN ('SaaS - Cloud backup', 'SaaS - Cloud failover')

UNION ALL

SELECT Table1.*, dt.firstofMonth AS calculated_end_date FROM 
(
SELECT dr.*,  

CASE WHEN dr.old_contract_cancellation_date IS NULL AND dr.new_contract_line_id IS NOT NULL THEN  DATEFROMPARTS(YEAR(dr.new_contract_start_date), MONTH(dr.new_contract_start_date),1)
	 WHEN dr.old_contract_cancellation_date IS NULL AND dr.new_contract_line_id IS NULL THEN DATEADD(MONTH,1, (DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()),1)))
	 ELSE DATEFROMPARTS(YEAR(dr.old_contract_cancellation_date), MONTH(dr.old_contract_cancellation_date), 1)
END AS calculated_canacellation_date


 FROM [dbo].[vw_Dollar_renewal_rate_logic] dr
WHERE dr.old_contract_end_date IS NULL
AND dr.Finance_Product_Grouping_name IN ('SaaS - Cloud backup', 'SaaS - Cloud failover')

) table1
CROSS JOIN [dbo].[DimTime_monthwise] dt
WHERE DATEFROMPARTS(YEAR(table1.old_contract_start_date), MONTH(table1.old_contract_start_date), 1) <= dt.firstofmonth AND table1.calculated_canacellation_date >=dt.firstofmonth

)TABLE2
)




