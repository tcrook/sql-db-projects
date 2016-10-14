﻿CREATE TABLE [dbo].[EV_SF_DISTRICT__C] (
    [ID]                   NVARCHAR (18)  NULL,
    [OWNERID]              NVARCHAR (18)  NULL,
    [ISDELETED]            INT            NULL,
    [NAME]                 NVARCHAR (80)  NULL,
    [CURRENCYISOCODE]      NVARCHAR (3)   NULL,
    [CREATEDDATE]          DATETIME       NULL,
    [CREATEDBYID]          NVARCHAR (18)  NULL,
    [LASTMODIFIEDDATE]     DATETIME       NULL,
    [LASTMODIFIEDBYID]     NVARCHAR (18)  NULL,
    [SYSTEMMODSTAMP]       DATETIME       NULL,
    [CONNECTIONRECEIVEDID] NVARCHAR (18)  NULL,
    [CONNECTIONSENTID]     NVARCHAR (18)  NULL,
    [COUNTRY__C]           NVARCHAR (255) NULL,
    [DISTRICT__C]          NVARCHAR (255) NULL,
    [TERRITORY__C]         NVARCHAR (255) NULL,
    [SALES_REGION__C]      NVARCHAR (255) NULL
);


GO
CREATE NONCLUSTERED INDEX [x1609191517404EV_SF_DISTRICT__]
    ON [dbo].[EV_SF_DISTRICT__C]([ID] ASC);

