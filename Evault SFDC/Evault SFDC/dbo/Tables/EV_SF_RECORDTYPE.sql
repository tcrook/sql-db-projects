﻿CREATE TABLE [dbo].[EV_SF_RECORDTYPE] (
    [ID]                NVARCHAR (18)  NULL,
    [NAME]              NVARCHAR (80)  NULL,
    [DEVELOPERNAME]     NVARCHAR (80)  NULL,
    [NAMESPACEPREFIX]   NVARCHAR (15)  NULL,
    [DESCRIPTION]       NVARCHAR (255) NULL,
    [BUSINESSPROCESSID] NVARCHAR (18)  NULL,
    [SOBJECTTYPE]       NVARCHAR (40)  NULL,
    [ISACTIVE]          INT            NULL,
    [CREATEDBYID]       NVARCHAR (18)  NULL,
    [CREATEDDATE]       DATETIME       NULL,
    [LASTMODIFIEDBYID]  NVARCHAR (18)  NULL,
    [LASTMODIFIEDDATE]  DATETIME       NULL,
    [SYSTEMMODSTAMP]    DATETIME       NULL
);


GO
CREATE NONCLUSTERED INDEX [x1609191554155EV_SF_RECORDTYPE]
    ON [dbo].[EV_SF_RECORDTYPE]([ID] ASC);

