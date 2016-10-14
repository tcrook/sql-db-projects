
CREATE VIEW [dbo].[V__Custom_Alliance_Partner_Exclusion_List]
AS

-- 2016/06/22
-- This list of partners is provided by Chris P for purpose of excluding MSP partners from the CIU or CL views.
-- File was attached to email sent to Bryan Lee and Jeff Wu.

SELECT
	[t].*
FROM
(
VALUES
('Cequel Data Centers','Alliance Partner','MSP - pays monthly for ESR which got them on the list','OUT','4241','001A000000WB2abIAD'),
('Computer Services, Inc. (CSI) (HEIT, Inc.)','Alliance Partner','MSP/VAR ','KEEP','2981','001A0000001vCEIIA2'),
('Sungard Availability Services','Alliance Partner','Special contract','OUT','2783','001A0000001vBg9IAE'),
('DeltaCom, Inc','Alliance Partner','Special contract ','OUT','2842','001A0000001vBsVIAU'),
('Recall Canada','Alliance Partner','Special contract ','OUT','6424','001F000001AeuDzIAJ'),
('Fiserv','Alliance Partner','Special contract in Evault cloud, but moving to the new Fiserv MPA','OUT','4503','001F000000nwV7JIAU'),
('Adaptive Solutions, Inc.','Alliance Partner','MSP (but recently cancelled MSP agreement and should no longer be marked accordingly)/VAR','KEEP','2748','001A0000001vBbiIAE'),
('Charter Communications','Alliance Partner','Aggregate parnter - but cancelled agreement','OUT','3749','001A0000001vETTIA2'),
('CalTech','Alliance Partner','MSP/VAR - dirty account','KEEP','6644','001A0000001vCbJIAU'),
('D+H USA Corporation','Alliance Partner','MSP (onprem), but uses CBS skus','OUT','6647','001A0000001vEaLIAU'),
('Merge Healthcare','Alliance Partner','Aggregate parnter ','OuT','6658','001A000000ZDIqWIAX'),
('Recall','Alliance Partner','Special contract ','OUT','6660','001A000000GjqgKIAR'),
('I Core Networks','Alliance Partner','MSP, but has one CBS account for internal use','KEEP','6452','001F0000015I7q1IAC'),
('CUSA Technologies','Alliance Partner','Special contract in Evault cloud, but moving to the new Fiserv MPA','OUT','6636','001A0000001vBffIAE'),
('Stage2Data (CAN)','Alliance Partner','MSP/VAR ','KEEP','6652','001A0000001vEGNIA2'),
('B. Donald Kimball, Inc.','Alliance Partner','MSP/VAR ','KEEP','3904','001A0000007apGCIAY'),
('Abtech Systems','Alliance Partner','MSP/VAR ','KEEP','4013','001A000000F3hRGIAZ'),
('Corus Group LLC','Alliance Partner','MSP/VAR ','KEEP','3959','001A000000asW6hIAE'),
('Alliance Technologies Inc','Alliance Partner','Not under MSP management, but pays royalty?  Will review with Perdue','','4218','001A000000Sv55cIAB'),
('XO Communications','Alliance Partner','Special contract','OUT','3779','001A0000001vEYpIAM'),
('VC3','Alliance Partner','MSP/VAR ','KEEP','3989','001A000000dga6uIAA'),
('Fiserv Solutions, Inc Banking','Alliance Partner','Adjusting to full MSP agreement - parent company','OUT','8033','001A0000001vBv7IAE'),
('Recall do Brasil Ltda.','Alliance Partner','Special contract ','OUT','12292','001F000000kl6DfIAI'),
('Recall Total Information Management Pte Ltd','Alliance Partner','Special contract ','OUT','12672','001F000000rqCOWIA2'),
('Adam Continuity Limited','Alliance Partner','EMEA','KEEP','13609','001A000000GjrdWIAR'),
('Mti Technology Ltd.','Alliance Partner','EMEA','KEEP','13673','001A0000001vEZCIA2')
) [t] ([Customer],[Customer_Account_Type],[Comment],[Keep_Or_Out],[Customer_ID],[Customer_SFDC_ID])



