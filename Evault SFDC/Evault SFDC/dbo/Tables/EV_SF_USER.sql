﻿CREATE TABLE [dbo].[EV_SF_USER] (
    [ID]                                                 NVARCHAR (18)    NULL,
    [USERNAME]                                           NVARCHAR (80)    NULL,
    [LASTNAME]                                           NVARCHAR (80)    NULL,
    [FIRSTNAME]                                          NVARCHAR (40)    NULL,
    [NAME]                                               NVARCHAR (121)   NULL,
    [COMPANYNAME]                                        NVARCHAR (80)    NULL,
    [DIVISION]                                           NVARCHAR (80)    NULL,
    [DEPARTMENT]                                         NVARCHAR (80)    NULL,
    [TITLE]                                              NVARCHAR (80)    NULL,
    [STREET]                                             NVARCHAR (255)   NULL,
    [CITY]                                               NVARCHAR (40)    NULL,
    [STATE]                                              NVARCHAR (80)    NULL,
    [POSTALCODE]                                         NVARCHAR (20)    NULL,
    [COUNTRY]                                            NVARCHAR (80)    NULL,
    [LATITUDE]                                           DECIMAL (18, 15) NULL,
    [LONGITUDE]                                          DECIMAL (18, 15) NULL,
    [EMAIL]                                              NVARCHAR (128)   NULL,
    [EMAILPREFERENCESAUTOBCC]                            INT              NULL,
    [EMAILPREFERENCESAUTOBCCSTAYINTOUCH]                 INT              NULL,
    [EMAILPREFERENCESSTAYINTOUCHREMINDER]                INT              NULL,
    [SENDEREMAIL]                                        NVARCHAR (80)    NULL,
    [SENDERNAME]                                         NVARCHAR (80)    NULL,
    [SIGNATURE]                                          NVARCHAR (1333)  NULL,
    [STAYINTOUCHSUBJECT]                                 NVARCHAR (80)    NULL,
    [STAYINTOUCHSIGNATURE]                               NVARCHAR (512)   NULL,
    [STAYINTOUCHNOTE]                                    NVARCHAR (512)   NULL,
    [PHONE]                                              NVARCHAR (40)    NULL,
    [FAX]                                                NVARCHAR (40)    NULL,
    [MOBILEPHONE]                                        NVARCHAR (40)    NULL,
    [ALIAS]                                              NVARCHAR (8)     NULL,
    [COMMUNITYNICKNAME]                                  NVARCHAR (40)    NULL,
    [ISBADGED]                                           INT              NULL,
    [ISACTIVE]                                           INT              NULL,
    [TIMEZONESIDKEY]                                     NVARCHAR (40)    NULL,
    [USERROLEID]                                         NVARCHAR (18)    NULL,
    [LOCALESIDKEY]                                       NVARCHAR (40)    NULL,
    [RECEIVESINFOEMAILS]                                 INT              NULL,
    [RECEIVESADMININFOEMAILS]                            INT              NULL,
    [EMAILENCODINGKEY]                                   NVARCHAR (40)    NULL,
    [DEFAULTCURRENCYISOCODE]                             NVARCHAR (3)     NULL,
    [CURRENCYISOCODE]                                    NVARCHAR (3)     NULL,
    [PROFILEID]                                          NVARCHAR (18)    NULL,
    [USERTYPE]                                           NVARCHAR (40)    NULL,
    [LANGUAGELOCALEKEY]                                  NVARCHAR (40)    NULL,
    [EMPLOYEENUMBER]                                     NVARCHAR (20)    NULL,
    [DELEGATEDAPPROVERID]                                NVARCHAR (18)    NULL,
    [MANAGERID]                                          NVARCHAR (18)    NULL,
    [LASTLOGINDATE]                                      DATETIME         NULL,
    [LASTPASSWORDCHANGEDATE]                             DATETIME         NULL,
    [CREATEDDATE]                                        DATETIME         NULL,
    [CREATEDBYID]                                        NVARCHAR (18)    NULL,
    [LASTMODIFIEDDATE]                                   DATETIME         NULL,
    [LASTMODIFIEDBYID]                                   NVARCHAR (18)    NULL,
    [SYSTEMMODSTAMP]                                     DATETIME         NULL,
    [OFFLINETRIALEXPIRATIONDATE]                         DATETIME         NULL,
    [OFFLINEPDATRIALEXPIRATIONDATE]                      DATETIME         NULL,
    [USERPERMISSIONSMARKETINGUSER]                       INT              NULL,
    [USERPERMISSIONSOFFLINEUSER]                         INT              NULL,
    [USERPERMISSIONSAVANTGOUSER]                         INT              NULL,
    [USERPERMISSIONSCALLCENTERAUTOLOGIN]                 INT              NULL,
    [USERPERMISSIONSMOBILEUSER]                          INT              NULL,
    [USERPERMISSIONSSFCONTENTUSER]                       INT              NULL,
    [USERPERMISSIONSKNOWLEDGEUSER]                       INT              NULL,
    [USERPERMISSIONSINTERACTIONUSER]                     INT              NULL,
    [USERPERMISSIONSSUPPORTUSER]                         INT              NULL,
    [USERPERMISSIONSCHATTERANSWERSUSER]                  INT              NULL,
    [FORECASTENABLED]                                    INT              NULL,
    [USERPREFERENCESACTIVITYREMINDERSPOPUP]              INT              NULL,
    [USERPREFERENCESEVENTREMINDERSCHECKBOXDEFAULT]       INT              NULL,
    [USERPREFERENCESTASKREMINDERSCHECKBOXDEFAULT]        INT              NULL,
    [USERPREFERENCESREMINDERSOUNDOFF]                    INT              NULL,
    [USERPREFERENCESDISABLEALLFEEDSEMAIL]                INT              NULL,
    [USERPREFERENCESDISABLEFOLLOWERSEMAIL]               INT              NULL,
    [USERPREFERENCESDISABLEPROFILEPOSTEMAIL]             INT              NULL,
    [USERPREFERENCESDISABLECHANGECOMMENTEMAIL]           INT              NULL,
    [USERPREFERENCESDISABLELATERCOMMENTEMAIL]            INT              NULL,
    [USERPREFERENCESDISPROFPOSTCOMMENTEMAIL]             INT              NULL,
    [USERPREFERENCESCONTENTNOEMAIL]                      INT              NULL,
    [USERPREFERENCESCONTENTEMAILASANDWHEN]               INT              NULL,
    [USERPREFERENCESAPEXPAGESDEVELOPERMODE]              INT              NULL,
    [USERPREFERENCESHIDECSNGETCHATTERMOBILETASK]         INT              NULL,
    [USERPREFERENCESDISABLEMENTIONSPOSTEMAIL]            INT              NULL,
    [USERPREFERENCESDISMENTIONSCOMMENTEMAIL]             INT              NULL,
    [USERPREFERENCESHIDECSNDESKTOPTASK]                  INT              NULL,
    [USERPREFERENCESHIDECHATTERONBOARDINGSPLASH]         INT              NULL,
    [USERPREFERENCESHIDESECONDCHATTERONBOARDINGSPLASH]   INT              NULL,
    [USERPREFERENCESDISCOMMENTAFTERLIKEEMAIL]            INT              NULL,
    [USERPREFERENCESDISABLELIKEEMAIL]                    INT              NULL,
    [USERPREFERENCESSORTFEEDBYCOMMENT]                   INT              NULL,
    [USERPREFERENCESDISABLEMESSAGEEMAIL]                 INT              NULL,
    [USERPREFERENCESDISABLEBOOKMARKEMAIL]                INT              NULL,
    [USERPREFERENCESDISABLESHAREPOSTEMAIL]               INT              NULL,
    [USERPREFERENCESENABLEAUTOSUBFORFEEDS]               INT              NULL,
    [USERPREFERENCESDISABLEFILESHARENOTIFICATIONSFORAPI] INT              NULL,
    [USERPREFERENCESSHOWTITLETOEXTERNALUSERS]            INT              NULL,
    [USERPREFERENCESSHOWMANAGERTOEXTERNALUSERS]          INT              NULL,
    [USERPREFERENCESSHOWEMAILTOEXTERNALUSERS]            INT              NULL,
    [USERPREFERENCESSHOWWORKPHONETOEXTERNALUSERS]        INT              NULL,
    [USERPREFERENCESSHOWMOBILEPHONETOEXTERNALUSERS]      INT              NULL,
    [USERPREFERENCESSHOWFAXTOEXTERNALUSERS]              INT              NULL,
    [USERPREFERENCESSHOWSTREETADDRESSTOEXTERNALUSERS]    INT              NULL,
    [USERPREFERENCESSHOWCITYTOEXTERNALUSERS]             INT              NULL,
    [USERPREFERENCESSHOWSTATETOEXTERNALUSERS]            INT              NULL,
    [USERPREFERENCESSHOWPOSTALCODETOEXTERNALUSERS]       INT              NULL,
    [USERPREFERENCESSHOWCOUNTRYTOEXTERNALUSERS]          INT              NULL,
    [USERPREFERENCESSHOWPROFILEPICTOGUESTUSERS]          INT              NULL,
    [USERPREFERENCESSHOWTITLETOGUESTUSERS]               INT              NULL,
    [USERPREFERENCESSHOWCITYTOGUESTUSERS]                INT              NULL,
    [USERPREFERENCESSHOWSTATETOGUESTUSERS]               INT              NULL,
    [USERPREFERENCESSHOWPOSTALCODETOGUESTUSERS]          INT              NULL,
    [USERPREFERENCESSHOWCOUNTRYTOGUESTUSERS]             INT              NULL,
    [USERPREFERENCESHIDES1BROWSERUI]                     INT              NULL,
    [USERPREFERENCESDISABLEENDORSEMENTEMAIL]             INT              NULL,
    [USERPREFERENCESLIGHTNINGEXPERIENCEPREFERRED]        INT              NULL,
    [CONTACTID]                                          NVARCHAR (18)    NULL,
    [ACCOUNTID]                                          NVARCHAR (18)    NULL,
    [CALLCENTERID]                                       NVARCHAR (18)    NULL,
    [EXTENSION]                                          NVARCHAR (40)    NULL,
    [PORTALROLE]                                         NVARCHAR (40)    NULL,
    [ISPORTALENABLED]                                    INT              NULL,
    [ISPORTALSELFREGISTERED]                             INT              NULL,
    [FEDERATIONIDENTIFIER]                               NVARCHAR (512)   NULL,
    [ABOUTME]                                            NVARCHAR (1000)  NULL,
    [FULLPHOTOURL]                                       NVARCHAR (1024)  NULL,
    [SMALLPHOTOURL]                                      NVARCHAR (1024)  NULL,
    [DIGESTFREQUENCY]                                    NVARCHAR (40)    NULL,
    [DEFAULTGROUPNOTIFICATIONFREQUENCY]                  NVARCHAR (40)    NULL,
    [LASTVIEWEDDATE]                                     DATETIME         NULL,
    [LASTREFERENCEDDATE]                                 DATETIME         NULL,
    [SR_SUPPORT_AGENT__C]                                NVARCHAR (18)    NULL,
    [GEO__C]                                             NVARCHAR (20)    NULL,
    [REGION__C]                                          NVARCHAR (30)    NULL,
    [SLUID__C]                                           NVARCHAR (20)    NULL,
    [SALES_REGION__C]                                    NVARCHAR (255)   NULL,
    [CRM__C]                                             NVARCHAR (18)    NULL,
    [MKTO_SI__ISCACHINGANONWEBACTIVITYLIST__C]           INT              NULL,
    [MANAGER__C]                                         NVARCHAR (18)    NULL,
    [VP_DIRECTOR__C]                                     NVARCHAR (18)    NULL,
    [ISR__C]                                             NVARCHAR (18)    NULL,
    [ISA__C]                                             NVARCHAR (18)    NULL,
    [TAM__C]                                             NVARCHAR (18)    NULL,
    [SLXID__C]                                           NVARCHAR (20)    NULL,
    [MKTO_SI__SALES_INSIGHT_COUNTER__C]                  DECIMAL (4)      NULL,
    [PARTNER_MANAGER__C]                                 NVARCHAR (18)    NULL,
    [PORTAL_USER_COMPANY_NAME__C]                        NVARCHAR (1300)  NULL,
    [SERVER_URL__C]                                      NVARCHAR (1300)  NULL,
    [IS_CP_PASSWORD_GENERATED__C]                        INT              NULL,
    [TERRITORY__C]                                       NVARCHAR (255)   NULL,
    [DIRECTOR__C]                                        NVARCHAR (18)    NULL,
    [USER_ACTIVE_STATUS__C]                              NVARCHAR (1300)  NULL,
    [IS_PARTNER_ORDERING_ENABLED__C]                     INT              NULL,
    [COST_CENTER__C]                                     NVARCHAR (100)   NULL,
    [COST_CENTER_DEPT__C]                                NVARCHAR (255)   NULL,
    [COST_CENTER_NAME__C]                                NVARCHAR (255)   NULL,
    [LICENSESERVERACCESS__C]                             NVARCHAR (255)   NULL,
    [QBDIALER__INSIDESALES_ADMIN__C]                     INT              NULL,
    [QBDIALER__IS_SUBDOMAIN__C]                          NVARCHAR (20)    NULL,
    [QBDIALER__IS_TOKEN__C]                              NVARCHAR (128)   NULL,
    [QBDIALER__PASSWORD__C]                              NVARCHAR (16)    NULL,
    [QBDIALER__USERNAME__C]                              NVARCHAR (55)    NULL,
    [MKTO_SI__ISCACHINGBESTBETS__C]                      INT              NULL,
    [MKTO_SI__ISCACHINGEMAILACTIVITYLIST__C]             INT              NULL,
    [MKTO_SI__ISCACHINGGROUPEDWEBACTIVITYLIST__C]        INT              NULL,
    [MKTO_SI__ISCACHINGINTERESTINGMOMENTSLIST__C]        INT              NULL,
    [MKTO_SI__ISCACHINGSCORINGLIST__C]                   INT              NULL,
    [MKTO_SI__ISCACHINGSTREAMLIST__C]                    INT              NULL,
    [MKTO_SI__ISCACHINGWATCHLIST__C]                     INT              NULL,
    [MKTO_SI__ISCACHINGWEBACTIVITYLIST__C]               INT              NULL,
    [SALES_ORG__C]                                       NVARCHAR (255)   NULL,
    [WEBCCUSERID__C]                                     NVARCHAR (255)   NULL,
    [G2A4SF__G2A_PASSWORD__C]                            NVARCHAR (255)   NULL,
    [G2A4SF__G2A_USERNAME__C]                            NVARCHAR (80)    NULL,
    [CLOUD9_SALES_ORG__C]                                NVARCHAR (255)   NULL,
    [VIP_SUPPORT__C]                                     INT              NULL,
    [CLOUD9_DIRECTOR_PICKLIST__C]                        NVARCHAR (255)   NULL,
    [LONG_USER_ID__C]                                    NVARCHAR (1300)  NULL,
    [SE__C]                                              NVARCHAR (18)    NULL,
    [QBDIALER__PERMISSIONS__C]                           NTEXT            NULL,
    [INTEGRATION_ERROR__C]                               NVARCHAR (255)   NULL,
    [NETSUITE_ID__C]                                     NVARCHAR (10)    NULL,
    [DSFS__DSPROSFMEMBERSHIPSTATUS__C]                   NVARCHAR (100)   NULL,
    [DSFS__DSPROSFPASSWORD__C]                           NVARCHAR (100)   NULL,
    [DSFS__DSPROSFUSERNAME__C]                           NVARCHAR (50)    NULL,
    [SALES_ROLE__C]                                      NVARCHAR (255)   NULL,
    [OUT_OF_OFFICE__C]                                   INT              NULL,
    [BUSINESSLINE__C]                                    NVARCHAR (255)   NULL,
    [HIRE_DATE__C]                                       DATETIME         NULL,
    [FROZEN__C]                                          INT              NULL,
    [OUT_OF_OFFICE_ROLE__C]                              NVARCHAR (255)   NULL
);


GO
CREATE NONCLUSTERED INDEX [x1609191719111EV_SF_USER_ID]
    ON [dbo].[EV_SF_USER]([ID] ASC);

